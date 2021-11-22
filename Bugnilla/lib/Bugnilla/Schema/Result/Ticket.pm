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

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

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

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 createdby_user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 assignedto_user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 status_id

  data_type: 'integer'
  default_value: 1
  is_foreign_key: 1
  is_nullable: 1

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
  "title",
  { data_type => "text", is_nullable => 0 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "createdby_user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "assignedto_user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "status_id",
  {
    data_type      => "integer",
    default_value  => 1,
    is_foreign_key => 1,
    is_nullable    => 1,
  },
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

=head2 assignedto_user

Type: belongs_to

Related object: L<Bugnilla::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "assignedto_user",
  "Bugnilla::Schema::Result::User",
  { id => "assignedto_user_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 createdby_user

Type: belongs_to

Related object: L<Bugnilla::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "createdby_user",
  "Bugnilla::Schema::Result::User",
  { id => "createdby_user_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

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


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-11-21 17:33:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1nqHberUQ011k2dd/W8BNA


# You can replace this text with custom code or comments, and it will be preserved on regeneration

#
# Enable automatic date handling
#
__PACKAGE__->add_columns(
    "created",
    { data_type => 'timestamp', set_on_create => 1 },
    "updated",
    { data_type => 'timestamp', set_on_create => 1, set_on_update => 1 },
);

=head2 delete_allowed_by
 
Can the specified user delete the current ticket?
 
=cut
 
sub delete_allowed_by {
    my ($self, $user) = @_;
 
    # Only allow delete if user has 'Admin' role
    return $user->has_role('Admin');
}

=head2 edit_allowed_by
 
Can the specified user edit the current ticket?
 
=cut
 
sub edit_allowed_by {
    my ($self, $user) = @_;
 
    # Only allow edit if user has 'Admin' or 'Developer' role
    return $user->has_role('Admin') || $user->has_role('Developer');
}

__PACKAGE__->meta->make_immutable;
1;
