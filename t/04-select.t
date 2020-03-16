use v6.c;
use Test;
use lib 'lib';
use Rakuroonga;

my $rakuroonga = Rakuroonga.new;

$rakuroonga.open_database("./t/db/db");

my $table = $rakuroonga.create_table("Blogs", {});
$table.add_column("title", "ShortText");
$table.add_column("content", "ShortText");

my %data = 'title' => 'Happy New Year!', 'content' => 'Hello World!';
$table.insert(%data);
%data = 'title' => 'This is a pen!!', 'content' => 'Hello Rakuroonga';
$table.insert(%data);

is($table.select("Blogs", "\'title == \"This is a pen!!\"\'"),
   { 'title' => 'This is a pen!!', 'content' => 'Hello Rakuroonga'},
   "This test for select");

done-testing;
