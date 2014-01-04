#! perl

use Test::Package;
use Test::More;

my @methods = qw(
    all_package_files_ok
    all_pm_files_ok
    all_pl_files_ok
    all_pod_files_ok
    all_pod_coverage_ok
);

can_ok('Test::Package', @methods);
all_package_files_ok();
