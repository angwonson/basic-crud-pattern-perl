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
  is_nullable: 0

=head2 developer_id

  data_type: 'integer'
  is_foreign_key: 1
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
  "developer_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "status_id",
  {
    data_type      => "integer",
    default_value  => 1,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 developer

Type: belongs_to

Related object: L<Bugnilla::Schema::Result::Developer>

=cut

__PACKAGE__->belongs_to(
  "developer",
  "Bugnilla::Schema::Result::Developer",
  { id => "developer_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 status

Type: belongs_to

Related object: L<Bugnilla::Schema::Result::Status>

=cut

__PACKAGE__->belongs_to(
  "status",
  "Bugnilla::Schema::Result::Status",
  { id => "status_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-11-18 17:38:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:A9P3dgOSYKtF2LakYBFElA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
