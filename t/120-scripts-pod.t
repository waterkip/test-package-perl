#! perl

use Test::Package;

all_package_files_ok(
    pl  => [ qw(t/bin) ],
    pod => [ qw(lib) ],
    skip => {
        pm => 1,
        manifest => 1,
    }
);
