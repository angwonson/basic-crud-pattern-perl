use utf8;
package Bugnilla::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Bugnilla::Schema::Result::User

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

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 username

  data_type: 'text'
  is_nullable: 1

=head2 password

  data_type: 'text'
  is_nullable: 1

=head2 email_address

  data_type: 'text'
  is_nullable: 1

=head2 first_name

  data_type: 'text'
  is_nullable: 1

=head2 last_name

  data_type: 'text'
  is_nullable: 1

=head2 active

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "username",
  { data_type => "text", is_nullable => 1 },
  "password",
  { data_type => "text", is_nullable => 1 },
  "email_address",
  { data_type => "text", is_nullable => 1 },
  "first_name",
  { data_type => "text", is_nullable => 1 },
  "last_name",
  { data_type => "text", is_nullable => 1 },
  "active",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 ticket_assignedto_users

Type: has_many

Related object: L<Bugnilla::Schema::Result::Ticket>

=cut

__PACKAGE__->has_many(
  "ticket_assignedto_users",
  "Bugnilla::Schema::Result::Ticket",
  { "foreign.assignedto_user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 ticket_comments

Type: has_many

Related object: L<Bugnilla::Schema::Result::TicketComment>

=cut

__PACKAGE__->has_many(
  "ticket_comments",
  "Bugnilla::Schema::Result::TicketComment",
  { "foreign.createdby_user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 ticket_createdby_users

Type: has_many

Related object: L<Bugnilla::Schema::Result::Ticket>

=cut

__PACKAGE__->has_many(
  "ticket_createdby_users",
  "Bugnilla::Schema::Result::Ticket",
  { "foreign.createdby_user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_roles

Type: has_many

Related object: L<Bugnilla::Schema::Result::UserRole>

=cut

__PACKAGE__->has_many(
  "user_roles",
  "Bugnilla::Schema::Result::UserRole",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 roles

Type: many_to_many

Composing rels: L</user_roles> -> role

=cut

__PACKAGE__->many_to_many("roles", "user_roles", "role");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-11-21 20:32:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qS1BYgVykxFTa2vnR5x0ag


# You can replace this text with custom code or comments, and it will be preserved on regeneration

# many_to_many():
#   args:
#     1) Name of relationship, DBIC will create accessor with this name
#     2) Name of has_many() relationship this many_to_many() is shortcut for
#     3) Name of belongs_to() relationship in model class of has_many() above
#   You must already have the has_many() defined to use a many_to_many().
#__PACKAGE__->many_to_many(roles => 'user_roles', 'role');
# NOTE This causes compaints when updating the DBIC due to PassphraseColumn trying to create methods with the same name as 'roles'

# Have the 'password' column use a SHA-1 hash and 20-byte salt
# with RFC 2307 encoding; Generate the 'check_password" method
__PACKAGE__->add_columns(
    'password' => {
        passphrase       => 'rfc2307',
        passphrase_class => 'SaltedDigest',
        passphrase_args  => {
            algorithm   => 'SHA-1',
            salt_random => 20,
        },
        passphrase_check_method => 'check_password',
    },
);

=head2 has_role
 
Check if a user has the specified role
 
=cut
 
use Perl6::Junction qw/any/;
sub has_role {
    my ($self, $role) = @_;
 
    # Does this user posses the required role?
    return any(map { $_->role } $self->roles) eq $role;
}

__PACKAGE__->meta->make_immutable;
1;
