# basic-crud-pattern-perl
Simple CRUD application written in Perl using SQLite database and Catalyst Framework

## Assumptions:
- Fedora 35 on EC2. Any *nix should work, but you would need to adjust the yum/dnf command to match your distro, or let cpanm install the dependencies for you.
- Install cpan modules as root. If you need to add sudo to the yum and cpanm commands, please do so.

## Install available RPM dependencies first ( see NOTES.md for Debian instructions )
```
[root@localhost ~]# yum install perl-DBD-SQLite perl-DBIx-Class perl-devel perl-Catalyst-Devel perl-Carp-Assert-More perl-Test-Taint perl-Devel-Cycle perl-HTML-Form perl-Test-Memory-Cycle perl-Test-NoWarnings perl-Catalyst-Plugin-Authentication perl-Catalyst-Plugin-Authorization-Roles perl-Test-WWW-Mechanize-PSGI perl-Catalyst-Plugin-Authorization-ACL perl-Catalyst-Plugin-Session-State-Cookie perl-Catalyst-Plugin-Session-Store-FastMmap perl-Catalyst-Controller-HTML-FormFu perl-Catalyst-Plugin-StackTrace perl-Catalyst-View-TT perl-Catalyst-Model-DBIC-Schema perl-Catalyst-Manual perl-DBIx-Class-TimeStamp perl-DateTime-Format-SQLite perl-Catalyst-Plugin-Session-Store-File perl-Authen-Passphrase perl-Class-Mix perl-Crypt-Eksblowfish perl-Crypt-MySQL perl-Data-Entropy perl-Data-Float perl-Test-WWW-Mechanize-Catalyst perl-HTML-FormFu-Element-reCAPTCHA perl-HTML-FormFu-Model-DBIC perl-HTML-FormFu-Model-DBIC-tests perl-HTML-FormFu-MultiForm
```

## Install remaining dependencies by cpanm
#### The following are not currently available via yum/dnf on fc35, so we install it via cpanm after all the other dependencies
```
[root@localhost ~]# cpanm Task::Catalyst::Tutorial DBIx::Class::PassphraseColumn Catalyst::Plugin::StatusMessage
```

## Run Makefile.PL
```
[user@localhost ~]$ cd Bugnilla
[user@localhost ~]$ perl Makefile.PL
```

## Start the server
```
[user@localhost ~]$ script/bugnilla_server.pl
```

## Open up a browser
Web server is now up and running at the following url:
```
http://localhost:3000/
```

## Sample users:
- test01 is admin Sally
- test02 is developer Bob
- test03 is plain user Charlie
- all 3 have the same password 'mypass'

## Roles
- admin can delete tickets, admin the user roles and deactivate user
- developer can edit, assign tickets
- plain user can create tickets, list tickets, and comment on them (no role in roles DB - all users are "user" role)
- anonymous user can see home page, contact, about-us, login, and create new ticket
- Charlie and Bob can see the delete button on the list page - this is intentional. They will get 'Permission Denied' error.

## Instructions
- The instructions I received for this project are in the INSTRUCTIONS.md file.

## TODO
- The list of TODO items is in TODO.md file.

## NOTES
- My developer journal is in NOTES.md file.
