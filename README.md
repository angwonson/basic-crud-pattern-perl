# basic-crud-pattern-perl
Simple CRUD application written in Perl using SQLite database

Assumptions:
Fedora 35 on EC2. Any *nix should work, but you would need to adjust the yum/dnf command to match your distro, or let cpanm install the dependencies for you.


$ sudo yum install perl-DBD-SQLite perl-DBIx-Class perl-devel perl-Catalyst-Devel perl-Carp-Assert-More perl-Test-Taint perl-Devel-Cycle perl-HTML-Form perl-Test-Memory-Cycle perl-Test-NoWarnings perl-Catalyst-Plugin-Authentication perl-Catalyst-Plugin-Authorization-Roles perl-Test-WWW-Mechanize-PSGI perl-Catalyst-Plugin-Authorization-ACL perl-Catalyst-Plugin-Session-State-Cookie perl-Catalyst-Plugin-Session-Store-FastMmap perl-Catalyst-Controller-HTML-FormFu perl-Catalyst-Plugin-StackTrace perl-Catalyst-View-TT perl-Catalyst-Model-DBIC-Schema perl-Catalyst-Manual perl-DBIx-Class-TimeStamp perl-DateTime-Format-SQLite perl-Catalyst-Plugin-Session-Store-File perl-Authen-Passphrase perl-Class-Mix perl-Crypt-Eksblowfish perl-Crypt-MySQL perl-Data-Entropy perl-Data-Float perl-Test-WWW-Mechanize-Catalyst


# The following are not currently available via yum/dnf on fc35, so we install it via cpanm after all the other dependencies
$ sudo cpanm Task::Catalyst::Tutorial 
$ sudo cpanm DBIx::Class::PassphraseColumn
$ sudo cpanm Catalyst::Plugin::StatusMessage

$ cd Bugnilla
$ script/bugnilla_server.pl

Web server is now up and running at the following url:
http://localhost:3000/

# Sample users:
# test01 is admin
# test02 is developer
# test03 is plain user
# all 3 have the same password 'mypass'

# admin can delete, admin the user roles
# developer can edit, assign
# plain user can create tickets and comment on them (no role in roles DB - all users are "user" role)
