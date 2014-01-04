#! perl

use Test::Package;
use Test::More;

all_package_files_ok(
    skip => {
        pod_coverage => 1,
        pod          => 1,
        pm           => 1,
        pl           => 1,
    }
);
