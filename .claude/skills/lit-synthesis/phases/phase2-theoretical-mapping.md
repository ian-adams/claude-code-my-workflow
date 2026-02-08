# Phase 2: Theoretical Mapping

## Why This Phase Matters

Papers don't exist in isolation—they belong to intellectual traditions, cite foundational texts, and position themselves within ongoing conversations. Theoretical mapping reveals this structure: who the key thinkers are, how concepts travel across papers, and which traditions are in dialogue or tension.

This map directly feeds lit-writeup's architecture phase by clarifying which literatures need engagement.

---

## Your Tasks

### 1. Identify Theoretical Traditions

From your reading notes, cluster papers by theoretical home:

**Questions to ask**:
- Which foundational theorists do multiple papers cite? (Becker, Tyler, Ostrom, Wilson, etc.)
- Are there named frameworks that recur? (procedural justice, deterrence, broken windows, etc.)
- Do papers self-identify with traditions? ("Drawing on institutional theory...")

**Common traditions in policing and criminal justice research**:
- Deterrence theory (Becker, Nagin — certainty, severity, celerity)
- Procedural justice (Tyler — legitimacy, compliance, cooperation)
- Institutional theory (DiMaggio & Powell — isomorphism, legitimacy, organizational fields)
- Rational choice / Public choice (Ostrom, Buchanan — incentive structures, collective action)
- Organizational theory (Wilson, Lipsky — street-level bureaucracy, organizational culture)
- Critical / Conflict theory (power, inequality, racial threat)
- Policy diffusion (Berry & Berry — adoption, implementation, feedback)
- Routine activities / Environmental criminology (Cohen & Felson, Brantingham — opportunity, hot spots)

### 2. Map Citation Networks

For each tradition identified:

**Foundational texts**:
- Which older works does everyone cite?
- These are the "must-cite" sources for your tradition

**Key intermediaries**:
- Which papers translated the foundational work to your empirical domain?
- Often these are the "applied the framework to [X]" papers

**Recent developments**:
- What's the cutting edge?
- Who's extending or revising the tradition?

Create a simple lineage:
```
[Foundational] → [Key Application] → [Recent Extension]
     ↓                  ↓                    ↓
Tyler 1990    → Sunshine & Tyler 2003 → Mazerolle et al. 2013
```

### 3. Document Key Concepts

For each major concept:

```markdown
## [Concept Name]

**Origin**: [Who introduced it? When?]

**Definition**: [How is it defined in the foundational text?]

**In This Literature**:
- [Author 2020] uses it to mean [X]
- [Author 2019] uses it to mean [Y]
- Note: [Any variation in usage]

**Related Concepts**: [What concepts travel with it?]

**Key Quote**: "[Definition quote]" (Author Year:page)
```

### 4. Identify Cross-Traditional Connections

Some papers bridge traditions:
- Paper A uses deterrence theory AND institutional analysis
- Paper B connects procedural justice to organizational theory

Note these bridges—they may reveal synthesis opportunities.

### 5. Map Intellectual Lineages

For each major paper in your corpus:
- Which tradition does it claim?
- Who are its key citations?
- What position does it take within the tradition?

Visual representation (text-based):
```
PROCEDURAL JUSTICE TRADITION
├── Tyler 1990 (foundational)
│   ├── Sunshine & Tyler 2003 (applied to policing)
│   ├── Mazerolle et al. 2013 (applied to encounters)
│   └── Lind & Tyler 1988 (precursor)
├── Nagin & Telep 2017 (deterrence + legitimacy bridge)
│   └── Weisburd et al. 2022 (extended to hot spots)
└── [Your corpus papers here]
```

### 6. Write Theoretical Map

Create `theoretical-map.md`:

```markdown
# Theoretical Map

## Overview

This corpus engages [N] distinct theoretical traditions:
1. [Tradition 1] ([N] papers)
2. [Tradition 2] ([N] papers)
3. [Tradition 3] ([N] papers)

---

## Tradition 1: [Name]

### Foundational Texts
- [Text 1]: [one-line description]
- [Text 2]: [one-line description]

### Key Concepts
- **[Concept A]**: [definition]
- **[Concept B]**: [definition]

### Papers in Corpus Using This Tradition
| Paper | How Tradition Is Used |
|-------|----------------------|
| [Author 2020] | [description/extension/critique] |
| [Author 2019] | [description/extension/critique] |

### Intellectual Lineage
[Text-based tree showing citations]

### Key Quote
> "[Defining quote for the tradition]" (Foundational Text:page)

---

## Tradition 2: [Name]
[Repeat structure]

---

## Cross-Traditional Connections

| Connection | Papers | Significance |
|------------|--------|--------------|
| [Tradition A + B] | [Papers] | [Why this matters] |

---

## Concepts Glossary

| Concept | Tradition | Definition | Key Source |
|---------|-----------|------------|------------|
| [Concept 1] | [Tradition] | [Definition] | [Author Year] |

---

## Implications for Writing

Based on this map:
- **Most developed tradition**: [which one]
- **Underdeveloped tradition**: [which one]
- **Productive synthesis opportunity**: [if any]
- **Recommended lit-writeup cluster**: [Gap-Filler/Theory-Extender/etc.]
```

---

## Guiding Principles

### Traditions Are Not Boxes
Papers often draw on multiple traditions. The map should show connections, not just categories.

### Foundational Texts Matter
Even if everyone cites them, you need to know what they actually say—not just how they're invoked.

### Concepts Drift
The same term may mean different things to different authors. Document variation, don't assume consistency.

### Citation ≠ Agreement
A paper citing Tyler may be critiquing Tyler. Note the stance, not just the citation.

### This Feeds Architecture
The traditions you identify become the subsections and literatures in lit-writeup. Build the map with writing in mind.

---

## Output Files to Create

1. **theoretical-map.md** - Full map with traditions, concepts, lineages

---

## When You're Done

Report to the orchestrator:
- Number of traditions identified
- Key foundational texts
- Any cross-traditional connections
- Concepts that need careful definition
- Preliminary cluster recommendation for lit-writeup

Example summary:
> "Theoretical mapping complete. **Three traditions** identified: procedural justice (anchored by Tyler 1990), deterrence theory (anchored by Nagin 2013), and organizational theory (anchored by Wilson 1968). Cross-traditional connection noted: 3 papers bridge deterrence and procedural justice. Key concept variation: 'legitimacy' means different things across papers. Recommend **Synthesis Integrator** cluster for lit-writeup given opportunity to bridge traditions. Ready for Phase 3."
