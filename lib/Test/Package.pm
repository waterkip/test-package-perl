#!/usr/bin/env perl
use warnings;
use strict;

package Test::Package;
our $VERSION = 0.1;

require Exporter;
our @ISA = qw(Exporter);

use Test::Compile;
use Test::More;
use Test::Pod::Coverage;
use Test::Pod;

our @EXPORT = qw(all_package_files_ok);

=head2 all_package_files_ok

Tests all the relevant items of a Perl package:

=over

=item all_pm_files_ok

=item all_pl_files_ok (not yet)

=item all_pod_compile_ok

=item all_pod_coverage_ok

=back

=cut

sub all_package_files_ok {
    my %args = @_;

    if (!exists $args{skip}) {
        $args{skip} = {};
    }

    subtest 'Compile modules tests' => sub {
        if ($args{skip}{pm}) { 
            plan skip_all => 'Skipping module compile tests on request';
        }
        else {
            all_pm_files_ok();
        }
    };
    
    subtest 'Compile script tests' => sub {
        if ($args{skip}{pl}) { 
            plan skip_all => 'Skipping script files tests on request';
        }
        else {
            my @scripts = all_pl_files();
            if (!@scripts) {
                plan skip_all => 'No pl files found';
            }
            else {
                all_pl_files_ok();
            }
        }
    };

    subtest 'POD compile tests' => sub {
        if ($args{skip}{pod}) { 
            plan skip_all => 'Skipping pod compile tests on request';
        }
        else {
            all_pod_files_ok();
        }
    };

    subtest 'POD coverage tests' => sub {
        if ($args{skip}{pod_coverage}) { 
            plan skip_all => 'Skipping pod coverage tests on request';
        }
        else {
            all_pod_coverage_ok();
        }
    };

    done_testing();
}

1;
