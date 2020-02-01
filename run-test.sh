#!/bin/bash

cd resources
make clean
make
cd ..

mkdir ./t/db

perl6 ./t/00-use.t
perl6 ./t/01-new.t
perl6 ./t/02-create_database.t
perl6 ./t/03-open_database.t
perl6 ./t/04-select.t
perl6 ./t/05-full-text-search.t

rm -rf ./t/db
