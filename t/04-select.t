use v6.c;
use Test;
use lib 'lib';
use Rakuroonga;

my $rakuroonga = Rakuroonga.new;

is($rakuroonga.open_database("./t/db/db"),
   True,
   "This test for open database");

my %options = 'flag' => 'Pat', 'key_type' => 'UInt64';
my $table = $rakuroonga.create_table("Blogs", %options);
$table.add_column("date", "Time");
$table.add_column("title", "ShortText");

my %data = '_key' => '1', 'date' => '2020/1/1', 'title' => 'Happy New Year!';
$table.insert(%data);
%data = '_key' => '2', 'date' => '2020/1/2', 'title' => 'This is a pen!!';
$table.insert(%data);

is($table.select("Blogs", "data == 2020/1/1"),
   { data => "2020/1/1", title => "Happy New Year!" },
   "This test for select");

done-testing;
