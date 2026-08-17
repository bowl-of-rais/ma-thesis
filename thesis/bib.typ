// source: https://forum.typst.app/t/how-to-share-bibliography-in-a-multi-file-setup/1605/8
// bib.typ
#let load-bib(main: false) = {
  counter("bibs").step()

  context if main {
    //[#bibliography("ma.bib", style: "association-for-computational-linguistics.csl") <main-bib>]
    [#bibliography("ma.bib", style: "ieee") <main-bib>]
  } else if query(<main-bib>) == () and counter("bibs").get().first() == 1 {
    // This is the first bibliography, and there is no main bibliography
    //bibliography("ma.bib", style: "association-for-computational-linguistics.csl")
    bibliography("ma.bib", style: "ieee")
  }
}