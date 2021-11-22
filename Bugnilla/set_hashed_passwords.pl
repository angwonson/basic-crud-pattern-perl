#!/usr/bin/perl
use lib 'lib';

use strict;
use warnings;

use Bugnilla::Schema;

# usage:
# DBIC_TRACE=1 perl -Ilib set_hashed_passwords.pl

my $schema = Bugnilla::Schema->connect('dbi:SQLite:bugnilla.db');

my @users = $schema->resultset('User')->all;

foreach my $user (@users) {
    $user->password('mypass');
    $user->update;
}
