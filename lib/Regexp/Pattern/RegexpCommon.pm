package Regexp::Pattern::RegexpCommon;

# DATE
# VERSION

use strict 'subs', 'vars';
use warnings;

our %RE = (
    pattern => {
        summary => 'Retrieve pattern from Regexp::Common',
        gen_args => {
            pattern => {
                schema => ['array*', of=>'str*'],
                req => 1,
            },
        },
        gen => sub {
            my %args = @_;

            my $pat = $args{pattern};
            require Regexp::Common;
            Regexp::Common->import;
            my $RE = \%{ __PACKAGE__ . "::RE" };
            my @pat = @$pat;
            my $res = $RE;
            while (@pat) {
                if ($pat[0] =~ /^-/) {
                    $res = $res->{ $pat[0] => $pat[1] };
                    shift @pat;
                    shift @pat;
                } else {
                    $res = $res->{ $pat[0] };
                    shift @pat;
                }
            }
            qr/$res/;
        },
    },
);

1;
# ABSTRACT: Regexps from Regexp::Common

=head1 SYNOPSIS

 use Regexp::Pattern;

 my $re = re('RegexpCommon::pattern', pattern => ['num', 'real']);


=head1 DESCRIPTION

This is a bridge module between L<Regexp::Common> and L<Regexp::Pattern>. It
allows you to use Regexp::Common regexps from Regexp::Pattern. Apart from being
a proof of concept, normally this module should not be of any practical use.


=head1 SEE ALSO

L<Regexp::Common::RegexpPattern>, the counterpart.

L<Regexp::Common>

L<Regexp::Pattern>
