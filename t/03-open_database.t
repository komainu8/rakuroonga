use v6.c;
use Test;
use lib 'lib';
use Rakuroonga;

my $rakuroonga = Rakuroonga.new;

is($rakuroonga.open_database("./t/db/db"),
   True,
   "This test for open database");
is($rakuroonga.open_database(),
   False,
   "This test for open database if we didn't specify path");
is($rakuroonga.open_database("./t/db/invalid"),
   False,
   "This test for open database by using invalid path");

done-testing;
