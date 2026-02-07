---
name: transparent-methods-reporter
description: Draft or audit experimental methods sections against the 19-item APSA transparency checklist.
disable-model-invocation: true
argument-hint: "[mode: draft | audit] [filename]"
---

# Transparent Methods Reporter

Ensures experimental methods sections meet high-transparency reporting standards. Operates in two modes: **Draft** (write a methods section from scratch) and **Audit** (check an existing section against the 19-item checklist).

## Steps

1. **Determine Mode**
   - **Draft mode:** Write a complete methods section from researcher's notes/protocol
   - **Audit mode:** Evaluate an existing methods section, produce a compliance report

2. **Draft Mode: Write Methods Section**

   Organize the methods section into four subsections, ensuring every checklist item is addressed:

   ### 2a. Subjects, Recruitment, and Setting
   - Eligibility criteria for participants
   - Exact dates of recruitment and data collection (including follow-ups)
   - Survey firm identification and recruitment methods (if applicable)
   - Response rate with exact calculation formula
   - Setting details (lab, field, classroom, online) and geographic/institutional context

   ### 2b. Allocation and Treatment
   - Whether random assignment was used and the specific procedure (simple, blocked, stratified)
   - Unit of randomization (individual, household, cluster)
   - Baseline balance table (means and SDs by experimental group)
   - Detailed description of every treatment and control condition
   - Complete treatment materials in appendix

   ### 2c. Measurement and Sample Flow
   - Precise definitions for all outcome variables, covariates, and indices
   - CONSORT-style flow documentation:
     - N assessed for eligibility
     - Exclusions before randomization (with reasons)
     - N assigned to each group
     - Proportion receiving intended intervention
   - Attrition analysis: N per group lacking outcome data, relationship to treatment
   - Final analysis sample with rationale for exclusions

   ### 2d. Statistical Analysis
   - Intent-to-Treat (ITT) analysis: means, SDs, Ns for all groups
   - Clustering and weighting procedures
   - Multiple comparison corrections (if applicable)

   Generate LaTeX output:
   ```latex
   \section{Research Design and Methods}
   \label{sec:methods}

   \subsection{Participants and Recruitment}
   % [Content addressing items 1-5]

   \subsection{Randomization and Treatment Conditions}
   % [Content addressing items 5-9]

   \subsection{Measures and Sample Flow}
   % [Content addressing items 10-18]

   \subsection{Statistical Analysis}
   % [Content addressing item 19]
   ```

3. **Audit Mode: Check Existing Methods**

   Read the target file, then evaluate against the 19-item checklist. Report to `quality_reports/`:

   ```markdown
   # Methods Transparency Audit
   **File:** [filename]
   **Date:** YYYY-MM-DD
   **Score:** [N]/19 items addressed

   ## Checklist Results

   | # | Item | Status | Notes |
   |---|------|--------|-------|
   | 1 | Eligibility criteria reported | PASS/FAIL/PARTIAL | [details] |
   | 2 | Recruitment and conduct dates | PASS/FAIL/PARTIAL | [details] |
   | 3 | Survey firm identified | PASS/FAIL/N/A | [details] |
   | ... | ... | ... | ... |
   | 19 | ITT analysis reported | PASS/FAIL/PARTIAL | [details] |

   ## Summary
   - PASS: N items
   - PARTIAL: N items (need improvement)
   - FAIL: N items (missing entirely)
   - N/A: N items

   ## Priority Fixes
   1. [Most critical missing item]
   2. ...
   ```

## The 19-Item APSA Checklist

1. Eligibility criteria for participants reported
2. Specific recruitment and conduct dates (including follow-ups) provided
3. Survey firm identified and recruitment methods described
4. Response rate and calculation method reported
5. Use of random assignment explicitly stated
6. Unit of randomization (individual, group, cluster) identified
7. Table of baseline means and SDs by experimental group provided
8. Detailed description of all treatment and control conditions included
9. Complete treatment materials (scripts, images, etc.) made available
10. Outcome variable measurement and coding defined
11. Exact construction of any indices explained
12. Measurement and coding of all covariates/model variables reported
13. Number of subjects initially assessed for eligibility reported
14. Exclusions prior to randomization and reasons provided
15. Number of subjects assigned to each experimental group stated
16. Proportion receiving the intervention and reasons for non-receipt reported
17. Number of subjects per group lacking outcome data reported
18. Number included in analysis and rationale for exclusions provided
19. Outcome means/SDs/Ns reported using Intent-to-Treat (ITT) analysis

## Cross-References

- **Came from:** `/causal-hypothesis-architect` (defined the identification strategy)
- **Complements:** `/academic-paper-writer` (methods section integrates into full paper)
- **Verified by:** Replication protocol in `.claude/rules/replication-protocol.md`
