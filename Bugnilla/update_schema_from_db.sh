# use the following option if  script/bugnilla_create.pl complains that you hacked your schema class the wrong way
# overwrite_modifications=1

script/bugnilla_create.pl model DB DBIC::Schema Bugnilla::Schema \
    create=static components=TimeStamp,PassphraseColumn naming-current use_namespaces=1 dbi:SQLite:bugnilla.db \
    on_connect_do="PRAGMA foreign_keys = ON"
