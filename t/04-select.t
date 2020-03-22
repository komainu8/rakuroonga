use v6.c;
use Test;
use lib 'lib';
use Rakuroonga;

my $rakuroonga = Rakuroonga.new;

$rakuroonga.open_database("./t/db/db");

my $table = $rakuroonga.create_table("Blogs", {});
$table.add_column("title", "ShortText");

my %data = 'title' => 'Happy!';
$table.insert(%data);
%data = 'title' => 'Hello!';
$table.insert(%data);

is($table.select("Blogs", "\'title == \"Happy!\"\'"),
   { 'title' => 'Happy!' },
   "This test for select");

done-testing;
