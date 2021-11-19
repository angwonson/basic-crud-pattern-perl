#!/bin/sh
sqlite3 bugnilla.db < schema/tickets.sql
sqlite3 bugnilla.db < schema/users.sql
