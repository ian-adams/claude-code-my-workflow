---
name: design-conjoint-expert
description: Design conjoint experiments with proper attribute architecture, power analysis, and AMCE estimation in R.
disable-model-invocation: true
argument-hint: "[topic or research question for conjoint design]"
---

# Conjoint Design Expert

Design rigorous conjoint experiments with proper attribute orthogonality, statistical power, and AMCE estimation. Generates R code for design, analysis, and power calculation.

## Steps

1. **Define the Research Question**
   - What decision/preference is being studied?
   - What attributes and levels matter theoretically?
   - What is the target population?
   - What is the hypothesis about which attributes drive choices?

2. **Design the Attribute Architecture**

   ### Orthogonality
   - Every attribute must be independent of every other attribute
   - Randomize attribute order across respondents to prevent primacy/recency effects (unless logical flow is theoretically required)
   - Monitor attribute density: 10 attributes is a common upper limit; evaluate if level complexity increases cognitive load

   ### Level Design
   - Levels should be realistic and meaningful to respondents
   - Avoid implausible combinations (use restrictions sparingly — they complicate analysis)
   - Ensure sufficient variation in each attribute

3. **Calculate Statistical Power**

   ### Effective N
   ```
   Effective N = Respondents x Tasks x Profiles
   ```

   ### Type S and Type M Errors
   When power is low, beware of:
   - **Type S (Sign) errors:** Getting the direction wrong
   - **Type M (Magnitude) errors:** Exaggerating the effect size

   These are especially dangerous in conjoint designs where many attributes are tested simultaneously.

   ### Minimum Detectable Effect (MDE)
   Set MDE based on the attribute with the highest number of levels — this level will be most difficult to estimate precisely.

   ### R Power Analysis
   ```r
   library(cjpowR)

   # Power calculation for conjoint
   cjpowr(
     n_respondents = 1000,
     n_tasks = 5,
     n_profiles = 2,
     n_attributes = 8,
     n_levels = c(3, 4, 2, 3, 5, 2, 3, 4),  # Levels per attribute
     alpha = 0.05,
     power = 0.80
   )
   ```

4. **Generate R Analysis Code**

   ### Design Generation
   ```r
   library(cjoint)

   # Create factorial design
   design <- makeDesign(
     type = "constraints",
     attribute.levels = list(
       Attribute1 = c("Level A", "Level B", "Level C"),
       Attribute2 = c("Low", "Medium", "High"),
       # ... more attributes
     )
   )
   ```

   ### AMCE Estimation
   ```r
   library(cregg)

   # Average Marginal Component Effects
   amce_results <- cj(
     data = conjoint_data,
     formula = chosen ~ Attribute1 + Attribute2 + Attribute3,
     id = ~respondent_id
   )

   # Plot AMCEs
   plot(amce_results)
   ```

   ### Reference Categories
   Clearly identify the baseline level for every attribute. AMCEs are interpreted as: "the average change in probability of selection when attribute changes from reference level to the level of interest."

5. **Quality Checks**
   - [ ] **Independence:** Is randomization of attribute levels truly independent?
   - [ ] **Power:** Was sample size calculated using the level with the smallest predicted effect?
   - [ ] **Baseline:** Are reference categories for all attributes explicitly stated?
   - [ ] **Cognitive load:** Are respondents likely to engage meaningfully with this many attributes?
   - [ ] **Implausible combinations:** Have unrealistic profiles been addressed?

6. **Cross-References**
   - **Came from:** `/causal-hypothesis-architect` (defined what causal effect to estimate)
   - **Methods reporting:** `/transparent-methods-reporter` (document the experimental design)
   - **Analysis:** Generated R code follows `r-code-conventions.md`

## R Packages Required

| Package | Purpose | Install |
|---------|---------|---------|
| `cjoint` | Design generation and analysis | `install.packages("cjoint")` |
| `cregg` | AMCE estimation and plotting | `install.packages("cregg")` |
| `cjpowR` | Power analysis for conjoint | `install.packages("cjpowR")` |

## Common Pitfalls

- Too many attributes causing respondent fatigue and random responding
- Not accounting for attribute order effects
- Using too few tasks per respondent (< 5 is often underpowered)
- Ignoring implausible attribute combinations
- Not pre-registering the design and analysis plan
