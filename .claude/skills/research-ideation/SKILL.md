---
name: research-ideation
description: Generate and refine research questions using economic thinking frameworks. Entry point of the research lifecycle.
disable-model-invocation: true
argument-hint: "[topic, phenomenon, or data source]"
---

# Research Ideation

Generate and refine research questions by applying economic thinking frameworks. This is the entry point of the research lifecycle — from here, proceed to `/lit-review-assistant` and then `/causal-hypothesis-architect`.

## Steps

1. **Understand the Starting Point**
   - Does the user have a phenomenon, puzzle, or data source in mind?
   - What field/subfield of economics?
   - Methodological preference? (empirical, theoretical, structural)
   - Constraints? (data access, timeline, computational resources)

2. **Apply Ideation Frameworks**

   **The Puzzle Approach**
   - What's surprising about current patterns?
   - What contradicts conventional economic wisdom?
   - Where do standard models fail?

   **The Policy Approach**
   - What policies lack rigorous evaluation?
   - What natural experiments remain unexploited?
   - What interventions might solve important problems?

   **The Data Approach**
   - What new data sources have become available?
   - What can existing data tell us that hasn't been explored?
   - What linkages between datasets are possible?

   **The Extension Approach**
   - How can seminal papers be extended to new settings?
   - What mechanisms remain unexplored?
   - Can methods from one field apply to another?

3. **Evaluate Each Idea**

   For each candidate research question, assess:

   | Criterion | Question to Ask |
   |-----------|----------------|
   | Feasibility | Can this be done with available data and methods? |
   | Contribution | What's genuinely new here? |
   | Interest | Who cares about this question? (academics, policymakers, public) |
   | Identification | Can effects be credibly estimated? What's the source of variation? |

   Produce an evaluation matrix ranking ideas on these dimensions.

4. **Save Output**

   Save the ideation output to `quality_reports/plans/YYYY-MM-DD_ideation_[topic].md` with:
   - The top 3-5 research ideas
   - Evaluation matrix
   - Recommended next steps for each

5. **Connect to Lifecycle**

   For the most promising idea, suggest:
   - **Next step:** Run `/lit-review-assistant` to survey existing work on the topic
   - **Then:** Run `/causal-hypothesis-architect` to formalize the causal claim
   - **Then:** Run `/scientific-narrative-builder` to draft the introduction

## Frameworks for Generating Questions

### The "5 Whys" for Economics
Start with an observation and drill down:
1. GDP growth is slowing — Why?
2. Productivity is stagnant — Why?
3. Investment is low — Why?
4. Uncertainty is high — Why?
5. Policy is unpredictable — **Testable: Does policy uncertainty cause low investment?**

### The Cross-Field Pollinator
Take a method from one field and apply to another:
- IO techniques applied to labor markets
- Finance models applied to education returns
- Macro shocks traced to micro outcomes

## Common Pitfalls

- Questions that are too broad ("What causes inequality?")
- Questions without clean identification ("Does education cause income?")
- Questions without feasible data
- Questions already well-answered in the literature
