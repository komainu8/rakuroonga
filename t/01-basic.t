use v6.c;
use Test;
use lib 'lib';
use rakuroonga;

my $rakuroonga = rakuroonga.new;
is($rakuroonga.init(), 0, "This test for grn_init()");
is($rakuroonga.fin(), 0, "This test for grn_fin()");

done-testing;
