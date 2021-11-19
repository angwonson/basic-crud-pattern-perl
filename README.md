# basic-crud-pattern-perl
Simple CRUD application written in Perl using SQLite database

Assumptions:
Fedora 35 on EC2. Any *nix should work, but you would need to adjust the yum/dnf command to match your distro, or let cpanm install the dependencies for you.


yum install perl-DBD-SQLite perl-DBIx-Class perl-devel perl-Catalyst-Devel perl-Carp-Assert-More perl-Test-Taint perl-Devel-Cycle perl-HTML-Form perl-Test-Memory-Cycle perl-Test-NoWarnings perl-Catalyst-Plugin-Authentication perl-Catalyst-Plugin-Authorization-Roles perl-Test-WWW-Mechanize-PSGI perl-Catalyst-Plugin-Authorization-ACL perl-Catalyst-Plugin-Session-State-Cookie perl-Catalyst-Plugin-Session-Store-FastMmap perl-Catalyst-Controller-HTML-FormFu perl-Catalyst-Plugin-StackTrace perl-Catalyst-View-TT perl-Catalyst-Model-DBIC-Schema perl-Catalyst-Manual perl-DBIx-Class-TimeStamp perl-DateTime-Format-SQLite


# Task::Catalyst::Tutorial is not available via yum/dnf on fc35, so we install it after all the other dependencies
cpanm Task::Catalyst::Tutorial 


cd Bugnilla
script/bugnilla_server.pl -r

Web server is now up and running at the following url:
http://localhost:3000/
