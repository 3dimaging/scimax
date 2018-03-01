
# Table of Contents

1.  [Headings](#org1817901)
    1.  [subheading](#org54ad83b)
        1.  [subsubheading](#orgfdbc234)
2.  [Markups](#orga50e334)
3.  [Lists](#org226b8a9)
    1.  [Numbered lists](#org62117fb)
    2.  [plain lists](#orgeb9aca9)
    3.  [checklists](#org5d53e12)
    4.  [definition lists](#org92744ce)
4.  [Equations](#orgbf104c9)
5.  [Code blocks](#org10e633d)
6.  [Figures](#orge819ed6)
    1.  [another figure](#org31a5a32)
7.  [Tables](#org9b9a1d3)
8.  [Citations  label:sec-citations](#orgcdf9db3)
9.  [Radio targets](#org6b39c24)
10. [Cross-references](#org9bc1036)
11. [Exporting a single file](#org79a9960)
12. [Handling projects](#orgf97f41f)
13. [Downsides to this approach](#org61b227d)

Why? Don't we already have org-mode? Yes, but some places like Markdown, it is no fun to write when you have really technical documents, and it would be harder to get markdown-mode to be as good as org-mode than to do this.

Github's rendering of org-mode is only ok. This might be a nicer way to get better Github pages.


<a id="org1817901"></a>

# Headings

It goes without saying I hope, that we use headings to organize things.


<a id="org54ad83b"></a>

## subheading


<a id="orgfdbc234"></a>

### subsubheading

Anything deeper than this gets turned into paragraphs by default.


<a id="orga50e334"></a>

# Markups

**bold** *italics* <span class="underline">underline</span> <del>strike</del> `verbatim` `code`

subscripts: H<sub>2</sub>O

superscripts: H<sup>+</sup>

Regular urls are fine: <http://google.com>.


<a id="org226b8a9"></a>

# Lists


<a id="org62117fb"></a>

## Numbered lists

1.  one
2.  two
3.  three

Note these letters will render as numbers.

1.  apple
2.  bear
3.  cat


<a id="orgeb9aca9"></a>

## plain lists

-   one
-   two
-   three
    -   with nesting
        -   deeper
    -   back in
-   all the way


<a id="org5d53e12"></a>

## checklists

-   [ ] one
-   [ ] two
-   [ ] three


<a id="org92744ce"></a>

## definition lists

-   **org-mode:** what makes this possible
-   **emacs:** the other thing you need


<a id="orgbf104c9"></a>

# Equations

Suppose you have this equation to solve:

\[8 = x - 4\]  <a name="eq-sle"></a>

You can put a label near this and refer to it later.


<a id="org10e633d"></a>

# Code blocks

    %matplotlib inline
    import matplotlib.pyplot as plt

    plt.plot([1, 2, 4, 8])
    plt.savefig('geometric.png')

[obipy-resources/6236b0f6cfbcdf4e56fd901258712017-49139zaF.png](obipy-resources/6236b0f6cfbcdf4e56fd901258712017-49139zaF.png)


<a id="orge819ed6"></a>

# Figures

You might like a caption with a label you can refer to later. The figures aren't numbered; instead the labels are used. It seems possible to get numbering, but it would take some work.


<figure>
  <img src="./geometric.png">
  <figcaption>Figure (fig-data): A figure with a  caption. <a name="fig-data"></a></figcaption>
</figure>


<a id="org31a5a32"></a>

## another figure


<figure>
  <img src="./geometric.png">
  <figcaption>Figure (fig-data-2): Another figure to check numbering. <a name="fig-data-2"></a></figcaption>
</figure>


<a id="org9b9a1d3"></a>

# Tables

You can have tables, with captions and labels.

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
<caption class="t-above"><span class="table-number">Table 1:</span> A data table. <a name="tab-data"></a></caption>

<colgroup>
<col  class="org-right" />

<col  class="org-right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-right">x</th>
<th scope="col" class="org-right">y</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-right">1</td>
<td class="org-right">1</td>
</tr>


<tr>
<td class="org-right">2</td>
<td class="org-right">4</td>
</tr>


<tr>
<td class="org-right">3</td>
<td class="org-right">9</td>
</tr>


<tr>
<td class="org-right">4</td>
<td class="org-right">16</td>
</tr>
</tbody>
</table>

Here is another table:

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
<caption class="t-above"><span class="table-number">Table 2:</span> A count of categories. <a name="tab-cat"></a></caption>

<colgroup>
<col  class="org-left" />

<col  class="org-right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">category</th>
<th scope="col" class="org-right">count</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">apples</td>
<td class="org-right">2</td>
</tr>


<tr>
<td class="org-left">oranges</td>
<td class="org-right">4</td>
</tr>
</tbody>
</table>


<a id="orgcdf9db3"></a>

# Citations  <a name="sec-citations"></a>

You can have proper scientific citations like this <sup id="9e3ad98c9008c49c9d14834ca3913eb6"><a href="#kitchin-2015-examp" title="Kitchin, Examples of Effective Data Sharing in Scientific Publishing, {ACS Catalysis}, v(6), 3894-3899 (2015).">kitchin-2015-examp</a></sup>, including multiple references <sup id="66b54b1976758a93506a846c2666419b"><a href="#kitchin-2015-data-surfac-scien" title="John Kitchin, Data Sharing in Surface Science, Surface Science , v(), 103-107 (2016).">kitchin-2015-data-surfac-scien</a></sup><sup>,</sup><sup id="9e3ad98c9008c49c9d14834ca3913eb6"><a href="#kitchin-2015-examp" title="Kitchin, Examples of Effective Data Sharing in Scientific Publishing, {ACS Catalysis}, v(6), 3894-3899 (2015).">kitchin-2015-examp</a></sup><sup>,</sup><sup id="fe4ece7c7b3687ca21f32c0ee4e0a542"><a href="#kitchin-2016-autom-data" title="Kitchin, Van Gulick \&amp; Zilinski, Automating Data Sharing Through Authoring Tools, International Journal on Digital Libraries, v(2), 93--98 (2016).">kitchin-2016-autom-data</a></sup>. Check out the tooltips on them in the html that Github renders.

org-ref helps you insert citations from a bibtex database.

It is conceivable to have numbered citations, and fancier formatting, but I have no plans to implement that.


<a id="org6b39c24"></a>

# Radio targets

In org-mode you can define a <a name="target"></a>target that you can make a link to later.


<a id="org9bc1036"></a>

# Cross-references

Remember Table [tab-data](#tab-data) or the category Table ([tab-cat](#tab-cat))?   Or that figure we put a caption on (Fig.  [fig-data](#fig-data)).

How about section [sec-citations](#sec-citations) on citations?

Remember the [target](#target) we referred to earlier?

What matters the most in cross-references is that org-ref helps you complete them.

    print(f'x = {8 + 4}')

    x = 12

The results above show the answer to Eq. [eq-sle](#eq-sle).


<a id="org79a9960"></a>

# Exporting a single file

    (require 'scimax-md)

    scimax-md

To a buffer:

    (pop-to-buffer (org-export-to-buffer 'scimax-md "*scimax-md-export*"))

    #<buffer *scimax-md-export*>

    (require 'scimax-md)
    (org-export-to-file 'scimax-md "scimax-md.md")

    scimax-md.md

# Bibliography
<a id="kitchin-2015-examp">[kitchin-2015-examp]</a> Kitchin, Examples of Effective Data Sharing in Scientific Publishing, <i>{ACS Catalysis}</i>, <b>5(6)</b>, 3894-3899 (2015). <a href=" http://dx.doi.org/10.1021/acscatal.5b00538 ">link</a>. <a href="http://dx.doi.org/10.1021/acscatal.5b00538">doi</a>. [↩](#9e3ad98c9008c49c9d14834ca3913eb6)

<a id="kitchin-2015-data-surfac-scien">[kitchin-2015-data-surfac-scien]</a> "John Kitchin", Data Sharing in Surface Science, <i>"Surface Science "</i>, <b>647()</b>, 103-107 (2016). <a href="http://www.sciencedirect.com/science/article/pii/S0039602815001326">link</a>. <a href="http://dx.doi.org/10.1016/j.susc.2015.05.007">doi</a>. [↩](#66b54b1976758a93506a846c2666419b)

<a id="kitchin-2016-autom-data">[kitchin-2016-autom-data]</a> "Kitchin, Van Gulick \& Zilinski, Automating Data Sharing Through Authoring Tools, <i>"International Journal on Digital Libraries"</i>, <b>18(2)</b>, 93--98 (2016). <a href="http://dx.doi.org/10.1007/s00799-016-0173-7">link</a>. <a href="http://dx.doi.org/10.1007/s00799-016-0173-7">doi</a>. [↩](#fe4ece7c7b3687ca21f32c0ee4e0a542)


<a id="orgf97f41f"></a>

# Handling projects

Your project might have many org files that should all be published. No problem. First, setup your project, e.g.

    (setq org-publish-project-alist
          '(("scimax-md"
             :base-directory "/Users/jkitchin/vc/jkitchin-github/scimax/scimax-md/"
             :publishing-directory "/Users/jkitchin/vc/jkitchin-github/scimax/scimax-md/"
             :publishing-function scimax-md-publish-to-md)))

    (require 'scimax-md)
    (org-publish-current-project)

Now, we can test a link to another file:

1.  A bare file link:  [./ideas.md](./ideas.md).
2.  A file link with description  [ideas](./ideas.md).


<a id="org61b227d"></a>

# Downsides to this approach

I never read or edit the markdown that is produced. There is probably a lot of stuff in it you would never write yourself. If that is a problem, there is a lot to do to get rid of it. Especially the way I use html to get features might not be considered very standard.

This is a one way conversion. If someone edits the markdown, and you re-export, you will clobber their changes.

Not every corner of org-mode has been tested yet.
