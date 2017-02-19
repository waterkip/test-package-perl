recommends 'Test::More';
requires 'Test::CheckManifest';
requires 'Test::Compile';
requires 'Test::Exception';
requires 'Test::Pod';
requires 'Test::Pod::Coverage';

on 'test' => sub {
    requires 'Test::More';
};

