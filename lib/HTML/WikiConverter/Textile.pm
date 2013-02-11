package HTML::WikiConverter::Textile;
use base 'HTML::WikiConverter';

use strict;
use warnings;

=head1 NAME

HTML::WikiConverter::Textile - Convert HTML to Textile markup

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    use HTML::WikiConverter;
    my $wc = new HTML::WikiConverter(dialect => 'Textile');
    print $wc->html2wiki($html);

=head1 DESCRIPTION

This module contains rules for converting HTML into Textile
markup. See L<HTML::WikiConverter> for additional usage details.

=head1 AUTHOR

MASUDA Takashi, C<< <t-masuda at mvd.biglobe.ne.jp> >>

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc HTML::WikiConverter::Textile

=head1 LICENSE AND COPYRIGHT

Copyright 2011 MASUDA Takashi.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

sub rules {
    my $self = shift;
    my $rules = {
        a => { replace => \&_link },
        b => { alias => 'strong' },
        blockquote => { start => "bq. ",  block => 1, line_format => 'multi' },
        br => { start => "<br />" },
        cite => { start => "[??", end => "??]" },
        code => { start => "[@", end => "@]" },
        del => { start => "[-", end => "-]" },
        div => { trim => 'both' },
        em => { start => "[_", end => "_]" },
        h1 => {
          start => 'h1. ', block => 1, trim => 'both', line_format => 'single'
        },
        h2 => {
          start => 'h2. ', block => 1, trim => 'both', line_format => 'single'
        },
        h3 => {
          start => 'h3. ', block => 1, trim => 'both', line_format => 'single'
        },
        h4 => {
          start => 'h4. ', block => 1, trim => 'both', line_format => 'single'
        },
        h5 => {
          start => 'h5. ', block => 1, trim => 'both', line_format => 'single'
        },
        h6 => {
          start => 'h6. ', block => 1, trim => 'both', line_format => 'single'
        },
        i => { alias => 'em' },
        ins => { start => "[+", end => "+]" },
        li => { start => \&_li_start, trim => 'leading' },
        p => { end => "\n\n", trim => 'both' },
        pre => { preserve => 1 },
        strong => { start => "[*", end => "*]" },
        td => { replace => \&_td },
        th => { replace => \&_th },
        tr => { end => "|\n" },
        ul => { line_format => 'multi', block => 1 },
    };
    
    return $rules;
}

sub postprocess_output {
    my ($self, $outref) = @_;
    $$outref =~ s/(^|\s)\[(\*.+?\*)\](\s|$)/$1$2$3/g; # a [*b*] c => a *b* c
    $$outref =~ s/(^|\s)\[(_.+?_)\](\s|$)/$1$2$3/g; # a [_b_] c => a _b_ c
    $$outref =~ s/(^|\s)\[(-.+?-)\](\s|$)/$1$2$3/g; # a [-b-] c => a -b- c
    $$outref =~ s/(^|\s)\[(\+.+?\+)\](\s|$)/$1$2$3/g; # a [+b+] c => a +b+ c
    $$outref =~ s/(^|\s)\[(\?{2}.+?\?{2})\](\s|$)/$1$2$3/g; # a [??b??] c => a ??b?? c
    $$outref =~ s/(^|\s)\[(@.+?@)\](\s|$)/$1$2$3/g; # a [@b@] c => a @b@ c

    # <br />\n -> <br />\s -> \n
    $$outref =~ s/<br \/>\s*/\n/g;
}

sub _li_start {
    my($self, $node, $rules) = @_;
    my @parent_lists = $node->look_up(_tag => qr/ul|ol/);

    my $prefix = '';
    foreach my $parent (@parent_lists) {
        my $bullet = '';
        $bullet = '*' if $parent->tag eq 'ul';
        $bullet = '#' if $parent->tag eq 'ol';
        $prefix = $bullet . $prefix;
    }

    return "\n$prefix ";
}

sub _link {
    my($self, $node, $rules) = @_;
    my $url = $node->attr('href') || '';
    my $caption = $self->get_elem_contents($node) || '';
    return $caption if $url eq '';
    return sprintf '"%s":%s', $caption, $url;
}

sub _td {
    my($self, $node, $rules) = @_;
    my $data = $self->get_elem_contents($node) || '';
    return sprintf '|%s', $data;
}

sub _th {
    my($self, $node, $rules) = @_;
    my $data = $self->get_elem_contents($node) || '';
    return sprintf '|_. %s', $data;
}

1; # End of HTML::WikiConverter::Textile
