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


=encoding utf8

=head1 AUTHOR

Han Do Jin

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
