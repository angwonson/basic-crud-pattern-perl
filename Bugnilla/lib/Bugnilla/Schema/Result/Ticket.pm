use utf8;
package Bugnilla::Schema::Result::Ticket;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Bugnilla::Schema::Result::Ticket

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<ticket>

=cut

__PACKAGE__->table("ticket");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'text'
  is_nullable: 1

=head2 status_id

  data_type: 'integer'
  default_value: 1
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "text", is_nullable => 1 },
  "status_id",
  {
    data_type      => "integer",
    default_value  => 1,
    is_foreign_key => 1,
    is_nullable    => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 status

Type: belongs_to

Related object: L<Bugnilla::Schema::Result::Status>

=cut

__PACKAGE__->belongs_to(
  "status",
  "Bugnilla::Schema::Result::Status",
  { id => "status_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 ticket_developers

Type: has_many

Related object: L<Bugnilla::Schema::Result::TicketDeveloper>

=cut

__PACKAGE__->has_many(
  "ticket_developers",
  "Bugnilla::Schema::Result::TicketDeveloper",
  { "foreign.ticket_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 developers

Type: many_to_many

Composing rels: L</ticket_developers> -> developer

=cut

__PACKAGE__->many_to_many("developers", "ticket_developers", "developer");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-11-18 16:55:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KP+tJ83sZKSsn7lBZ2177Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
