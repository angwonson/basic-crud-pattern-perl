# basic-crud-pattern-perl
This is a deevloper journal. Any notes about how things were done, or why decisions were made can go here. Anything else that doesn't really fit into the README document can go here.


This entire project was blatantly ripped from the Catalyst tutorial.
https://metacpan.org/dist/Catalyst-Manual/view/lib/Catalyst/Manual/Tutorial.pod

I would not usually put a database, even SQLite into git, but the instructions say plainly to include a database with some data in it already. I've also included a simple shell script to create the db from the schema file.
./init_sqlite_db.sh

Create the Schema in Catalyst (again this has already been done so just documenting how it was achieved):
./init_schema_from_db.sh

Update the Schema in Catalyst:
./update_schema_from_db.sh

TEST from cli:
script/bugnilla_test.pl "/tickets/list" | lynx -stdin


enable DBIC debugging in catalyst server:
DBIC_TRACE=1 script/bugnilla_server.pl -r

add additional files to schema folder to update db schema, such as 
schema/tickets_20211118.sql
Make sure to rerun ./update_schema_from_db.sh after altering the db schema

Here is how to export configs from Bugnilla.pm to be used instead in Bugnilla.conf
Soem examples would be database password, Auth configs, etc
$ CATALYST_DEBUG=0 perl -Ilib -e 'use Bugnilla; use Config::General;
Config::General->new->save_file("myapp.conf", Bugnilla->config);'

To convert passwords from plain text to hashed:
$ DBIC_TRACE=1 perl -Ilib set_hashed_passwords.pl
