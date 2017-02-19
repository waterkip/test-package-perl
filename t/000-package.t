#! perl

use Test::Package;
use Test::More;

my @methods = qw(
    all_package_files_ok
);

can_ok('Test::Package', @methods);

# Self testing is awesome.
all_package_files_ok();
