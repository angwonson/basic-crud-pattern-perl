script/bugnilla_create.pl model DB DBIC::Schema Bugnilla::Schema \
    create=static naming-current use_namespaces=1 dbi:SQLite:bugnilla.db \
    on_connect_do="PRAGMA foreign_keys = ON"
