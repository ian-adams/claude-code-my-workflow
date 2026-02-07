# Example Outputs

Pre-built reference artifacts for visual QA. Open these to verify that themes render correctly, Beamer compiles, tables look right, and Word output is properly formatted.

## Contents

| Folder | Source | Output | What It Shows |
|--------|--------|--------|---------------|
| `quarto-slides/` | `sample-slides.qmd` | 4 HTML files (one per theme) | All 4 slide themes with boxes, math, code, tables |
| `beamer-slides/` | `sample-beamer.tex` | `sample-beamer.pdf` | Beamer deck with custom environments |
| `latex-table/` | `sample-table.tex` | `sample-table.pdf` | Publication-ready regression & summary tables |
| `word-doc/` | `sample-paper.qmd` | `sample-paper.docx` | Academic paper section with math & citations |

## How to Rebuild

### Quarto slides (all 4 themes)

```bash
cd examples/quarto-slides
bash render-all-themes.sh
```

The script swaps the `theme:` line in the QMD for each theme, renders, and restores the default.

### Beamer slides

```bash
cd examples/beamer-slides
xelatex -interaction=nonstopmode sample-beamer.tex
xelatex -interaction=nonstopmode sample-beamer.tex
```

### LaTeX table

```bash
cd examples/latex-table
xelatex -interaction=nonstopmode sample-table.tex
```

### Word document

```bash
cd examples/word-doc
quarto render sample-paper.qmd --to docx
```

## Notes

- HTML files are self-contained (~4MB each) with MathJax and all assets embedded
- PDF and DOCX files are binary; rebuild from source if they look stale
- No institution-specific content — all examples use generic academic material
