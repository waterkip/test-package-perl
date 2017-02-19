use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Test::Package',
    VERSION_FROM  => 'lib/Test/Package.pm',
    AUTHOR        => 'Wesley Schwengle (wesley@schwengle.net)',
    ABSTRACT      => 'A module tester',
    PREREQ_PM => {
        'Test::CheckManifest' => 0,
        'Test::Compile'       => 0,
        'Test::Exception'     => 0,
        'Test::More'          => 0,
        'Test::Pod'           => 0,
        'Test::Pod::Coverage' => 0,
    },
);

