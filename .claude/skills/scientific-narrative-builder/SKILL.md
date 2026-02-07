---
name: scientific-narrative-builder
description: Draft substantively grounded scientific introductions using the Why-to-If-Then funnel structure.
disable-model-invocation: true
argument-hint: "[research question or hypothesis]"
---

# Scientific Narrative Builder

Transform a research question into a substantively grounded scientific introduction. Prevents "methods-driven" writing and ensures the question drives the method, not vice versa.

## Steps

1. **Establish Substantive Savvy**

   Before writing a single sentence:

   - **Identify the "invisible":** What perceptions, knowledge, beliefs, or reasoning does this study aim to reveal that administrative data cannot capture?
   - **Carve the analytical joints:** Find the specific tension where existing theory is silent or conflicted. The introduction must articulate the "why" before proposing the "how."
   - **Resist the methods-driven temptation:** Ensure the research question dictates the method. Explicitly defend why this method is necessary for this question.
   - **Contextualize:** Situate the study within broader social/economic importance. Move from general significance to specific theoretical gap.

2. **Assemble Evidence Objectively**

   - **Systematic evidence assembly:** Favor meta-analyses or registries over selective citations. If these don't exist, document search and inclusion criteria.
   - **Adjudicate theories:** Clarify if the literature review sets up a "fact searching" mission (estimating a causal effect) or a "theory testing" mission (adjudicating between mechanisms).
   - **The modesty principle:** Frame the study as one link in a "chain of reasoning" — a progression of evidence, not a one-off decisive demonstration.
   - **Account for bias:** Note where prior findings may be skewed by reporting incentives.

3. **Build the "Why" Funnel**

   Structure the narrative as a funnel that narrows from theory to hypothesis:

   ```
   WIDE:  General theory — why things happen in the world
     |    (e.g., "Firms respond to regulatory uncertainty by delaying investment")
     |
   MEDIUM: Specific gap — what we don't know
     |    (e.g., "But we lack evidence on whether this effect varies by firm size")
     |
   NARROW: Hypothesis — the If-Then statement
          (e.g., "If uncertainty increases, then small firms reduce investment
           more than large firms, because they lack hedging capacity")
   ```

   In the introduction:
   - **Define the target population** — don't wait for the methods section
   - **Describe the identifying variation** — what controlled variation reveals the invisible factor?
   - **Preview the main result** — state the finding in the first paragraph

4. **Generate LaTeX Introduction Template**

   Produce a concrete LaTeX template following the funnel:

   ```latex
   \section{Introduction}

   % === HOOK: General importance ===
   [BROAD SOCIAL/ECONOMIC PHENOMENON]. Despite [EXTENSIVE PRIOR WORK],
   we lack evidence on [SPECIFIC GAP].

   % === QUESTION: What this paper asks ===
   This paper asks: [RESEARCH QUESTION]? Specifically, we examine
   whether [PRECISE FORMULATION].

   % === PREVIEW: Main result ===
   We find that [MAIN RESULT IN ONE SENTENCE]. [ECONOMIC MAGNITUDE].

   % === METHOD: Brief identification ===
   To identify this effect, we exploit [STRATEGY]. Our data come from
   [SOURCE], covering [PERIOD] and [SAMPLE SIZE] observations.

   % === CONTRIBUTION: Why it matters ===
   We contribute to [STRAND 1] by [EXTENSION]. We also provide new
   evidence on [STRAND 2] that complements \citet{Author2020}.

   % === ROADMAP ===
   The remainder is organized as follows. Section~\ref{sec:background}
   reviews related work. ...
   ```

5. **Quality Checks**

   - [ ] **Substantive foundation:** Is the question grounded in a real-world tension?
   - [ ] **Invisible factors:** Does the intro name the specific belief or perception it aims to reveal?
   - [ ] **Analytical joints:** Is the theoretical tension clearly identified?
   - [ ] **Counterfactual logic:** Does the narrative establish the "untreated" world?
   - [ ] **Population scope:** Is the target population explicitly named?
   - [ ] **Objective review:** Does the literature review avoid cherry-picking?

6. **Connect to Lifecycle**
   - **Came from:** `/lit-review-assistant` (evidence base) and `/causal-hypothesis-architect` (formal hypothesis)
   - **Next step:** `/academic-paper-writer` (full paper draft using this introduction)
   - **For slides:** `/create-lecture` (adapt the narrative for presentation format)
