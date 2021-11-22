use utf8;
package Bugnilla::Schema::Result::TicketComment;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Bugnilla::Schema::Result::TicketComment

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

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<ticket_comment>

=cut

__PACKAGE__->table("ticket_comment");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 ticket_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 comment

  data_type: 'text'
  is_nullable: 0

=head2 createdby_user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 created

  data_type: 'timestamp'
  is_nullable: 1

=head2 updated

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "ticket_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "comment",
  { data_type => "text", is_nullable => 0 },
  "createdby_user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "created",
  { data_type => "timestamp", is_nullable => 1 },
  "updated",
  { data_type => "timestamp", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 createdby_user

Type: belongs_to

Related object: L<Bugnilla::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "createdby_user",
  "Bugnilla::Schema::Result::User",
  { id => "createdby_user_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 ticket

Type: belongs_to

Related object: L<Bugnilla::Schema::Result::Ticket>

=cut

__PACKAGE__->belongs_to(
  "ticket",
  "Bugnilla::Schema::Result::Ticket",
  { id => "ticket_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-11-21 20:32:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yFN5Hir8MBWFiqiKnmKgig


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
