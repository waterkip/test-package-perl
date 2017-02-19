#! perl

use Test::Package;

all_package_files_ok(
    pm  => [ ],
    pl  => [ ],
    pod => [ ],
    skip => {
        manifest => 1,
    }
);
