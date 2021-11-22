# DEVELOPER JOURNAL

### Any notes about how things were done, or why decisions were made can go here. Anything else that doesn't really fit into the README document can go here.

#### This entire project was blatantly ripped from the Catalyst tutorial.
```
https://metacpan.org/dist/Catalyst-Manual/view/lib/Catalyst/Manual/Tutorial.pod
```
***

#### ALTERNATE/Debian/Ubuntu dependencies: Install available dependencies the slow way
#### - Make sure you install the perl devel stuff first, in case you don't already have it.
#### - On Debian 10 for ARM processors this would be something like libperl5.28

```
[root@localhost ~]# apt-get install libperl5.28 make
[root@localhost ~]# cpanm DBD::SQLite DBIx::Class Catalyst::Devel Carp::Assert::More Test::Taint Devel::Cycle HTML::Form Test::Memory::Cycle Test::NoWarnings Catalyst::Plugin::Authentication Catalyst::Plugin::Authorization::Roles Test::WWW::Mechanize::PSGI Catalyst::Plugin::Authorization::ACL Catalyst::Plugin::Session::State::Cookie Catalyst::Plugin::Session::Store::FastMmap Catalyst::Controller::HTML::FormFu Catalyst::Plugin::StackTrace Catalyst::View::TT Catalyst::Model::DBIC::Schema Catalyst::Manual DBIx::Class::TimeStamp DateTime::Format::SQLite Catalyst::Plugin::Session::Store::File Authen::Passphrase Class::Mix Crypt::Eksblowfish Crypt::MySQL Data::Entropy Data::Float Test::WWW::Mechanize::Catalyst HTML::FormFu::Element::reCAPTCHA HTML::FormFu::Model::DBIC HTML::FormFu::Model::DBIC::tests HTML::FormFu::MultiForm Task::Catalyst::Tutorial DBIx::Class::PassphraseColumn Catalyst::Plugin::StatusMessage
```

#### Here is how to create a sqlite db from the schema file(s):
```
./init_sqlite_db.sh
```
***

#### change passwords in db to hashed SHA1 after the import
```
DBIC_TRACE=1 perl -Ilib set_hashed_passwords.pl
```
***

#### Create the Schema in Catalyst (again this has already been done so just documenting how it was achieved):
```
./init_schema_from_db.sh
```
***

#### Update the Schema in Catalyst:
```
./update_schema_from_db.sh
```
***

#### Start the server:
##### NOTE: Add the -r switch if you want debug mode, or leave it out if you want multiple users to be able to use the site
```
script/bugnilla_server.pl -r
```
***

#### TEST from cli:
```
script/bugnilla_test.pl "/tickets/list" | lynx -stdin
```
***

#### enable DBIC debugging in catalyst server:
```
DBIC_TRACE=1 script/bugnilla_server.pl -r
```
***

#### add additional files to schema folder to update db schema, such as 
```
schema/20211118_schema_change.sql
```
***

#### Make sure to rerun `./update_schema_from_db.sh` after altering the db schema
```
./update_schema_from_db.sh
```
***

#### Here is how to export configs from Bugnilla.pm to be used instead in Bugnilla.conf
##### Some examples would be database password, Auth configs, etc
```
CATALYST_DEBUG=0 perl -Ilib -e 'use Bugnilla; use Config::General;
Config::General->new->save_file("myapp.conf", Bugnilla->config);'
```
***

#### To convert passwords from plain text to hashed:
```
DBIC_TRACE=1 perl -Ilib set_hashed_passwords.pl
```
***

#### Run unit tests:
```
prove -wl t
```
***

#### inline (STDOUT) debugging:
##### options are: debug, info, warn, error, fatal
```
$c->log->info("Starting the foreach loop here");
```
***

#### use perl debugger:
##### Add the following breakpoint anywhere in the code:
```
$DB::single=1;
```
##### then run the debugger as follows:
```
perl -d script/bugnilla_server.pl
```
***

#### how to debug TT
##### enable DEBUG in View/HTML.pm
***

#### unit tests:
```
CATALYST_DEBUG=0 perl -w -Ilib t
```
#### or
```
CATALYST_DEBUG=0 BUGNILLA_DSN="dbi:SQLite:bugnillaTEST.db" prove -vwl t/live_01app.t
```
##### CATALYST_DEBUG=0 isn't necessary but makes it easier to read
##### BUGNILLA_DSN isn't required either but it allows us to run unit tests on a copy of the database, JIC
##### you need to copy bugnilla.db to bugnillaTEST.db if there have been schema changes
***

#### Copy the database over for unit tests
```
cp bugnilla.db bugnillaTEST.db
```
***

#### Perl doesn't allow dash in subroutine names. So for example /about-us woul dneed to have :Path('/about-us') while the sub is called aboutus()
***

#### using https://purecss.io since I can't use Material or anything else that requires Javascript.
#### techically the Pure examples use some JS, but it seems to be ok so far without it, except:
#### the design is responsive, so if you make your window small it will switch to burger vs left bar, and the burger doesn't work w/o the js
***

#### TT2 has some syntactic sugar:
```
[% #### This is a comment. -%]
```
#### what the dash does is tell TT to remove the newline character.
#### this helps with comments and other situations where you don't want the extra whitespace
***

#### Delete button on list page shows up for ordinary users. This is intentional.
#### It is trivial to hide it but I wanted to show that if you click on it when you are not in the admin group
####  you will get 'Permission Denied'
#### in production we would hide this if you don't have permission
***

#### Do not allow users to be deleted, this will break the relationship with tickets assigned to that user
#### Instead we can just make them inactive:
#### UPDATE user SET active = 0 WHERE user = 2;

# createdby_user_id column in ticket_comment table should be NOT NULL, but I left it in case we still need to show the entire app in anonymous mode
