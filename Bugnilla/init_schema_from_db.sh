script/bugnilla_create.pl model DB DBIC::Schema Bugnilla::Schema \
    create=static dbi:SQLite:bugnilla.db \
    on_connect_do="PRAGMA foreign_keys = ON"
 exists "lib/Bugnilla/Model"
 exists "t"
#Dumping manual schema for Bugnilla::Schema to directory /home/catalyst/Bugnilla/script/../lib ...
#Schema dump completed.
#created "lib/Bugnilla/Model/DB.pm"
#created "t/model_DB.t"
