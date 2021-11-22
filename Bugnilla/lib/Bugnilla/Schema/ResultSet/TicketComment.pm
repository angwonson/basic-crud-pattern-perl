package Bugnilla::Schema::ResultSet::TicketComment;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

=head2 get_comments_by_ticket_id

A predefined search for ticket comments

=cut

# reverse the order, newest to oldest
# order_by => { -desc => qw/col1 col2 col3/}
# order_by => { -asc => 'col'}
sub get_comments_by_ticket_id {
    my ($self, $ticket_id) = @_;
    return $self->search({
        ticket_id => $ticket_id
    }, {order_by => { -desc => 'id'}});
}

1;
