use utf8;
package Bugnilla::Schema::Result::Developer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Bugnilla::Schema::Result::Developer

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

=head1 TABLE: C<developer>

=cut

__PACKAGE__->table("developer");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 first_name

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "first_name",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 ticket_developers

Type: has_many

Related object: L<Bugnilla::Schema::Result::TicketDeveloper>

=cut

__PACKAGE__->has_many(
  "ticket_developers",
  "Bugnilla::Schema::Result::TicketDeveloper",
  { "foreign.developer_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tickets

Type: many_to_many

Composing rels: L</ticket_developers> -> ticket

=cut

__PACKAGE__->many_to_many("tickets", "ticket_developers", "ticket");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-11-18 16:55:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:K9q/eyJCU3OwfU0r//ozMA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
