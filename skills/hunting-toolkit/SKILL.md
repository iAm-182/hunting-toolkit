# Hunting Toolkit — Unified

One toolkit, ten repos, one workflow. This is the master orchestrator for
every security-research / bug-bounty hunt. Load this skill first; it routes
to the right layer and the right source repo for each step.

## Sources (all cloned locally, read-only)

| Layer | Repo | Path | What it gives |
|---|---|---|---|
| 0 Standard | anthropics/skills | `~/workspace/github-repos/anthropics_skills/` | Agent Skills spec + skill-creator (how to build skills) + docx/pdf/pptx/xlsx report skills |
| 1 Method | claude-bughunter | `~/bugbounty/claude-bughunter/` | `bb-methodology` — 5-phase workflow, canonical |
| 2 Hunt | claude-bughunter | `~/bugbounty/claude-bughunter/skills/hunt-*/` | 58 web hunt skills (24 vuln classes, from 681 disclosed HackerOne reports) |
| 2 Hunt | pashov/skills | `~/workspace/github-repos/pashov_skills/` | `solidity-auditor` (12-agent audit) + `x-ray` (threat model) + `fizz` (fuzz suites) — contract depth |
| 2 Hunt | blitzstrike | `~/bugbounty/blitzstrike/` | `ap-*` attack patterns + `hp-*` hunting packs (AD/Kerberos/VMware/enterprise depth) |
| 3 Verify | blitzstrike | `~/bugbounty/blitzstrike/skills/bs-verify-finding.md` | Hypothesis → live verify with negative control |
| 3 Verify | pashov/skills | `~/workspace/github-repos/pashov_skills/solidity-auditor/references/senior-auditor-sop.md` | Senior reasoning: Feynman + Socratic + Inversion |
| 4 Validate | claude-bughunter | `~/bugbounty/claude-bughunter/skills/triage-validation/` | 7-Question Gate — submission filter |
| 5 Execute | vxcontrol/pentagi | `~/bugbounty/vxcontrol_pentagi/` | Agent-loop + Docker sandbox + knowledge-graph memory (architecture reference; do not run wholesale on this VM) |
| 6 Build | mattpocock/skills | `~/workspace/github-repos/mattpocock_skills/skills/engineering/` | diagnosing-bugs, research, code-review, tdd — PoC engineering discipline |
| 7 Research | mvanhorn/last30days | `~/workspace/github-repos/mvanhorn_last30days-skill/skills/last30days/` | Multi-platform intel engine (Reddit/X/YouTube/HN/GitHub/Polymarket) |
| 8 Report | claude-bughunter | `~/bugbounty/claude-bughunter/skills/report-writing/` | Platform-aware report formats (canonical) |
| 8 Report | anthropics/skills | `~/workspace/github-repos/anthropics_skills/skills/{docx,pdf,pptx,xlsx}/` | Production document skills for deliverables |
| 9 QA | NVIDIA/SkillEvaluator | `~/workspace/github-repos/NVIDIA_SkillEvaluator/skills/skillevaluator/` | 500+ static rules, overlap detection, A/B skill-impact measurement |
| 10 Catalog | blitzstrike | `~/bugbounty/blitzstrike/tools-catalog.json` | Machine-readable tool catalog (15 categories) |
| 10 Catalog | yogsec/Hacking-Tools | `~/bugbounty/yogsec_Hacking-Tools/README.md` | Human-readable tool index (~50 categories) |
| — | google-research/paper-orchestra | `~/workspace/github-repos/google-research_paper-orchestra/methods/paper_writer.py` | Multi-agent orchestration pattern only (reference) |

Full survey: `~/workspace/github-repos/REPO_SURVEY.md`.
Distilled methodology skill: `~/workspace/custom-skills/bughunter-methodology/SKILL.md`.

## The unified workflow

```
RESEARCH → RECON → MAP → FIND → VERIFY → VALIDATE → BUILD PoC → REPORT
   (L7)     (L1)    (L2)   (L2)    (L3)      (L4)       (L6)       (L8)
```

Non-linear: move freely between phases. Stuck at any phase → go back.
New API found while hunting → return to MAP. WAF blocks → origin IP
from RECON. A Critical found in the first 30 minutes of recon → stop
reconning, validate the Critical fully, report it, then return to recon.

### Target rule — TOP 1-5, not the bonus pool (applies to EVERY hunt)

Aim for the top tier of whatever the reward structure is, never for a
consolation pool. For make.fun: the prize zone is top 50 (top 10 take the
biggest share) — that is the target; the top-1000 rewards pool is only a
small bonus, never the goal. For bug bounties: aim for the highest-severity,
highest-impact finding the scope allows (Critical/High with a proven PoC),
not a pile of lows. Framing a bonus pool or a low tier as the target and the
real prize as a "stretch" is backwards. Before building or reporting, study
what the current top 1-5 do (live leaderboard entries, disclosed top
reports) and build to BEAT them on the deciding metric. (User rule,
2026-11-18; also in the makefun skill and MEMORY.md.)

### Phase 0 — Mode confirmation (before anything else)

Confirm the engagement type first. Write it as the first line in hunt notes.
If it cannot be answered from the user's instruction, ASK once.

| Engagement type | What counts as a finding | What gets rejected |
|---|---|---|
| **Bug bounty** (H1 / Bugcrowd / Intigriti / Immunefi / private VDP) | Impact-demonstrated bugs ONLY. Full chain to attacker-attainable harm. | Hygiene (EoL software alone, permissive CSP alone, stack traces, info disclosure without concrete impact, "best practice" violations) |
| **Red team** (external client engagement) | Hygiene + recon + IoCs + defensive-state observations are ALL deliverables | Nothing — even "no finding here" is reportable |
| **Pentest** (signed SoW / WAPT) | Depends on SoW. Usually accepts hygiene + impact + recon | Out-of-scope assets, unsigned testing |
| **Internal audit** | Compliance-mapped findings (PCI / ISO / NIST) | Findings without a control-mapping |

### Phase 1 — Research & Recon (L7 + L1)

- **Intel first** (last30days): reputation-check the program, research what
  the world says about the target protocol (recent incidents, disclosed
  bugs, team changes). Answers "what is the world saying about X?"
- **Recon**: maximize attack surface. Subdomain enum → DNS → HTTP probing
  → port scan → tech detect. Google Dorks, JS download, hidden param
  discovery, API mapping. 5-minute rule: nothing after 5 min on a host →
  skip, try next host.
- **Smart contracts**: run Pashov `x-ray` first — pre-audit threat model
  (protocol-type profiling, git-weighted attack surfaces, temporal risk,
  composability mapping), invariants, integrations, git history. It decides
  whether a protocol is worth a full audit and where its attack surface
  concentrates.

### Phase 2 — Map & Find (L2)

- **Web**: read the matching `hunt-*` skill in `~/bugbounty/claude-bughunter/skills/`
  before testing that class (idor, sqli, xss, ssrf, auth-bypass, jwt-crypto,
  race-condition, business-logic, graphql, etc.). 58 skills, one per class.
- **Smart contracts**: Pashov `solidity-auditor` — 12-agent parallel audit
  (access-control, asymmetry, boundary, economic-security, execution-trace,
  first-principles, flow-gap, invariant, math-precision, numerical-gap,
  periphery, trust-gap). Loop mode: N passes, each told what earlier passes
  found. Memory ledger between scans.
- **Enterprise / AD / infra**: Blitzstrike `ap-*` attack patterns and
  `hp-*` hunting packs.
- **Reasoning (contracts)**: apply the senior auditor's three tools from
  Pashov `senior-auditor-sop.md`:
  1. **Feynman first** — explain the function in plain words, no jargon.
     The places where the explanation gets fuzzy are where bugs hide.
  2. **Socratic** — for every line: why is this here? What does it assume?
     What happens if the assumption breaks? Drill 2-3 "whys" deep.
  3. **Inversion** — after understanding what code IS supposed to do, ask
     how to make it NOT do that. Read every check: what value slips past
     it? Read every state update: what state am I in just before this?
  - A finding is not real until you've traced the attack with concrete
    values. You are an attacker, not a defender — when you find a bug,
    deepen the attack; never argue yourself out of one.
- **Discovery order**: error-based first (`'`, `"`, `{{7*7}}`), then
  time-based (`SLEEP(10)`), then OOB (interactsh), then boolean.
  20-minute rule: nothing after 20 min on an endpoint → rotate.

### Phase 3 — Verify (L3)

Blitzstrike `bs-verify-finding.md`: a scan hit is a HYPOTHESIS. A live
test is the VERDICT.

- Reproduce via at least TWO independent tools for Critical/High
  (curl + Python requests, Burp + raw socket). Cross-tool consistency
  rules out tool artefacts. Reproduction commands must be paste-into-shell
  ready in the report.
- Negative control: run the same probe against a known-good endpoint /
  a marker-free baseline. If the "signal" appears there too, it is not
  a finding.
- **Discipline rules (non-negotiable, from BugHunter)**:
  - **Marker Discipline**: markers are random alphanumeric, 8+ chars, no
    English words, no protocol keywords. NEVER `test`, `marker`, `evil`,
    `attacker`, `payload`, `javascript`, `script`, `AAAA`, `BBBB`. Before
    claiming reflection, search the BASELINE response for the marker.
  - **Body-Diff Rule**: a bypass claim requires response BODY differential,
    not just status code. 200 OK with byte-identical body is NOT a bypass.
  - **Statistical-Sample Rule**: timing claims need n ≥ 10 INTERLEAVED
    trials per group; signal requires suspect mean ≥ 2σ above control.
    A single 2x outlier is jitter, not signal.
  - **Shell-Loop Ban (>5 iterations)**: use Python with try/except per
    iteration, not shell for-loops. Always count results.
- **PoC engineering (mattpocock)**: build PoCs test-first (tdd), in small
  verifiable steps. When a PoC won't reproduce, run the diagnosing-bugs
  loop. Code-review the PoC before submitting. For contracts: Foundry
  tests + Slither triage; generate fuzz suites with Pashov `fizz`
  (Echidna/Medusa-compatible).

### Phase 4 — Validate (L4)

BugHunter `triage-validation`: the 7-Question Gate. Ask IN ORDER. One wrong
answer = STOP this finding. Kill it. Move on to the next test class.
(Killing a finding does NOT stop the engagement.)

1. Can an attacker use this RIGHT NOW, step by step? (exact HTTP request,
   copy-paste ready — if you cannot write it, KILL IT)
2. Is the impact on the program's accepted impact list? (if it maps to a
   listed exclusion, KILL IT)
3. Is the root cause in an in-scope asset?
4. Does it require privileged access an attacker can't realistically get?
   ("Admin can do X" = KILL IT on 99% of programs)
5. Is this already known or accepted behavior? (search disclosed reports,
   GitHub issues, changelog, API docs)
6. Can it be reproduced on a second account / second tool?
7. Is the severity honest? (CVSS 3.1 must MATCH actual impact)

### Phase 5 — Report (L8)

- BugHunter `report-writing` is canonical (platform-aware: H1/Bugcrowd/
  Intigriti/Immunefi). Title: `[Bug Class] in [Endpoint] allows [role]
  to [impact]`. Impact-first summary (sentence 1 = what attacker CAN do).
  Exact HTTP requests in Steps to Reproduce. Under 600 words.
- For file deliverables, use the Anthropic production document skills
  (docx/pdf/pptx/xlsx) in `~/workspace/github-repos/anthropics_skills/`.
- After submission: while waiting for triage, try to escalate further.
  If a fix is deployed, re-test for bypass (incomplete patch = new bug).

### Execution model (L5 — PentAGI, architecture reference)

When running autonomous hunting: plan → run tools in a sandbox (never on
the host) → remember findings in a knowledge graph → report. The loop
executes; the methodology steers. Sandbox isolation keeps autonomous runs
safe; the graph keeps findings across sessions. Do NOT run PentAGI wholesale
on this VM (154M, needs PostgreSQL/Neo4j/Docker Compose) — borrow the
pattern: narrow agent roles, explicit prompts per agent, a refinement pass.

### QA gate (L9 — NVIDIA SkillEvaluator)

Before trusting the combined toolkit (or any new skill added to it): run
SkillEvaluator's checks — 500+ static rules catch prompt-injection smuggled
into skill files, flag overlaps between merged skills, and A/B-measure
whether a skill actually improves task outcomes.

### Tool lookup (L10)

Need a tool for a niche? Check Blitzstrike `tools-catalog.json`
(machine-readable, 15 categories) or yogsec `README.md` (human-readable,
~50 categories) first.

## Routing — which source for which task

| Task | Read first |
|---|---|
| Start any hunt / "what should I do next" | This skill (workflow above) + `bughunter-methodology` |
| Web vuln class (IDOR, SSRF, XSS, SQLi, ...) | `~/bugbounty/claude-bughunter/skills/hunt-<class>/SKILL.md` |
| Smart contract audit | Pashov `solidity-auditor/SKILL.md` + `senior-auditor-sop.md` + `x-ray/SKILL.md` |
| Contract fuzzing | Pashov `fizz/SKILL.md` |
| Verify a finding | Blitzstrike `skills/bs-verify-finding.md` |
| Enterprise / AD / Kerberos / VMware | Blitzstrike `skills/ap-*.md` / `skills/hp-*.md` |
| PoC won't reproduce / hard bug | mattpocock `skills/engineering/diagnosing-bugs/SKILL.md` |
| Research a target / program reputation | last30days `skills/last30days/SKILL.md` |
| Review PoC code / audit diff | mattpocock `skills/engineering/code-review/SKILL.md` |
| Build a PoC test-first | mattpocock `skills/engineering/tdd/SKILL.md` |
| Write a report | BugHunter `skills/report-writing/SKILL.md` |
| Produce a docx/pdf/xlsx deliverable | anthropics `skills/{docx,pdf,pptx,xlsx}/SKILL.md` |
| Find a tool for a niche | Blitzstrike `tools-catalog.json` or yogsec `README.md` |
| Check a skill for quality / overlap / injection | NVIDIA `skills/skillevaluator/SKILL.md` |
| Create or improve a skill | anthropics `skills/skill-creator/SKILL.md` |

## Overlap policy (one canonical doc per step)

- Methodology: BugHunter `bb-methodology` is canonical. Blitzstrike
  `bs-orchestrate-engagement` is reference.
- Report template: BugHunter `report-writing` is canonical. Blitzstrike
  `bs-write-report` is reference.
- Contract audit depth: Pashov is the depth layer; BugHunter `web3-audit`
  is the quick-triage layer; Blitzstrike `hp-smart-contract-audit` is the
  middle pack.
- Tool catalog: Blitzstrike JSON is the structured source; yogsec README
  is the discovery shelf.
- Skill creation vs evaluation: Anthropic `skill-creator` (create) +
  NVIDIA `SkillEvaluator` (measure) — use in sequence, not as duplicates.

## Scope and authorization

Only hunt in-scope, authorized targets: a published bug bounty program's
scope, a signed engagement, or the user's own systems. Testing outside a
program's published scope or without a signed engagement is out of bounds.
The user approves each active test first. Read-only recon only until then.
