#!/bin/bash

rm -rf ./t/db
~/rakudo/bin/perl6 00-use.t
~/rakudo/bin/perl6 01-new.t
~/rakudo/bin/perl6 02-create_database.t
~/rakudo/bin/perl6 03-select.t
~/rakudo/bin/perl6 04-full-text-search.t
~/rakudo/bin/perl6 ./t/00-use.t
~/rakudo/bin/perl6 ./t/01-new.t
~/rakudo/bin/perl6 ./t/02-create_database.t
~/rakudo/bin/perl6 ./t/03-select.t
~/rakudo/bin/perl6 ./t/04-full-text-search.t

