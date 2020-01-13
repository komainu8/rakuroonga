use v6.c;
use Test;
use lib 'lib';
use Rakuroonga;

my $rakuroonga = Rakuroonga.new;
is($rakuroonga.create_database("./t/db/db"),
   True,
   "This test for create database");

done-testing;
