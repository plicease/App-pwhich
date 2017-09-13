use Test2::V0 -no_srand => 1;
use Test2::Mock;
use App::pwhich;
use Test::Script;
use File::Which qw( which );
use File::Basename qw( basename );
use File::Temp ();
use Capture::Tiny qw( capture );

subtest 'script can find perl' => sub {

  my $perl       = basename $^X;
  my $which_perl = which "$perl";
  
  unless(defined $which_perl)
  {
    $perl       = 'perl';
    $which_perl = which $perl;
  }
  
  note "perl       = $perl";
  
  skip_all 'File::Which cannot find perl' unless defined $which_perl;

  note "which perl = $which_perl";

  script_runs(
    [ 'bin/pwhich', $perl ],
    'script did not fail',
  );
  
  script_stdout_is "$which_perl\n";

};

subtest 'script can fail to find an executable' => sub {

  my $bogus;
  
  do {
  
    $bogus = basename File::Temp::tempnam(".","bogus");
  
  } while(which $bogus);

  note "bogus = $bogus";

  script_runs(
    [ 'bin/pwhich', $bogus ],
    { exit => 1 },
    'script did not find bogus command',
  );
  
  script_stdout_is '';
  script_stderr_like qr{no $bogus in PATH};

};

subtest 'script can print version number' => sub {

  script_runs(
    [ 'bin/pwhich', '-v' ],
    { exit => 2 },
    'script runs',
  );

  my $my_version = $App::pwhich::VERSION || 'dev';
  
  script_stdout_like qr{This is pwhich running File::Which version $File::Which::VERSION\n[ ]+App::pwhich version $my_version}, 'versions are printed';
  script_stdout_like qr{Copyright 2002 Per Einar Ellefsen}, 'original author copyright';
  script_stdout_like qr{Some parts Copyright 2009 Adam Kennedy}, 'second maintainer copyright';
  script_stdout_like qr{Other parts Copyright 20[0-9]{2} Graham Ollis}, 'third maintainer copyright';
  script_stdout_like qr{This program is free software; you can redistribute it and/or modify\nit under the same terms as Perl itself\.}, 'license info';

};

subtest 'the -a option' => sub {

  my $arg;
  
  my $mock = Test2::Mock->new(
    class => 'App::pwhich',
    override => [
      which => sub {
        ($arg) = @_;
        qw( /usr/bin/foo /bin/foo /usr/locla/bin ),
      },
    ],
  );
  
  is(
    [capture { App::pwhich::main('-a','foo') }],
    array {
      item "/usr/bin/foo\n/bin/foo\n/usr/locla/bin\n";
      item '';
      item 0;
      end;
    },
    'i/o',
  );

};

done_testing;

