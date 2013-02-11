use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'HTML::WikiConverter::Textile',
    AUTHOR              => q{MASUDA Takashi <t-masuda@mvd.biglobe.ne.jp>},
    VERSION_FROM        => 'lib/HTML/WikiConverter/Textile.pm',
    ABSTRACT_FROM       => 'lib/HTML/WikiConverter/Textile.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'HTML::WikiConverter' => 0.68,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'HTML-WikiConverter-Textile-*' },
);
