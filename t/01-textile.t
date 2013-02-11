#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use HTML::WikiConverter;

my $dialect = 'Textile';

my $wc = new HTML::WikiConverter(dialect => $dialect);

can_ok($wc, 'html2wiki');

is($wc->html2wiki('<h1>text</h1>'), 'h1. text', 'h1');
is($wc->html2wiki('<h2>text</h2>'), 'h2. text', 'h2');
is($wc->html2wiki('<h3>text</h3>'), 'h3. text', 'h3');
is($wc->html2wiki('<h4>text</h4>'), 'h4. text', 'h4');
is($wc->html2wiki('<h5>text</h5>'), 'h5. text', 'h5');
is($wc->html2wiki('<h6>text</h6>'), 'h6. text', 'h6');


is($wc->html2wiki('<strong>text</strong>'), '*text*', 'strong');
is($wc->html2wiki('before <strong>text</strong>'), 'before *text*', 'strong');
is($wc->html2wiki('<strong>text</strong> after'), '*text* after', 'strong');
is($wc->html2wiki(
    'before <strong>text</strong> after'), 'before *text* after', 'strong');
is($wc->html2wiki('before<strong>text</strong>'), 'before[*text*]', 'strong');
is($wc->html2wiki('<strong>text</strong>after'), '[*text*]after', 'strong');
is($wc->html2wiki(
    'before<strong>text</strong>after'), 'before[*text*]after', 'strong');
is($wc->html2wiki(
    "before\n<strong>text</strong>\nafter"), 'before *text* after', 'strong');


is($wc->html2wiki('<b>text</b>'), '*text*', 'b');
is($wc->html2wiki('before <b>text</b>'), 'before *text*', 'b');
is($wc->html2wiki('<b>text</b> after'), '*text* after', 'b');
is($wc->html2wiki(
    'before <b>text</b> after'), 'before *text* after', 'b');
is($wc->html2wiki('before<b>text</b>'), 'before[*text*]', 'b');
is($wc->html2wiki('<b>text</b>after'), '[*text*]after', 'b');
is($wc->html2wiki(
    'before<b>text</b>after'), 'before[*text*]after', 'b');
is($wc->html2wiki(
    "before\n<b>text</b>\nafter"), 'before *text* after', 'b');


is($wc->html2wiki('<em>text</em>'), '_text_', 'em');
is($wc->html2wiki('before <em>text</em>'), 'before _text_', 'em');
is($wc->html2wiki('<em>text</em> after'), '_text_ after', 'em');
is($wc->html2wiki(
    'before <em>text</em> after'), 'before _text_ after', 'em');
is($wc->html2wiki('before<em>text</em>'), 'before[_text_]', 'em');
is($wc->html2wiki('<em>text</em>after'), '[_text_]after', 'em');
is($wc->html2wiki(
    'before<em>text</em>after'), 'before[_text_]after', 'em');
is($wc->html2wiki(
    "before\n<em>text</em>\nafter"), 'before _text_ after', 'em');


is($wc->html2wiki('<i>text</i>'), '_text_', 'i');
is($wc->html2wiki('before <i>text</i>'), 'before _text_', 'i');
is($wc->html2wiki('<i>text</i> after'), '_text_ after', 'i');
is($wc->html2wiki(
    'before <i>text</i> after'), 'before _text_ after', 'i');
is($wc->html2wiki('before<i>text</i>'), 'before[_text_]', 'i');
is($wc->html2wiki('<i>text</i>after'), '[_text_]after', 'i');
is($wc->html2wiki(
    'before<i>text</i>after'), 'before[_text_]after', 'i');
is($wc->html2wiki(
    "before\n<i>text</i>\nafter"), 'before _text_ after', 'i');


is($wc->html2wiki('<div><del>text</del></div>'), '-text-', 'del');
is($wc->html2wiki(
    '<div>before <del>text</del></div>'), 'before -text-', 'del');
is($wc->html2wiki('<div><del>text</del> after</div>'), '-text- after', 'del');
is($wc->html2wiki(
    '<div>before <del>text</del> after</div>'), 'before -text- after', 'del');
is($wc->html2wiki(
    '<div>before<del>text</del></div>'), 'before[-text-]', 'del');
is($wc->html2wiki('<div><del>text</del>after</div>'), '[-text-]after', 'del');
is($wc->html2wiki(
    '<div>before<del>text</del>after</div>'), 'before[-text-]after', 'del');
is($wc->html2wiki(
    "<div>before\n<del>text</del>\nafter</div>"),
    'before -text- after', 'del');


is($wc->html2wiki('<div><ins>text</ins></div>'), '+text+', 'ins');
is($wc->html2wiki(
    '<div>before <ins>text</ins></div>'), 'before +text+', 'ins');
is($wc->html2wiki('<div><ins>text</ins> after</div>'), '+text+ after', 'ins');
is($wc->html2wiki(
    '<div>before <ins>text</ins> after</div>'), 'before +text+ after', 'ins');
is($wc->html2wiki(
    '<div>before<ins>text</ins></div>'), 'before[+text+]', 'ins');
is($wc->html2wiki('<div><ins>text</ins>after</div>'), '[+text+]after', 'ins');
is($wc->html2wiki(
    '<div>before<ins>text</ins>after</div>'), 'before[+text+]after', 'ins');
is($wc->html2wiki(
    "<div>before\n<ins>text</ins>\nafter</div>"),
    'before +text+ after', 'ins');


is($wc->html2wiki('<cite>text</cite>'), '??text??', 'cite');
is($wc->html2wiki('before <cite>text</cite>'), 'before ??text??', 'cite');
is($wc->html2wiki('<cite>text</cite> after'), '??text?? after', 'cite');
is($wc->html2wiki(
    'before <cite>text</cite> after'), 'before ??text?? after', 'cite');
is($wc->html2wiki('before<cite>text</cite>'), 'before[??text??]', 'cite');
is($wc->html2wiki('<cite>text</cite>after'), '[??text??]after', 'cite');
is($wc->html2wiki(
    'before<cite>text</cite>after'), 'before[??text??]after', 'cite');
is($wc->html2wiki(
    "before\n<cite>text</cite>\nafter"), 'before ??text?? after', 'cite');


is($wc->html2wiki('<div><code>text</code></div>'), '@text@', 'code');
is($wc->html2wiki(
    '<div>before <code>text</code></div>'), 'before @text@', 'code');
is($wc->html2wiki(
    '<div><code>text</code> after</div>'), '@text@ after', 'code');
is($wc->html2wiki(
    '<div>before <code>text</code> after</div>'),
    'before @text@ after', 'code');
is($wc->html2wiki(
    '<div>before<code>text</code></div>'), 'before[@text@]', 'code');
is($wc->html2wiki(
    '<div><code>text</code>after</div>'), '[@text@]after', 'code');
is($wc->html2wiki(
    '<div>before<code>text</code>after</div>'), 'before[@text@]after', 'code');
is($wc->html2wiki(
    "<div>before\n<code>text</code>\nafter</div>"),
    'before @text@ after', 'code');

is($wc->html2wiki('<blockquote>text</blockquote>'), 'bq. text', 'blockqute');
is($wc->html2wiki('<blockquote><p>text</p></blockquote>'),
    'bq. text', 'blockqute');
is($wc->html2wiki("<blockquote><p>text<br />\ntext2</p></blockquote>"),
    "bq. text\ntext2", 'blockqute');
is($wc->html2wiki("<blockquote><p>text<br />text2</p></blockquote>"),
    "bq. text\ntext2", 'blockqute');

is($wc->html2wiki(
    '<div><a href="http://www.google.co.jp" target="_blank">Google</a></div>'),
    '"Google":http://www.google.co.jp', 'a');


is($wc->html2wiki('<ul>
  <li>text1</li>
  <li>text2</li>
</ul>'), "* text1\n* text2", 'ul');
is($wc->html2wiki('<ul>
  <li>text1</li>
  <ul>
    <li>text2</li>
  </ul>
</ul>'), "* text1\n** text2", 'ul');


is($wc->html2wiki('<ol>
  <li>text1</li>
  <li>text2</li>
</ol>'), "# text1\n# text2", 'ol');
is($wc->html2wiki('<ol>
  <li>text1</li>
  <ol>
    <li>text2</li>
  </ol>
</ol>'), "# text1\n## text2", 'ol');


is($wc->html2wiki('<table>
<tr>
  <td>1-1</td>
  <td>1-2</td>
</tr>
<tr>
  <td>2-1</td>
  <td>2-2</td>
</tr>
</table>'), "|1-1|1-2|\n|2-1|2-2|", 'table');

is($wc->html2wiki('<table>
<tr>
  <th>1-1</th>
  <th>1-2</th>
</tr>
<tr>
  <td>2-1</td>
  <td>2-2</td>
</tr>
</table>'), "|_. 1-1|_. 1-2|\n|2-1|2-2|", 'table');


is($wc->html2wiki('<pre>
print &quot;Hello, world!\n&quot;
print &quot;hello, world\n&quot;
</pre>
'), "<pre>\nprint \"Hello, world!\\n\"\nprint \"hello, world\\n\"\n</pre>", 'pre');

is($wc->html2wiki("<p>text1</p>\n<p>text2</p>"), "text1\n\ntext2", 'p');


done_testing();

