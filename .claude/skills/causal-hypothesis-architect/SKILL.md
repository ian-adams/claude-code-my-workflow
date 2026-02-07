---
name: causal-hypothesis-architect
description: Transform theoretical concepts into falsifiable, counterfactual-based hypotheses with DAG visualization and identification strategy.
disable-model-invocation: true
argument-hint: "[research question or theoretical claim]"
---

# Causal Hypothesis Architect

Transform vague theoretical claims into rigorous, falsifiable hypotheses. Forces explicit definition of the Data Generating Process (DGP), causal diagram, and the specific observations that would prove the theory wrong.

## Steps

1. **Define the Data Generating Process (DGP)**
   - Before drafting the hypothesis, describe the rules governing how the data is created
   - What are the underlying mechanics of the world being studied?
   - What variables are observed? What is unobserved?

2. **Map the Causal Diagram (DAG)**

   Visualize the causal relationships. Offer two output formats:

   **TikZ (for Beamer slides)** — follow `tikz-visual-quality.md` conventions:
   ```latex
   \begin{tikzpicture}[
     node distance=2cm,
     every node/.style={draw, rounded corners, minimum width=1.5cm, minimum height=0.8cm}
   ]
     \node (X) {Treatment};
     \node (Y) [right=of X] {Outcome};
     \node (U) [above right=1cm and 1cm of X] {Confounder};
     \draw[->, thick] (X) -- (Y);
     \draw[->, thick, dashed] (U) -- (X);
     \draw[->, thick, dashed] (U) -- (Y);
   \end{tikzpicture}
   ```

   **R `dagitty` + `ggdag`** (for analysis and Quarto):
   ```r
   library(dagitty)
   library(ggdag)

   dag <- dagitty("dag {
     Treatment -> Outcome
     Confounder -> Treatment
     Confounder -> Outcome
   }")
   ggdag(dag) + theme_dag()
   ```

   Identify:
   - **Backdoor paths:** Variables that correlate with both cause and effect
   - **Instruments:** Variables that affect treatment but not outcome directly
   - **Mediators:** Variables on the causal path

3. **Close the Backdoors**
   - State which variables must be controlled to isolate the treatment effect
   - If using an experiment, explain how randomization closes these paths
   - If observational, specify the identification strategy (IV, DiD, RDD, matching)

4. **Formulate the Hypothesis**

   Apply Popperian falsifiability:

   - **Counterfactual logic:** Every hypothesis must specify a comparison. Define the "untreated" world. If the hypothesis is that $X$ causes $Y$, what is the state of the world where $X$ is absent?
   - **Directional clarity:** Avoid vague "existence" claims (e.g., "there is an effect"). Use ordinal claims that specify direction (higher/lower) and, where possible, expected functional form.
   - **Null-by-design thinking:** Consider if the research is better served by expecting no effect unless a specific threshold is met.

   Template:
   ```
   H1: Among [TARGET POPULATION], [TREATMENT/EXPOSURE] causes
       [DIRECTION] in [OUTCOME], relative to [CONTROL CONDITION],
       operating through [MECHANISM].

   Falsification: If [SPECIFIC OBSERVABLE PATTERN] is found,
       this hypothesis is rejected.
   ```

5. **Define Scope and Generalization**
   - **Target population:** Explicitly name the population for whom the theory holds
   - **Mechanism vs. effect:** Distinguish between "did it happen?" (effect) and "why did it happen?" (mechanism)

6. **Quality Checks**
   - [ ] **Falsifiability:** Can I describe a specific data result that would force rejection?
   - [ ] **Identifying assumptions:** Have I stated what must be true for correlation to be causal?
   - [ ] **Counterfactual:** Is the control group clearly defined?
   - [ ] **Population:** Is the scope limited to a specific, named population?

7. **Save Output**

   Save to `quality_reports/plans/YYYY-MM-DD_hypothesis_[topic].md`

8. **Connect to Lifecycle**
   - **Came from:** `/research-ideation` and `/lit-review-assistant`
   - **Next step:** `/scientific-narrative-builder` (use this hypothesis to structure the introduction)
   - **Then:** `/r-econometrics` or `/python-econometrics` (implement the estimation strategy)
