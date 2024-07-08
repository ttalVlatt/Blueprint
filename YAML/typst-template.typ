
// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'article' which provides
// various customization options. This function is called from the 
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find 
// documentation on creating typst templates and some examples here: 
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates

#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  cols: 1,
  margin: 1in,
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: "arial",
  fontsize: 12pt,
  sectionnumbering: none,
  toc: false,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
    number-align: right + top, 
    // header: "Capaldi Route to Retention"
  )
  set par(leading: 2em, // double spacing within paragraphs
          first-line-indent: 3em, // triple space indents to start paragraphs,
          justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)

  if title != none {
    align(center)[#block(inset: 2em)[
      #set text(weight: "bold");
      #set par(justify: false);
      #title]]
    }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(center)[
            #author.name \
            #author.affiliation \
            #author.email
          ]
      )
    )
  }

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[Abstract] #h(1em) #abstract
    ]
  }

  if toc {
    block(above: 0em, below: 2em)[
    #outline(
      title: auto,
      depth: none
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

// show rules

#show par: set block(spacing: 2em) // double spacing between paragraphs
#show heading: set block(above: 2em, below: 2em) // double spacing around headings

// headings
#show heading: set text(12pt) // set all headings to 12pt text
#show heading.where(level: 1): set align(center) // center level one headings
#show heading.where(level: 3): set text(style: "italic")
#show heading.where(level: 4): it => text(it.body + [.]) // h/t https://github.com/mvuorre/quarto-apaish/blob/main/_extensions/apaish-document/typst-template.typ
#show heading.where(level: 5): it => text(it.body + [.], style: "italic")

#show link: underline

// tables
#set table(
  fill: (_, y) => if calc.odd(y) { rgb("EAF2F5") },
  stroke: 0.25pt,
  align: horizon + start,
  //stroke: (x, y) => ( y: 1pt),
  //stroke: frame(rgb("21222C")),
  //stroke: 0.25pt,
  //gutter: 0.1em,
  //fill: (x, y) =>
    //if x == 0 or y == 1 { gray },
  //inset: (right: 1.5em),
)

#show table: set par(leading: 1em) // single space text in tables
#show table: set text(1em) // use font 80% size of main font in tables

//#show figure: set block(breakable: false)
//#set figure(#align: left[])
