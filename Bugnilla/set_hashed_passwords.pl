#!/usr/bin/perl
 
use strict;
use warnings;
 
use Bugnilla::Schema;
 
my $schema = Bugnilla::Schema->connect('dbi:SQLite:bugnilla.db');
 
my @users = $schema->resultset('User')->all;
 
foreach my $user (@users) {
    $user->password('mypass');
    $user->update;
}
