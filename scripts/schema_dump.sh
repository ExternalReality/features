#!/bin/sh

if [ -a schema.sql ]
   then
   mv schema.sql schema.sql.bak
fi

pg_dump --schema-only --no-privileges --no-owner $1 > schema.sql
