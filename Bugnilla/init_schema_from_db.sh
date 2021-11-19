script/bugnilla_create.pl model DB DBIC::Schema Bugnilla::Schema \
    create=static components=TimeStamp dbi:SQLite:bugnilla.db \
    on_connect_do="PRAGMA foreign_keys = ON"
