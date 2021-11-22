package Bugnilla::Schema::ResultSet::Ticket;
 
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';
 
=head2 created_after
 
A predefined search for recently added tickets
 
=cut
 
sub created_after {
    my ($self, $datetime) = @_;
 
    my $date_str = $self->result_source->schema->storage
                          ->datetime_parser->format_datetime($datetime);
 
    return $self->search({
        created => { '>' => $date_str }
    });
}

=head2 title_like
 
A predefined search for tickets with a 'LIKE' search in the string
 
=cut

# can use search_like() instead of search(0
sub title_like {
    my ($self, $title_str) = @_;
 
    return $self->search({
        title => { 'like' => "%$title_str%" }
    });
}

=head2 status_filter
 
Get all tickets by status
 
=cut
 
sub filter_by_status {
    my ($self, $status_id) = @_;
 
    return $self->search({
        status_id => $status_id
    });
}

=head2 get_comments
 
Get all comments by ticket_id
 
=cut
 
sub get_comments {
    my ($self, $ticket_id) = @_;
    return $self->search_related( 'ticket_comments', {ticket_id => $ticket_id});
}


1;
