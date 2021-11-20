package Bugnilla::Model::DB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

# allow db switching for unit tests and dev vs prod via $ENV{MYAPP_DSN}
my $dsn = $ENV{BUGNILLA_DSN} ||= 'dbi:SQLite:bugnilla.db';
__PACKAGE__->config(
    schema_class => 'Bugnilla::Schema',
    
    connect_info => {
        dsn => $dsn,
        user => '',
        password => '',
        on_connect_do => q{PRAGMA foreign_keys = ON},
    }
);

=head1 NAME

Bugnilla::Model::DB - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<Bugnilla>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<Bugnilla::Schema>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.65

=head1 AUTHOR

Han Do Jin

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
