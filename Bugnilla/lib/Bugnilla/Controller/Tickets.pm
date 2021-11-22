package Bugnilla::Controller::Tickets;
use Moose;
use namespace::autoclean;

#BEGIN { extends 'Catalyst::Controller'; }
BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

Bugnilla::Controller::Tickets - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Bugnilla::Controller::Tickets in Tickets.');
}

=head2 list
 
Fetch all ticket objects and pass to tickets/list.tt2 in stash to be displayed
 
=cut

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ($self, $c) = @_;
 
    # Get the status options from the DB
    my @status_objs = $c->model("DB::Status")->all();
    # Create an array of arrayrefs where each arrayref is an status
    my @statuses;
    # order by id so New shows up first
    foreach (sort {$a->id cmp $b->id} @status_objs) {
        push(@statuses, {id => $_->id, status => $_->status});
    }
    $c->stash(statuses => \@statuses); # used by template to show current filter

    # Retrieve all of the ticket records as ticket model objects and store in the
    # stash where they can be accessed by the TT template
    $c->stash(tickets => [$c->model('DB::Ticket')->all]);

    # Set the TT template to use.  You will almost always want to do this
    # in your action methods (action methods respond to user input in
    # your controllers).
    $c->stash(template => 'tickets/list.tt2'); # this is default so no need to specify unless you want to use $c->forward or $c->detach
}

=head2 filter_list
 
Fetch all ticket objects and pass to tickets/list.tt2 in stash to be displayed
 
=cut

sub filter_list :Chained('base') :PathPart('filter_list') :Args(1) {
    my ($self, $c, $status_id) = @_;
    $c->stash(current_status_id => $status_id); # used by template to show current filter

    # show the clear filter link in the template
    $c->stash(filtered => 1);

    # Get the status options from the DB
    my @status_objs = $c->model("DB::Status")->all();
    # Create an array of arrayrefs where each arrayref is an status
    my @statuses;
    # order by id so New shows up first
    foreach (sort {$a->id cmp $b->id} @status_objs) {
        push(@statuses, {id => $_->id, status => $_->status});
    }
    $c->stash(statuses => \@statuses); # used by template to show current filter
 
    $c->stash(tickets => [$c->model('DB::Ticket')->search({status_id => $status_id})]);

    $c->stash(template => 'tickets/list.tt2');
}

=head2 url_create

Create a ticket with the supplied title, status_id (default should be "New", and assignedto_user_id can be blank (unassigned)

=cut

# NOTE: This isn't used by anything. This could be the start of our REST API if we chang ethe output to json
sub url_create :Chained('base') :PathPart('url_create') :Args(3) {
    # In addition to self & context, get the title, status_id, &
    # assignedto_user_id args from the URL.  Note that Catalyst automatically
    # puts extra information after the "/<controller_name>/<action_name/"
    # into @_.  The args are separated  by the '/' char on the URL.
    my ($self, $c, $title, $status_id, $assignedto_user_id) = @_;

    # Check the user's roles
    $c->log->debug('*** URL CREATE CHECK AUTH ***');
    if ($c->check_user_roles('Admin') || $c->check_user_roles('Developer')) {
        # Call create() on the ticket model object. Pass the table
        # columns/field values we want to set as hash values
        my $ticket = $c->model('DB::Ticket')->create({
                title  => $title
                , status_id => $status_id
                , assignedto_user_id => $assignedto_user_id
            });

        # Assign the Ticket object to the stash for display and set template
        $c->stash(ticket     => $ticket,
                  template => 'tickets/create_done.tt2');

    } else {
        # Provide very simple feedback to the user.
        $c->response->body('Unauthorized!');
    }

    # Disable caching for this page
#    $c->response->header('Cache-Control' => 'no-cache');
}

=head2 base
 
Can place common logic to start chained dispatch here
 
=cut
 
sub base :Chained('/') :PathPart('tickets') :CaptureArgs(0) {
    my ($self, $c) = @_;
 
    # Store the ResultSet in stash so it's available for other methods
    $c->stash(resultset => $c->model('DB::Ticket'));
 
    # Print a message to the debug log
    $c->log->debug('*** INSIDE BASE METHOD ***');

    # Load status messages (Catalyst::Plugin::StatusMessage)
    $c->load_status_msgs;
}

=head2 get_ticket_object
 
Fetch the specified ticket object based on the ticket ID and store
it in the stash
 
=cut
 
sub get_ticket_object :Chained('base') :PathPart('id') :CaptureArgs(1) {
    # $id = primary key of ticket to delete
    my ($self, $c, $id) = @_;
 
    # Find the ticket object and store it in the stash
    $c->stash(ticket_object => $c->stash->{resultset}->find($id));
 
    # Make sure the lookup was successful.  You would probably
    # want to do something like this in a real app:
    #   $c->detach('/error_404') if !$c->stash->{ticket_object};
    die "Ticket $id not found!" if !$c->stash->{ticket_object};
 
    # Print a message to the debug log
    $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
}

=head2 delete
 
Delete a ticket
 
=cut
 
sub delete :Chained('get_ticket_object') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;
 
    # Check permissions
    # https://metacpan.org/pod/Catalyst::Authentication::User#get_object(-)
    # notice get_object() belongs to User but can't be seen in the code. Since it inherits from Catalyst::Authentication::User
    # don't get confused that this is different than get_ticket_object() or 'sub object' from the tutorial, which I changed because it was too generic
    $c->detach('/error_noperms')
        unless $c->stash->{ticket_object}->delete_allowed_by($c->user->get_object);
 
    # Saved the PK id for status_msg below
    my $ticket_id = $c->stash->{ticket_object}->id;

    $c->log->debug("*** INSIDE DELETE METHOD for obj id=$ticket_id ***");

    # Use the ticket object saved by 'get_ticket_object' and delete it
    $c->stash->{ticket_object}->delete;
 
    # Set a status message to be displayed at the top of the view
    #$c->flash->{status_msg} = "Ticket deleted.";
 
    # Forward to the list action/method in this controller
    #$c->forward('list');
    #$c->response->redirect($c->uri_for($self->action_for('list'), {status_msg => "Ticket deleted."}));
    #$c->response->redirect($c->uri_for($self->action_for('list'))); # flash method
    # Redirect the user back to the list page using StatusMessage instead - 
    # set_status_msg() and set_error_msg() are from Catalyst::Plugin::StatusMessage
    $c->response->redirect($c->uri_for($self->action_for('list'), {mid => $c->set_status_msg("Deleted ticket $ticket_id")}));
}

=head2 list_recent
 
List recently created tickets
 
=cut
 
sub list_recent :Chained('base') :PathPart('list_recent') :Args(1) {
    my ($self, $c, $mins) = @_;
 
    # Retrieve all of the ticket records as ticket model objects and store in the
    # stash where they can be accessed by the TT template, but only
    # retrieve tickets created within the last $min number of minutes
    $c->stash(tickets => [$c->model('DB::Ticket')
                            ->created_after(DateTime->now->subtract(minutes => $mins))]);
 
    # Set the TT template to use.  You will almost always want to do this
    # in your action methods (action methods respond to user input in
    # your controllers).
    $c->stash(template => 'tickets/list.tt2');
}

=head2 list_recent_tcp
 
List recently created tickets with "tcp" in the title
 
=cut
 
sub list_recent_tcp :Chained('base') :PathPart('list_recent_tcp') :Args(1) {
    my ($self, $c, $mins) = @_;
 
    # Retrieve all of the ticket records as ticket model objects and store in the
    # stash where they can be accessed by the TT template, but only
    # retrieve tickets created within the last $min number of minutes
    # AND that have 'TCP' in the title
    $c->stash(tickets => [
            $c->model('DB::Ticket')
                ->created_after(DateTime->now->subtract(minutes => $mins))
                ->title_like('TCP')
        ]);
 
    # Set the TT template to use.  You will almost always want to do this
    # in your action methods (action methods respond to user input in
    # your controllers).
    $c->stash(template => 'tickets/list.tt2');
}

=head2 create
 
Use HTML::FormFu to create a new ticket
 
=cut
 
sub create :Chained('base') :PathPart('create') :Args(0) :FormConfig {
    my ($self, $c) = @_;
 
    # Get the form that the :FormConfig attribute saved in the stash
    my $form = $c->stash->{form};
 
    # Check if the form has been submitted (vs. displaying the initial
    # form) and if the data passed validation.  "submitted_and_valid"
    # is shorthand for "$form->submitted && !$form->has_errors"
    if ($form->submitted_and_valid) {
        # Create a new ticket
        # add createdby_user_id if it is available (log who made the ticket if not anonymous)
        my $current_user_id = $c->user()->id if $c->user;
        my $ticket = $c->model('DB::Ticket')->new_result({createdby_user_id => $current_user_id});

        # Save the form data for the ticket
        $form->model->update($ticket);

        # a bit of customization here to allow anonymous users to post, but not land on the list page
        if ($c->user) {
            # Set a status message for the user & return to tickets list
            $c->response->redirect($c->uri_for($self->action_for('list'),
                {mid => $c->set_status_msg("Ticket created: #" . $ticket->id)}));
            $c->detach;
        } else {
            # provide a decent confirmation to the anonymous submitter
            $c->stash(ticket     => $ticket,
                      template => 'tickets/create_done.tt2');
            return 1;
        }
    } else {
        # Get the users from the DB
        my @user_objs = $c->model("DB::User")->all();
        # Create an array of arrayrefs where each arrayref is an user
        my @users;
        foreach (sort {$a->first_name cmp $b->first_name} @user_objs) {
            push(@users, [$_->id, $_->first_name]);
        }
        # Get the select added by the config file
        my $select = $form->get_element({type => 'Select', name => 'assignedto_user_id'});
        # Add the users to it
        $select->options(\@users);

        # Get the status options from the DB
        my @status_objs = $c->model("DB::Status")->all();
        # Create an array of arrayrefs where each arrayref is an status
        my @statuses;
        # order by id so New shows up first
        foreach (sort {$a->id cmp $b->id} @status_objs) {
            push(@statuses, [$_->id, $_->status]);
        }
        # Get the select added by the config file
        my $select2 = $form->get_element({type => 'Select', name => 'status_id'});
        # Add the statuses to it
        $select2->options(\@statuses);
    }
 
    # Set the template
    $c->stash(template => 'tickets/formfu_create.tt2');
}

=head2 edit
 
Use HTML::FormFu to update an existing ticket
 
=cut
 
sub edit :Chained('get_ticket_object') :PathPart('edit') :Args(0)
        :FormConfig('tickets/create.conf') {
    my ($self, $c) = @_;

    $c->log->debug('*** SUB EDIT CHECK PERMISSIONS ***');
    $c->detach('/error_noperms')
        unless $c->stash->{ticket_object}->edit_allowed_by($c->user->get_object);

    # Get the specified ticket already saved by the 'ticket_object' method
    my $ticket = $c->stash->{ticket_object};
 
    # Make sure we were able to get a ticket
    unless ($ticket) {
        # Set an error message for the user & return to tickets list
        $c->response->redirect($c->uri_for($self->action_for('list'),
            {mid => $c->set_error_msg("Invalid ticket -- Cannot Edit")}));
        $c->detach;
    }
 
    # Get the form that the :FormConfig attribute saved in the stash
    my $form = $c->stash->{form};
 
    # Check if the form has been submitted (vs. displaying the initial
    # form) and if the data passed validation.  "submitted_and_valid"
    # is shorthand for "$form->submitted && !$form->has_errors"
    if ($form->submitted_and_valid) {
        # Save the form data for the ticket
        $form->model->update($ticket);
        # Set a status message for the user & return to tickets list
        $c->response->redirect($c->uri_for($self->action_for('list'),
            {mid => $c->set_status_msg("Ticket edited: #" . $ticket->id)}));
        $c->detach;
    } else {
        # Get the users from the DB
        my @user_objs = $c->model("DB::User")->all();
        # Create an array of arrayrefs where each arrayref is an user
        my @users;
        foreach (sort {$a->first_name cmp $b->first_name} @user_objs) {
            push(@users, [$_->id, $_->first_name]);
        }
        # Get the select added by the config file
        my $select = $form->get_element({type => 'Select', name => 'assignedto_user_id'});
        # Add the users to it
        $select->options(\@users);
        # Populate the form with existing values from DB
        $form->model->default_values($ticket);

        # Get the statuses from the DB
        my @status_objs = $c->model("DB::Status")->all();
        # Create an array of arrayrefs where each arrayref is an status
        my @statuses;
        foreach (sort {$a->status cmp $b->status} @status_objs) {
            push(@statuses, [$_->id, $_->status]);
        }
        # Get the select added by the config file
        my $select2 = $form->get_element({type => 'Select', name => 'status_id'});
        # Add the statuses to it
        $select2->options(\@statuses);
        # Populate the form with existing values from DB
        $form->model->default_values($ticket);
    }
 
    # Set the template
    $c->stash(template => 'tickets/formfu_create.tt2');
}

=head2 edit
 
View a ticket, allow commenting
 
=cut
 
sub view :Chained('get_ticket_object') :PathPart('view') :Args(0) {
    my ($self, $c) = @_;

    $c->log->debug('*** SUB VIEW CHECK PERMISSIONS ***');
    $c->detach('/error_noperms')
        unless $c->stash->{ticket_object}->comment_allowed_by($c->user->get_object);

    # Get the specified ticket already saved by the 'ticket_object' method
    my $ticket = $c->stash->{ticket_object};
 
    # Make sure we were able to get a ticket
    unless ($ticket) {
        # Set an error message for the user & return to tickets list
        $c->response->redirect($c->uri_for($self->action_for('list'),
            {mid => $c->set_error_msg("Invalid ticket -- Cannot View")}));
        $c->detach;
    }

    $c->stash(ticket => $ticket);

    # get the comments for this ticket
    # get_comments_by_ticket_id() or get_comments()?
    # get_comments(0 is a join, get_comments_by_ticket_id() is only selecting from ticket_comments table
    #$c->stash(ticket_comments => [$c->model('DB::Ticket')->get_comments($ticket->id)]);
    # or
    $c->stash(ticket_comments => [$c->model('DB::TicketComment')->get_comments_by_ticket_id($ticket->id)]);

    $c->stash(template => 'tickets/view.tt2');
}



=encoding utf8

=head1 AUTHOR

Han Do Jin

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
