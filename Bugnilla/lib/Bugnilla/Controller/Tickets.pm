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
 
sub list :Local {
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
 
sub url_create :Local {
    # In addition to self & context, get the title, status_id, &
    # developer_id args from the URL.  Note that Catalyst automatically
    # puts extra information after the "/<controller_name>/<action_name/"
    # into @_.  The args are separated  by the '/' char on the URL.
    my ($self, $c, $title, $status_id, $developer_id) = @_;

    # Call create() on the ticket model object. Pass the table
    # columns/field values we want to set as hash values
    my $ticket = $c->model('DB::Ticket')->create({
            title  => $title
#            , status_id => $status_id
#            , developer_id => $developer_id
        });

    # Add a record to the join table for this ticket, mapping to
    # appropriate author
    #$ticket->add_to_ticket_authors({developer_id => $developer_id});
    # Note: Above is a shortcut for this:
    # $ticket->create_related('ticket_authors', {developer_id => $developer_id});

    # Assign the Ticket object to the stash for display and set template
    $c->stash(ticket     => $ticket,
              template => 'tickets/create_done.tt2');

    # Disable caching for this page
    $c->response->header('Cache-Control' => 'no-cache');
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
