package Bugnilla::Controller::Tickets;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

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
    # Retrieve the usual Perl OO '$self' for this object. $c is the Catalyst
    # 'Context' that's used to 'glue together' the various components
    # that make up the application
    my ($self, $c) = @_;
 
    # Retrieve all of the ticket records as ticket model objects and store in the
    # stash where they can be accessed by the TT template
    $c->stash(tickets => [$c->model('DB::Ticket')->all]);

    # Set the TT template to use.  You will almost always want to do this
    # in your action methods (action methods respond to user input in
    # your controllers).
    $c->stash(template => 'tickets/list.tt2'); # this is default so no need to specify unless you want to use $c->forward or $c->detach
}

=head2 url_create

Create a ticket with the supplied title, status_id (default should be "New", and developer_id can be blank (unassigned)

=cut
 
sub url_create :Chained('base') :PathPart('url_create') :Args(3) {
    # In addition to self & context, get the title, status_id, &
    # developer_id args from the URL.  Note that Catalyst automatically
    # puts extra information after the "/<controller_name>/<action_name/"
    # into @_.  The args are separated  by the '/' char on the URL.
    my ($self, $c, $title, $status_id, $developer_id) = @_;

    # Check the user's roles
    $c->log->debug('*** URL CREATE CHECK AUTH ***');
    if ($c->check_user_roles('admin') || $c->check_user_roles('developer')) {
        # Call create() on the ticket model object. Pass the table
        # columns/field values we want to set as hash values
        my $ticket = $c->model('DB::Ticket')->create({
                title  => $title
                , status_id => $status_id
                , developer_id => $developer_id
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

=head2 create_form
 
Display form to collect information for ticket to create
 
=cut
 
sub create_form :Chained('base') :PathPart('create_form') :Args(0) {
    my ($self, $c) = @_;
 
    # Set the TT template to use
    $c->stash(template => 'tickets/create_form.tt2');
}

=head2 create_form_do
 
Take information from form and add to database
 
=cut
 
sub create_form_do :Chained('base') :PathPart('create_form_do') :Args(0) {
    my ($self, $c) = @_;
 
    # Retrieve the values from the form
    my $title     = $c->request->params->{title}     || 'N/A';
    my $status_id    = $c->request->params->{status_id}    || 'N/A';
    my $developer_id = $c->request->params->{developer_id} || '1';
 
    # Create the ticket
    my $ticket = $c->model('DB::Ticket')->create({
            title   => $title,
            status_id  => $status_id,
            developer_id  => $developer_id,
        });
 
    # Store new model object in stash and set template
    $c->stash(ticket   => $ticket,
              template => 'tickets/create_done.tt2');
}

=head2 object
 
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



=encoding utf8

=head1 AUTHOR

Han Do Jin

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
