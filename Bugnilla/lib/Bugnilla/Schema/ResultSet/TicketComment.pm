package Bugnilla::Schema::ResultSet::TicketComment;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

=head2 get_comments_by_ticket_id

A predefined search for ticket comments

=cut

sub get_comments_by_ticket_id {
    my ($self, $ticket_id) = @_;
    return $self->search({
        ticket_id => $ticket_id
    });
}

1;
