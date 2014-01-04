

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'Test::Package',
    VERSION_FROM => 'lib/Test/Package.pm', # finds \$VERSION
    AUTHOR       => 'W. G. Schwengle (wesley@schwengle.net)',
    ABSTRACT     => 'Testing a Perl package',
    PREREQ_PM => {
        'Test::Simple'        => 0.44,
        'Test::More'          => 0,
        'Test::Compile'       => 0,
        'Test::Pod'           => 0,
        'Test::Pod::Coverage' => 0,
      },
);
