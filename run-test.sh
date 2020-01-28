#!/bin/bash

mkdir ./t/db

~/rakudo/bin/perl6 ./t/00-use.t
~/rakudo/bin/perl6 ./t/01-new.t
~/rakudo/bin/perl6 ./t/02-create_database.t
~/rakudo/bin/perl6 ./t/03-select.t
~/rakudo/bin/perl6 ./t/04-full-text-search.t

rm -rf ./t/db
