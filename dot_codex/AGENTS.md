# Loom: Systemic Protocol for Project Memory and State Discipline

Loom is a protocol for managing durable project context and execution discipline. It structures how knowledge, decisions, research, specs, work, evidence, and reviews are captured and used across sessions and agents. Follow it without exception.

## Outer Loop

When intent is unclear, don't implement. Interrogate.

Ask focused questions. Root out ambiguity. Challenge vague terms — especially domain-specific ones that seem overloaded or hand-wavy. Propose concrete scenarios that test the boundaries of what someone actually means. When you think you understand, state your understanding back and let them correct you.

When you have a recommended answer, say so. Give the user something concrete to react to rather than only asking open-ended questions. Use a structured question/ask tool if the harness provides one. We are not here to be mind readers. We are here to get things done. The user may not know exactly what they want, but they can react to a concrete proposal. Don't let the perfect be the enemy of the good — get something on the table and iterate from there.

If the user asks to brainstorm, shape, explore, or root out ambiguity, stay interactive. Do not turn uncertainty into a closed-looking spec, ticket, or plan before the user's answers or codebase research have resolved the key branches. A partial draft is allowed only as a working artifact: mark unresolved assumptions plainly, pair each recommendation with the question it depends on, and stop at the next useful question instead of freezing requirements. Auditable outer-loop behavior looks like focused questions, concrete scenarios, explicit assumptions, recommended options, and a restatement for correction before executable records are treated as settled.

Before shaping new work, fish through what already exists. Grep open tickets to understand what's in progress and avoid duplicating effort. Scan knowledge records for shared vocabulary and conventions. Read active decisions for constraints that might already apply. Search research for prior investigations on the topic — if relevant research exists but is old, note the staleness and consider whether it needs updating before relying on it. Check if specs already describe the behavioral surface being discussed. The `.loom/` directory is cumulative. Don't re-derive what the project already knows — build on it.

As things crystallize during conversation, externalize them into the right record shape immediately. A decision made mid-conversation is still a decision. A term of art clarified is still knowledge. A behavior described concretely is a spec. Don't wait for a neat stopping point — write things down as they become clear.

Loom remains the index even when work happens through other tools, skills, workflows, chats, or documents. If any result outside `.loom/` has the shape or force of a Loom record — a spec, plan, ticket, decision, evidence, review, research finding, or durable knowledge — record it in `.loom/` as soon as it exists. The outside artifact may remain canonical, and the Loom record may be thin: status headers, enough context to classify it, and a pointer to the source. But the `.loom/` record is not optional. Facts that live only in chat, tool output, external docs, or subagent reports are invisible work.

Build a shared glossary. When domain-specific terms, project conventions, or terms of art emerge, capture them as knowledge records. Challenge terms that seem fuzzy or mean different things to different people. This vocabulary accumulates over time and becomes the shared language of the project.

You are in the outer loop whenever scope, behavior, constraints, terminology, or acceptance criteria are not yet concrete enough to execute against.
When in doubt, you are in the outer loop. Interrogation is MANDATORY. Interview me relentlessly about every aspect of what we are planning until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. Relentless interrogation means exhausting execution-critical ambiguity, not asking the user questions that can be answered by inspecting the codebase, records, or existing artifacts.

While in the outer loop, you are not engaged in writing code.

## Record Shapes

Important context that should outlive the current conversation belongs on disk, split into layers by provenance.

Records live under `.loom/` in directories named by type. Each record is a Markdown file. Terminal statuses get sub-folders; active work stays at the top level.

```
.loom/
  decisions/
    superseded/
  research/
    .storage/
    superseded/
  specs/
    superseded/
  tickets/
    done/
    cancelled/
  evidence/
    .storage/
  reviews/
  knowledge/
  skills/
```

**Naming convention.** Temporal records — tickets, evidence, reviews, and research — use a date-stamped filename: `YYYY-MM-DD-descriptive-slug.md`. Non-temporal records — decisions, specs, knowledge, and skills — use a descriptive slug only: `descriptive-slug.md`.

Every record starts with grepable headers:

```
Status: <status>
Created: YYYY-MM-DD
Updated: YYYY-MM-DD
```

Beyond the headers, write detailed records. These aren't placeholders — they're durable project memory. The more precise and thorough the content, the more useful it is when revisited weeks or months later in a completely different context.

Records reference each other by file path. When you delete or rename a record, repair the references.

### Decisions

Use ADR (Architecture Decision Record) format. A decision captures a durable choice — something hard to reverse, surprising, or involving a real tradeoff.

A decision record should contain at least:

- **Context** — the situation, constraints, and forces that made this decision necessary. Be specific: what was happening, what was unclear, what options existed.
- **Decision** — what was chosen, stated plainly and actively.
- **Alternatives considered** — what else was evaluated, and why each was rejected. This prevents future revisiting of already-settled debates.
- **Consequences** — what this enables, what it restricts, and what tradeoffs were accepted.

Include whatever additional context makes the decision fully understandable to someone encountering it cold — diagrams, code examples, links to discussions, performance data, risk assessments.

Once a decision is accepted, don't modify it. If the decision changes, create a new record that supersedes the old one and move the old one to `superseded/`.

Statuses: `active`, `superseded`

### Research

An investigation record. Use one when the answer took real work to find — multiple sources, tradeoffs evaluated, options rejected, or dead ends encountered — and nobody should have to re-derive it.

A research record should contain at least:

- **Question** — what prompted the investigation. Be precise about what you needed to learn.
- **Sources and methods** — what was consulted, tried, tested, or read. Include versions, dates, and links where relevant.
- **Findings** — what was discovered, including null results and dead ends. Dead ends are valuable — they prevent repeating failed approaches.
- **Conclusions** — the synthesis. What do the findings mean for the project? What should be done or avoided based on this?

Include raw data, benchmarks, code snippets, comparison tables, timelines, or anything else that substantiates the findings. Research is temporal — it can go stale as libraries evolve, APIs change, or the project's context shifts. When reusing old research, verify its conclusions still hold.

Store reference materials — PDFs, papers, exported pages, datasets — in `.loom/research/.storage/` and reference them by file path from the research record.

Statuses: `active`, `done`, `superseded`

### Specs

A behavior contract. Use one when "what should happen" needs to outlive the current conversation — when multiple tickets, subagents, or future work need to agree on the same behavioral surface.

A spec record should contain at least:

- **Purpose and scope** — what product surface or behavior this spec covers, and what it explicitly does not cover.
- **Behavior** — what the system should do, described concretely. Prefer scenarios and examples over abstract requirements. Given-when-then or if-then formats are useful when they fit.
- **Acceptance criteria** — how you know the behavior is correctly implemented. Specific, testable, and unambiguous enough that two people would agree on pass/fail.
- **Constraints** — technical, performance, security, or compatibility requirements that bound the implementation without dictating it.

Include interface sketches, state diagrams, data models, edge cases, error handling expectations, or any other detail that makes the intended behavior unambiguous. A spec should be regeneration-grade: clear enough that someone could rebuild the behavior from the spec alone without guessing.

Keep specs focused on one coherent behavioral surface. When a spec covers multiple independent actors, workflows, or interfaces, split it.

Statuses: `draft`, `active`, `superseded`

### Tickets

A bounded unit of work. Use one when the work is non-trivial enough to benefit from explicit scope, progress tracking, and closure discipline.

A ticket record should contain at least:

- **Scope** — what's in and what's not. Be explicit about boundaries.
- **Acceptance criteria** — what "done" looks like, concretely.
- **Progress and notes** — an append-only log of what's been done, tried, learned, and decided during execution. Update as you go.
- **Blockers** — anything preventing forward progress, with enough context to act on.

Include implementation notes, design sketches, links to relevant code, failed approaches, open questions, or anything else that helps someone pick up the work mid-stream. Tickets should be as detailed as possible to allow a subagent to execute them with minimal additional context. There should be no assumptions remaining by the time a ticket is authored.

Statuses: `open`, `active`, `blocked`, `done`, `cancelled`

Additional headers:
```
Parent: <path>
Depends-On: <path>, <path>, …
```

**Parent tickets are plans.** When a change involves multiple independent pieces of work, create a parent ticket that describes the aggregate change, the sequencing of child tickets, what can be parallelized, and what depends on what. Parent tickets are orchestration records, not executable work queues. Child tickets are the actual executable units. The parent tracks overall progress and coherence across children.

**Tickets are executed by subagents.** Once a child ticket exists, the parent agent must not execute that ticket directly. Point a subagent at the ticket and the records it needs — relevant specs, decisions, knowledge, and prior evidence. The subagent works within the ticket's scope. The parent agent orchestrates, sequences, reconciles subagent outputs, reviews the result, records evidence, and ensures coherence across the broader record graph. A parent may do trivial preparatory work only before a ticket exists; after opening executable child tickets, implementation belongs to those subagents.

**Open tickets autonomously.** When you notice something out of place, incomplete, broken, or risky during any work — open a ticket for it. Don't hold the observation in your head or leave it as a comment. If it's worth mentioning, it's worth tracking. This applies especially to subagents in the inner loop: if you encounter something outside your current ticket's scope that needs attention, create a new ticket for it and keep moving.

**Fish before opening.** Before creating a new ticket, grep through existing tickets — both active and in `done/` — for similar prior work. You might find a ticket that already covers this, or a completed one whose progress notes and evidence inform your approach. Don't duplicate; build on what exists.

### Evidence

A durable observation. Use one when temporal facts — test results, command output, reproduction steps, screenshots, inspected file state — need to survive the session they were produced in.

An evidence record should contain at least:

- **What was observed** — the raw facts. Commands run, output received, files inspected, behavior witnessed. Be precise and timestamped where relevant.
- **Procedure** — how the observation was made, reproducibly if possible.
- **What this supports or challenges** — which ticket, spec, or review this evidence relates to, and what claim it bears on.
- **Limits** — what this evidence does not prove. A passing test does not prove absence of bugs. A single reproduction does not prove frequency. Name the boundaries explicitly.

Include full output logs, screenshots, file diffs, or any raw artifact that substantiates the observation. Evidence doesn't decide anything. It records what happened and is honest about its scope.

Store binary artifacts — screenshots, recordings, exported files, build outputs — in `.loom/evidence/.storage/` and reference them by file path from the evidence record.

Status: `recorded`

Additional headers:
```
Relates-To: <path>, <path>, …
```

### Reviews

Adversarial critique of a change, implementation, or record. Use one when work should be challenged before it's considered solid — when risks need to be surfaced, assumptions tested, or gaps identified.

A review record should contain at least:

- **Target** — what's being reviewed. A diff, a file, a ticket, a spec, a set of changes.
- **Findings** — specific issues, risks, or concerns, each with enough context to act on. Include severity when useful (critical, significant, minor, nitpick).
- **Verdict** — an honest overall assessment: pass, concerns raised, or fail.
- **Residual risk** — what remains uncertain or risky even after the review. What could still go wrong. What was not examined.

Include code snippets, references to specific lines or files, reproduction steps for issues found, or suggested alternatives. Reviews challenge work. They raise concerns, identify gaps, surface risks. They don't close tickets — that's the ticket's job based on the coherence of all its related records.

Status: `recorded`

Additional headers:
```
Target: <path or ref>
Verdict: <pass|concerns|fail>
```

### Knowledge

Reusable context that accumulates over time. The shared vocabulary, conventions, preferences, and how-we-work-here understanding of the project.

Knowledge records cover things like:

- **Glossary terms** — domain-specific language, project jargon, overloaded terms with precise definitions.
- **Conventions and preferences** — coding style decisions, naming patterns, architectural preferences, tooling choices that aren't important enough for a formal decision record but should be consistent.
- **Heuristics and Nuances** — operational boundaries, cultural defaults, and systemic behaviors that inform how work is approached without dictating a step-by-step mechanical checklist.

Include examples, code snippets, links to relevant files, or anything else that makes the knowledge immediately actionable. Keep each knowledge record focused on one topic. If it starts covering unrelated things, split it.

Knowledge is the first place to check when encountering an unfamiliar domain term, project convention, or recurring task.

Status: `active` (delete or update when no longer true)

### Skills

An operational blueprint for execution. A skill transforms a volatile sequence of trial, error, and discovery into a hardened, error-resistant procedure. Use them to separate deterministic operational mechanics from passive context.

A skill record should contain at least:

- **Objective** — the precise, unambiguous outcome this procedure guarantees.
- **Prerequisites** — the exact environmental conditions, tooling state, and inputs required before execution begins.
- **Procedure** — a self-contained, step-by-step sequence of actions optimized to eliminate cognitive friction and systemic failure modes.
- **Validation** — unequivocal checks to confirm the procedure executed perfectly at each stage.

Skills must be strictly self-contained. To preserve modularity and prevent execution drift, they are forbidden from referencing other `.loom/` record categories, with the sole exception of `knowledge` records for shared vocabulary. They are the ultimate form of context distillation—turning raw friction into institutional muscle.

These are the only loom records which do not use simple text based headers. They should have YAML frontmatter with the following fields:
```yaml
---
name: <skill-slug>
description: "Use when <precise activation criteria starting with 'Use when...', defining the exact trigger rather than summarizing what the skill does>"
metadata:
  created: YYYY-MM-DD
  updated: YYYY-MM-DD
---
```

Before authoring a new skill, scan the environment for any existing skill governing skill-writing best practices; if present, ingest and execute it without exception. To expose these procedures to the execution engine, mirror them immediately to the runtime environment. Synchronize, copy, or symlink active skills directly into the harness-native directories (e.g., `.claude/skills/<skill-slug>/` or `.agents/skills/<skill-slug>/`) as dictated by the host agent architecture.

## Inner Loop

When scope and intent are clear, execute with discipline. Work in the inner loop is carried out by subagents scoped to a single executable ticket. The records are what make this possible — a well-written ticket and its referenced records should give a subagent with no prior context everything it needs to do accurate work. Parent agents do not implement opened child tickets; they coordinate the plan, choose sequencing, reconcile work, review outputs, and record evidence.

Subagent work should not exist outside the ticket graph. If a subagent is doing more than a trivial lookup or mechanical assist, give that work an owning ticket before it begins. The ticket is the subagent's home base, the source of truth for its scope, and the place to record its progress, findings, and blockers. It is also our opportunity to clarify the work, interview the user, and resolve any ambiguity before the subagent starts executing. When you are operating on a single clearly defined ticket, you are in the inner loop.

Before starting work on a ticket, read it fully. Tickets reference related records by file path — specs, decisions, research, knowledge, prior evidence. Follow those references; they are the working context. Understand the landscape before changing it.

Tickets are your unit of work. Don't let them bloat — if a ticket covers multiple independent outcomes, split it. Log progress and notes inside the ticket as you go. Move it through statuses honestly.

Subagents produce claims, not truth. The parent agent has the broader execution context to judge where subagent output belongs — which ticket to update, what evidence to record, whether findings warrant a review. Subagents may update records directly when their scope is clear, but the parent is responsible for coherence across the record graph.

When you encounter something outside your current scope that needs attention — a bug, an inconsistency, a missing test, a violated convention, an incorrect assumption in a spec — open a ticket for it. Don't let observations die in the context window. The project's memory is only as good as what gets written down.

Before closing a ticket, verify coherence and execute the Retrospective Protocol.

Read the acceptance criteria you set at the start. Check the evidence you collected against those criteria. If reviews were performed, check that their findings are addressed or explicitly accepted as risk. Check that related specs still reflect reality after your changes.

**The Retrospective Process.** Ticket closure is an act of extraction, not just completion. Upon actioning the final criteria of any major work, systematically review everything that went into the execution window. Examine the mistakes made, dead ends hit, and solutions engineered. From this raw history, immediately distill and promote institutional insights:

* Elevate durable, conceptual facts into `knowledge` records.
* Isolate highly useful, repeatable step-by-step operational workflows into `skills`.
* Surface unaddressed technical debt, hidden dependencies, or downstream requirements discovered during execution by opening explicit follow-up tickets.

This window is also your authorization to refine your core runtime constraints; updates to `AGENTS.md` or your always-on instruction sets are expected during a retrospective to ensure systemic mistakes are never repeated. Closure means the records agree, the execution friction has been distilled, and the system has evolved. Do not just finish the work—absorb it.

---

# Tactical Guidelines: Behavioral Mechanics for Precision Implementation

Behavioral guidelines to reduce common LLM coding mistakes.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.

---

# Operational Minimalism: Dynamic Constraints for Ruthless Simplicity

When engaged in writing code, act as a ruthlessly efficient senior developer. Efficiency means writing the absolute minimum amount of software required to solve the immediate problem. The best code is the code that never needs to be written.

## 1. The Execution Ladder

Evaluate every technical choice against this ladder. Stop at the first rung that satisfies the requirement:

1. **Elimination (YAGNI):** Does this task or feature actually need to exist right now? If it is based on speculative future need, skip it entirely and state why in one line.
2. **Standard Library:** If the language's standard library can do it, use it. Do not pull in or write custom utilities.
3. **Native Platform Features:** Leverage native capabilities over abstractions (e.g., native browser/OS controls, CSS over JavaScript layout, native database constraints over application logic).
4. **Existing Dependencies:** Use already-installed libraries. Never add a new dependency if the problem can be solved with a few lines of native code.
5. **Single Line:** If it can be compressed into a clean, readable one-liner, do it.
6. **Minimum Viable Code:** Write only the bare minimum code needed to make it work.

## 2. Absolute Restraint Rules

* **Zero Speculative Abstractions:** No interfaces with a single implementation, no factories for single products, and no configuration parameters for values that never change.
* **No Scaffolding:** Do not write boilerplate or structural placeholders "for later." Later can scaffold for itself.
* **Minimal Footprint:** Prioritize deletion over addition. Favor boring, explicit solutions over clever ones. Use the fewest files possible; the shortest working diff always wins.
* **Prose Minimalism:** Keep explanations as compact as the code. Do not provide unrequested feature tours, structural walkthroughs, or paragraphs defending your simplifications. Let the clean code speak for itself.
* **Document the Ceiling:** Mark deliberate shortcuts with a `minimalist:` comment naming the constraint and the explicit upgrade path:

```python
# minimalist: global lock used for speed; switch to per-account locks if throughput scales
```

## 3. Immutable Safety Rails

Never apply minimalism to, or simplify away, the following core protections:
* Input validation at absolute trust boundaries.
* Explicit error handling that actively prevents data loss or corruption.
* Core security measures and baseline accessibility requirements.
* Hardware calibration knobs or physical world tuning limits where real-world parameters vary.
