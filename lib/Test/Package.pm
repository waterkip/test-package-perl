package Test::Package;
use warnings;
use strict;

our $VERSION = 1.0_2;

use Test::Compile;
use Test::DistManifest;
use Test::More;
use Test::Pod;
use Test::Pod::Coverage;

use base 'Exporter';

our @EXPORT = qw(all_package_files_ok);

=head1 METHODS

=head2 all_package_files_ok

all_package_files_ok();

all_package_files_ok(
    pm => [qw(lib blib)],
    pl => [qw(bin scripts)],
    skip => {
        pm           => 0,
        pl           => 0,
        pod          => 1,
        pod_coverage => 1,
        manifest     => 0,
    },
);

Tests all the relevant items of a Perl package:

=over

=item skip

An hashref which defines which test to skip. You can skip all the test,
although you may want to rethink usage of this module if you want to
skip everything.

=over

=item pl

Skip Perl scripts tests

=item pm

Skip Perl module tests

=item pod

Skip POD tests

=item pod_coverage

Skip POD coverage tests

=back

=item pm

An arrayref of which directories to check for compile testing modules.

=item pl

An arrayref of which directories to check for compile testing of scripts.

=item pod

An arrayref of which directories to check for POD testing of modules and
script. If not supplied it takes the values found for modules and
scripts.

=back

=cut

sub all_package_files_ok {
    my %args = @_;

    $args{skip} //= {};

    $args{pm} //= ['blib', 'lib'];
    $args{pl} //= ['bin', 'script', 'dev-bin'];

    my @modules = ();
    my @pods = ();
    if (@{$args{pm}}) {
        push(@modules, all_pm_files(@{$args{pm}}));
        push(@pods, @modules);
    }

    my @scripts = ();
    if (@{$args{pl}}) {
        push(@scripts, all_pl_files(@{$args{pl}}));
        push(@pods, @scripts);
    }

    if (defined $args{pod}) {
        if (@{$args{pod}}) {
            @pods = all_pod_files(@{ $args{pod} });
        }
        else {
            @pods = ();
        }
    }

    my $types = {
        manifest => {
            name => "Manifest tests",
            sub  => sub { manifest_ok },
        },
        pm => {
            name => "Module compile tests",
            sub  => sub {
                if (!@modules) {
                    plan skip_all => 'No pm files found';
                }
                else {
                    all_pm_files_ok(@modules)
                };
            },
        },
        pl => {
            name => "Script compile tests",
            sub => sub {
                if (!@scripts) {
                    plan skip_all => 'No pl files found';
                }
                else {
                    all_pl_files_ok(@scripts);
                }
            },
        },
        pod => {
            name => "POD compile tests",
            sub  => sub {
                if (!@pods) {
                    plan skip_all => 'No pod files found';
                }
                else {
                    all_pod_files_ok(@pods);
                }
            }
        },
        pod_coverage => {
            name => "POD coverage tests",
            sub  => sub {
                if (!@pods) {
                    plan skip_all => 'No pod files found';
                }
                else {
                    all_pod_coverage_ok(@pods);
                }
            }
        },
    };

    foreach (qw(manifest pm pl pod pod_coverage)) {
        subtest $types->{$_}{name} => sub {
            if ($args{skip}{$_}) {
                plan skip_all => "Skipping module $_ tests on request";
            }
            else {
                $types->{$_}{sub}->();
            }
        };
    }

    done_testing();
}

1;

__END__

=head1 NAME

Test::Package - Test a package to be release ready

=head1 DESCRIPTION

Test a Perl package to see if everything compiles, the POD is ok and the
POD covers everything.

=head1 SYNOPSIS

In your t/000-package.t file:

    use Test::Package;

    all_package_files_ok();

    all_package_files_ok(
        pm => [qw(lib blib)],
        pl => [qw(bin scripts)],
        skip => {
            manifest     => 1,
            pm           => 0,
            pl           => 0,
            pod          => 1,
            pod_coverage => 1,
        },
    );

=head1 SEE ALSO

This module uses the following modules, in case you want to test everything in
seperate test files you may want to have a look at these

=over

=item L<Test::Compile>

=item L<Test::More>

=item L<Test::Pod::Coverage>

=item L<Test::Pod>

=item L<Test::DistManifest>

=back
