use v6.c;
use Test;
use lib 'lib';
use Rakuroonga;

my $rakuroonga = Rakuroonga.new;

is($rakuroonga.open_database("./t/db/db"),
   True,
   "This test for open database");

my %options = 'flag' => 'Pat', 'key_type' => 'ShortText';
my $table = $rakuroonga.create_table("Blogs", %options);
$table.add_column("title", "ShortText");

my %data = '_key' => '20200101', 'title' => 'Happy New Year!';
$table.insert(%data);
%data = '_key' => '20200102', 'title' => 'This is a pen!!';
$table.insert(%data);

$table.select("Blogs", "\'_key == \"20200101\"\'");

#is($table.select("Blogs", "data == 2020/1/1"),
#   { data => "2020/1/1", title => "Happy New Year!" },
#   "This test for select");

done-testing;
