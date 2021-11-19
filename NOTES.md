# basic-crud-pattern-perl
This is a deevloper journal. Any notes about how things were done, or why decisions were made can go here. Anything else that doesn't really fit into the README document can go here.


This entire project was blatantly ripped from the Catalyst tutorial.
https://metacpan.org/dist/Catalyst-Manual/view/lib/Catalyst/Manual/Tutorial.pod

I would not usually put a database, even SQLite into git, but the instructions say plainly to include a database with some data in it already. I've also included a simple shell script to create the db from the schema file.
./init_sqlite_db.sh

Create the Schema in Catalyst (again this has already been done so just documenting how it was achieved):
./init_schema_from_db.sh
