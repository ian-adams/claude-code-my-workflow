# Example Outputs Re-Render Rule

When any of the following files are modified, ask the user whether they want the example outputs in `examples/` re-rendered:

- `Quarto/*.scss` — re-render Quarto slides (`examples/quarto-slides/`)
- `Preambles/**` — re-render Beamer slides (`examples/beamer-slides/`)
- `examples/**/*.qmd` or `examples/**/*.tex` — re-render the affected output
- `Bibliography_base.bib` — re-render Word doc (`examples/word-doc/`)

Prompt: "You modified [file]. Want me to re-render the example outputs in `examples/` so they reflect this change?"

Re-render only the affected subset, not all examples.
