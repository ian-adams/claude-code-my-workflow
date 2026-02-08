---
name: lit-review-assistant
description: Structure literature searches, summarize papers, synthesize findings, and generate BibTeX entries.
disable-model-invocation: true
argument-hint: "[research question or topic]"
---

# Literature Review Assistant

Conduct structured literature reviews: search, summarize, synthesize, and identify gaps. Generates BibTeX entries and integrates with the project bibliography.

## Steps

1. **Define the Research Domain**
   - What is the specific research question?
   - Scope: narrow field survey or cross-disciplinary review?
   - Relevant databases: JSTOR, EconLit, Google Scholar, NBER, SSRN
   - Time period of interest
   - Seminal papers to start from (if known)

2. **Structure the Search**
   - **Primary terms:** Core concepts (e.g., "minimum wage", "employment")
   - **Methodological filters:** (RCT, IV, DiD, RDD, event study)
   - **Outcome terms:** What effects are measured
   - **Geographic/temporal scope:** If relevant

3. **Summarize Each Paper**

   For each key paper, produce a structured summary:

   ```markdown
   ## [Author(s)] ([Year])

   **Title:** [Full title]
   **Published in:** [Journal or Working Paper Series]
   **Research Question:** [One sentence]
   **Data:** [Source, period, sample size]
   **Identification Strategy:** [Method in one sentence]
   **Main Findings:**
   1. [Key result with magnitude]
   2. [Robustness/heterogeneity]
   **Limitations:** [Main concerns]
   **Relevance:** [How it connects to user's project]
   ```

4. **Generate BibTeX Entries**

   For each paper summarized, generate a BibTeX entry and append to `Bibliography_base.bib`:

   ```bibtex
   @article{CardKrueger1994,
     author  = {Card, David and Krueger, Alan B.},
     title   = {Minimum Wages and Employment: A Case Study of the Fast-Food Industry in New Jersey and Pennsylvania},
     journal = {American Economic Review},
     year    = {1994},
     volume  = {84},
     number  = {4},
     pages   = {772--793}
   }
   ```

   After adding entries, recommend running `/validate-bib` to check consistency.

5. **Synthesize and Identify Gaps**

   Produce a synthesis table:

   | Finding | Evidence Quality | Consensus Level |
   |---------|-----------------|-----------------|
   | [Finding 1] | Strong/Medium/Limited | High/Growing/Low |

   Identify:
   - What do papers agree on?
   - Where are disagreements?
   - What questions remain unanswered?
   - What methods haven't been applied?

6. **Connect to Lifecycle**
   - **Came from:** `/research-ideation` (generated the research question)
   - **Next step:** `/causal-hypothesis-architect` (formalize the causal claim)
   - **Also useful:** `/scientific-narrative-builder` (draft the introduction using this review)

## Search Strategy Tips

### Google Scholar Operators
- `"exact phrase"` — Exact matching
- `author:surname` — Papers by specific author
- `source:journal` — Papers in specific journal

### Building Citation Networks
1. Start with 2-3 seminal papers
2. Check forward citations (who cites them)
3. Check backward citations (their references)
4. Identify clusters of related work

## Proactive Tools: The Lit Trilogy

This skill provides **quick-start guidance** for literature reviews. For deeper, automated workflows, use the Lit Trilogy:

| Skill | What It Does | When to Use Instead |
|-------|-------------|---------------------|
| `/lit-search [topic]` | Systematic OpenAlex API search with screening, snowballing, and annotation | You need to build a corpus from scratch with API-powered searching |
| `/lit-synthesis [corpus]` | Deep reading, theoretical mapping, and debate identification | You have papers and need to understand the field structure before writing |
| `/lit-writeup [contribution type]` | Draft Theory/Literature Review sections with cluster-based architecture | You're ready to write and need structured prose with calibrated norms |

**This skill** is best for quick guidance, manual search strategies, and paper-by-paper summaries. The trilogy is for when you need depth and automation.

## Best Practices

1. Use reference managers (Zotero, BibDesk) alongside this skill
2. Track search queries for reproducibility
3. Balance breadth and depth
4. Don't only cite papers that support your argument
5. Don't cite papers you haven't actually read
