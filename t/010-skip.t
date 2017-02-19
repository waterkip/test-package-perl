#! perl

use Test::Package;

all_package_files_ok(
    skip => {
        pod_coverage => 1,
        pod          => 1,
        pm           => 1,
        pl           => 1,
        manifest     => 1,
    }
);
