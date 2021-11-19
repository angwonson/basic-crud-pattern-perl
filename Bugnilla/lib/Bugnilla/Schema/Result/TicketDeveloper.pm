use utf8;
package Bugnilla::Schema::Result::TicketDeveloper;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Bugnilla::Schema::Result::TicketDeveloper

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

=head1 TABLE: C<ticket_developer>

=cut

__PACKAGE__->table("ticket_developer");

=head1 ACCESSORS

=head2 ticket_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 developer_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "ticket_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "developer_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</ticket_id>

=item * L</developer_id>

=back

=cut

__PACKAGE__->set_primary_key("ticket_id", "developer_id");

=head1 RELATIONS

=head2 developer

Type: belongs_to

Related object: L<Bugnilla::Schema::Result::Developer>

=cut

__PACKAGE__->belongs_to(
  "developer",
  "Bugnilla::Schema::Result::Developer",
  { id => "developer_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 ticket

Type: belongs_to

Related object: L<Bugnilla::Schema::Result::Ticket>

=cut

__PACKAGE__->belongs_to(
  "ticket",
  "Bugnilla::Schema::Result::Ticket",
  { id => "ticket_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-11-18 16:55:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FxKh0g1fGZWTHo3tWkBy/g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
