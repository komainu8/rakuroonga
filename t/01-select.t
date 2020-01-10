use v6.c;
use Test;
use lib 'lib';
use Rakuroonga;

my $rakuroonga = Rakuroonga.new;

is($rakuroonga.create_database("./t/db/db"),
   True,
   "This test for create database");
my $table = $rakuroonga.create_table("Blogs", "Hash", "UInt64");
$table.add_column("date", "Time");
$table.add_column("title", "ShortText");

$table.insert("2020/1/1", "Happy New Year!");
$table.insert("2020/1/2", "I eat Osechi!!");

is($table.select("Blogs", "data == 2020/1/1"),
   { data => "2020/1/1", title => "Happy New Year!" },
   "This test for select");

done-testing;
