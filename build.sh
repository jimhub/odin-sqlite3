#!/usr/bin/env bash

SQLITE_YEAR=2025
SQLITE_VERSION=3510100

rm -rf sqlite-amalgamation-*
wget https://sqlite.org/${SQLITE_YEAR}/sqlite-amalgamation-${SQLITE_VERSION}.zip && unzip -o sqlite-amalgamation-${SQLITE_VERSION}.zip

pushd sqlite-amalgamation-${SQLITE_VERSION}


if [[ "$1" == "web" ]]; then
    emcc -c sqlite3.c && emar rcs sqlite3.a sqlite3.o
    cp ./sqlite3.a ../lib/wasm/.
else
    gcc -c sqlite3.c && ar rcs sqlite3.a sqlite3.o

    if [[ "$OSTYPE" == "darwin"* ]]; then
        cp ./sqlite3.a ../lib/mac/.
    else
        cp ./sqlite3.a ../lib/linux/.
    fi
fi

popd
