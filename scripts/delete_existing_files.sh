#!/bin/bash

STATIC=/home/ubuntu/static
MIGRATIONS=/home/ubuntu/migrations
SCRIPTS=/home/ubuntu/scripts

if [ -d "$STATIC" ]; then
    rm -rf $STATIC
fi

if [ -d "$MIGRATIONS" ]; then
    rm -rf $MIGRATIONS
fi

if [ -d "$SCRIPTS" ]; then
    rm -rf $SCRIPTS
fi
