#!/bin/bash
# Render sample-slides.qmd with each of the 4 themes
# Usage: cd examples/quarto-slides && bash render-all-themes.sh

set -e

THEMES=("academic-clean" "emory-clean" "usc-clean" "uno-clean")
QMD="sample-slides.qmd"

for theme in "${THEMES[@]}"; do
  echo "Rendering with theme: $theme"
  # Swap the theme line in place, render, then restore
  sed -i "s|theme: ../../Quarto/.*\.scss|theme: ../../Quarto/${theme}.scss|" "$QMD"
  quarto render "$QMD" -o "${theme}.html"
  echo "  -> ${theme}.html created"
done

# Restore to academic-clean as the default
sed -i "s|theme: ../../Quarto/.*\.scss|theme: ../../Quarto/academic-clean.scss|" "$QMD"

echo "Done. All 4 themes rendered."
