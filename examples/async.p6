use v6;

use lib './lib';
use Terminal::Print;

my $t = Terminal::Print.new;   # TODO: take named parameter for grid name of default grid

$t.initialize-screen;

my @indices = $t.grid-indices;

# Other attempts that do not work very well
#await do for ^$t.max-rows -> $x {
#await do for ^10 -> $x {

my @alphabet = 'v'..'z';
await do for (^$t.max-rows).rotor(10, :partial).kv -> $thread,@ys {
    my $char = @alphabet[$thread];
    start {
        sleep $thread / 2.3;
        my @xs := $thread %% 2 ?? (^$t.max-columns).reverse !! ^$t.max-columns;
        for @xs -> $x {
            my @yss := $thread %% 2 ?? @ys.reverse !! @ys;
            for @yss -> $y {
                $t.print-cell($x,$y,$char);
            }
        }
    }
}

$t.shutdown-screen;
