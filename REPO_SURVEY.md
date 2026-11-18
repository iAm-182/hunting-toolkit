# Repo Survey — Unified Hunting Toolkit

Survey date: 2026-11-18. Read-only exploration; no files modified.
Goal: map what each cloned repo offers so the best parts can be combined
into one unified bug-bounty / security-research toolkit.

## At a glance

| Repo | Size | SKILL.md | What it is |
|---|---|---|---|
| anthropics_skills | 17M | 20 | Official Anthropic example skills + Agent Skills spec |
| mattpocock_skills | 1.8M | 39 | "Skills for real engineers" — engineering workflow skills |
| pashov_skills | 18M | 5 | Pashov Audit Group Solidity security skills (auditor, x-ray, fizz) |
| mvanhorn_last30days-skill | 69M | 1 | /last30days — engagement-scored multi-platform research engine |
| NVIDIA_SkillEvaluator | 38M | 9 | Evaluate skills: quality, security, overlap, real impact |
| google-research_paper-orchestra | 4.9M | 0 | Multi-agent framework for automated research-paper writing |
| yogsec_Hacking-Tools | 1.1M | 0 | Curated list of pentest/hacking tools (~50 categories, README only) |
| vxcontrol_pentagi | 154M | 0 | PentAGI — self-hosted multi-agent autonomous pentest system |
| claude-bughunter | 7.1M | 83 | Bug-bounty skill bundle from 681 disclosed HackerOne reports |
| blitzstrike | 101M | 0* | MCP security-audit toolbelt (BLITZ → EAGLE-EYE → STRIKE) |

\* blitzstrike has no `SKILL.md` files, but 40 skill `.md` files in `skills/`
and 21 domain manuals in `manuals/`. Total SKILL.md across all repos: **157**.

---

## 1. anthropics_skills — `~/workspace/github-repos/anthropics_skills/`

**One line:** Official Anthropic example skills for Claude, including the
production document skills and the Agent Skills specification.

**Structure (top 2 levels):**
```
README.md  THIRD_PARTY_NOTICES.md
skills/    (18 skill dirs)
spec/      (Agent Skills specification)
template/  (skill template)
```

**Content:** 20 SKILL.md files in four groups:
- Document skills (production, Apache 2.0): `docx`, `pdf`, `pptx`, `xlsx`
- Development & Technical: `skill-creator`, `mcp-builder`, `webapp-testing`,
  `claude-api`, `web-artifacts-builder`, `frontend-design`
- Creative & Design: `algorithmic-art`, `canvas-design`, `theme-factory`,
  `brand-guidelines`, `slack-gif-creator`
- Enterprise & Comms: `doc-coauthoring`, `internal-comms`,
  `discernment-nudge`, `academy-guide`

**Most valuable for a hunting operator:**
1. `skills/skill-creator/SKILL.md` — meta-skill: create, modify, improve
   skills, run evals, benchmark performance, optimize trigger descriptions.
   This is the skill for building the unified toolkit itself.
2. `skills/webapp-testing/SKILL.md` — Playwright toolkit for interacting
   with and testing local web apps (verify frontend behavior, screenshots,
   browser logs). Useful for verifying browser-based PoCs.
3. `skills/mcp-builder/SKILL.md` — guide for building high-quality MCP
   servers (Python FastMCP / Node-TS SDK). Useful if the toolkit needs a
   custom MCP server (e.g. wrapping a target API).
4. `skills/docx|pdf|pptx|xlsx/SKILL.md` — the production document skills.
   Directly useful for report deliverables (Word/PDF reports, Excel
   tracking sheets, decks).
5. `spec/` — the Agent Skills specification itself; the format standard
   every combined skill must conform to.

**Complements the others by:** providing the format standard, the
skill-creation methodology, and the document-production layer. Nothing
else in the set teaches how to *write* a good skill or produce a polished
report file.

**Not useful / out of scope:** `slack-gif-creator`, `algorithmic-art`,
`theme-factory`, `brand-guidelines`, `canvas-design` (creative/design,
no hunting relevance). `academy-guide`, `internal-comms`,
`discernment-nudge` (enterprise comms).

**Single most valuable file:** `skills/skill-creator/SKILL.md`

---

## 2. mattpocock_skills — `~/workspace/github-repos/mattpocock_skills/`

**One line:** "Skills for real engineers" — small, composable, model-agnostic
agent skills for daily engineering work (not vibe coding).

**Structure (top 2 levels):**
```
README.md  AGENTS.md  CLAUDE.md  SCOPE.md  GLOSSARY.md
docs/  scripts/  skills/
skills/engineering/   (20 skills, promoted)
skills/productivity/  (7 skills, promoted)
skills/misc/          (4 skills, rarely used)
skills/in-progress/   (8 skills, beta)
skills/deprecated/
```

**Content:** 39 SKILL.md files. Promoted buckets are `engineering/` and
`productivity/`; `ask-matt` is the router mapping all user-reachable skills.
House rules live in `AGENTS.md` (repo-maintenance conventions: README/plugin
manifest sync, no em-dashes, docs pages per promoted skill) — contributor
rules for that repo, not constraints on read-only use.

**Most valuable for a hunting operator:**
1. `skills/engineering/diagnosing-bugs/SKILL.md` — diagnosis loop for hard
   bugs and performance regressions. Directly useful when a PoC does not
   reproduce or a finding behaves inconsistently.
2. `skills/engineering/research/SKILL.md` — investigate a question against
   high-trust primary sources and capture findings as a Markdown file.
   Useful for target/protocol research before a hunt.
3. `skills/engineering/code-review/SKILL.md` — parallel Standards + Spec
   review of changes since a fixed point. Useful for reviewing PoC code
   and audit-target diffs before submitting.
4. `skills/engineering/tdd/SKILL.md` + `skills/engineering/implement/SKILL.md`
   — build PoCs and exploit code test-first, in small verifiable steps.
5. `skills/engineering/ask-matt/SKILL.md` — router pattern: a single skill
   that maps every other skill and how they relate. A pattern worth copying
   for the unified toolkit's own router.

**Complements the others by:** supplying the engineering discipline layer —
diagnose, research, review, build test-first. BugHunter tells you *what
vuln to hunt*; mattpocock tells you *how to build the PoC correctly* and
*how to debug it when it fails*.

**Not useful / out of scope:** `writing-beats`, `writing-fragments`,
`writing-shape` (creative writing), `scaffold-exercises`,
`migrate-to-shoehorn`, `setup-ts-deep-modules`, `chief-of-staff`,
`software-factory` (too generic / off-domain). `in-progress/` is beta.

**Single most valuable file:** `skills/engineering/diagnosing-bugs/SKILL.md`

---

## 3. pashov_skills — `~/workspace/github-repos/pashov_skills/`

**One line:** Pashov Audit Group's AI-powered Solidity security skills —
a parallelized auditor, a pre-audit x-ray, and a fuzz-suite generator.

**Structure (top 2 levels):**
```
README.md  CLAUDE.md
solidity-auditor/   (SKILL.md, references/, VERSION)
x-ray/              (SKILL.md, references/, scripts/)
fizz/               (SKILL.md, agents/, skills/, templates/, evals/, references/)
static/             (demo gifs only)
```

**Content:** 5 SKILL.md files, but the depth is in `references/`:
- `solidity-auditor/` — 12-agent parallel audit with loop mode (N passes,
  each told what earlier passes found), a memory ledger between scans, and
  a senior-auditor SOP. `references/hacking-agents/` holds 12 specialized
  agents: access-control, asymmetry, boundary, economic-security,
  execution-trace, first-principles, flow-gap, invariant, math-precision,
  numerical-gap, periphery, trust-gap (+ `shared-rules.md`).
  `references/senior-auditor-sop.md` teaches the reasoning mindset
  (Feynman test first; three mental tools; "a finding is not real until
  you've traced the attack with concrete values").
- `x-ray/` — pre-audit scan producing `x-ray.md`: overview, enhanced
  threat model (protocol-type profiling, git-weighted attack surfaces,
  temporal risk, composability mapping), invariants, integrations, docs
  quality, test analysis, git history. Scripts:
  `scripts/analyze_git_security.py`, `scripts/entry_points.py`,
  `scripts/enumerate.sh`.
- `fizz/` — generates Echidna/Medusa-compatible fuzz suites for Foundry /
  Hardhat projects; invariant-discovery agents + `fizz-convert` /
  `fizz-sync` sub-skills.

**Most valuable for a hunting operator:**
1. `solidity-auditor/references/senior-auditor-sop.md` — the senior
   auditor's mindset. The highest-leverage single doc in this repo: it
   teaches *how to reason* about code, not just which patterns to match.
2. `solidity-auditor/references/hacking-agents/*.md` — 12 specialized
   audit agents, each a different lens on the same code (economic,
   invariant, math-precision, trust-gap, etc.).
3. `solidity-auditor/SKILL.md` — the orchestration itself: 12-agent
   parallel audit, loop mode, memory ledger. A template for running a
   multi-agent audit.
4. `x-ray/SKILL.md` + `x-ray/references/threats.md` — pre-audit threat
   modeling; the fastest way to decide whether a protocol is worth a
   full audit and where its attack surface concentrates.

**Complements the others by:** supplying the smart-contract DEPTH that
BugHunter lacks. BugHunter's `web3-audit` is a 10-class checklist with
grep patterns; Pashov is a full multi-agent audit with a senior reasoning
framework and fuzzing. This is the most directly relevant repo for the
Immunefi/Safe work (Threshold, IPOR, SSV reviews) — the exact lane where
PoC-proven findings earned real money.

**Not useful / out of scope:** `static/*.gif` (demo gifs only). Everything
else is on-domain.

**Single most valuable file:**
`solidity-auditor/references/senior-auditor-sop.md`

---

## 4. mvanhorn_last30days-skill — `~/workspace/github-repos/mvanhorn_last30days-skill/`

**One line:** `/last30days` — an AI agent-led search engine scored by
upvotes, likes, and real money (Polymarket), not editors. Searches Reddit,
X, YouTube, TikTok, HN, GitHub, patents, and careers pages in parallel.

**Structure (top 2 levels):**
```
README.md (x10 translations)  AGENTS.md  CONCEPTS.md  CONFIGURATION.md
skills/last30days/   (SKILL.md, scripts/, agents/, references/, assets/)
mcp/                 (Go MCP server)
docs/solutions/      (documented past problems, by category)
tests/  fixtures/  changelog.d/
```

**Content:** 1 SKILL.md. The product is the slash-command skill; the engine
is `skills/last30days/scripts/last30days.py` + `lib/` (search, enrichment,
rendering modules, vendored X search client). A Go MCP server exposes
`research` and `preflight` tools. Setup wizard handles per-source auth
(cookies, API keys, GitHub device-auth).

**Most valuable for a hunting operator:**
1. `skills/last30days/SKILL.md` — the runtime spec: how to research any
   topic across walled-garden sources and synthesize an agent-judged brief.
2. `skills/last30days/scripts/last30days.py` — the engine itself
   (multi-source parallel search + scoring + rendering).
3. `docs/solutions/` — documented solutions to past problems, organized by
   category; a pattern for keeping a hunt knowledge base.

**Complements the others by:** supplying the RESEARCH/INTEL layer.
Use cases: reputation-check a bounty program before hunting it; research
what people are saying about a target protocol (recent incidents, disclosed
bugs, team changes); monitor trending vulns/exploits; Polymarket odds as
a real-money signal. It answers "what is the world saying about X?" —
which no hunting skill in this set does.

**Not useful / out of scope:** the 10 README translations, the MCP bundle
plumbing, and the 69M of tests/fixtures/media. It is NOT a hunting skill
— it finds information, not vulnerabilities. No direct PoC or audit value.

**Single most valuable file:** `skills/last30days/SKILL.md`

---

## 5. NVIDIA_SkillEvaluator — `~/workspace/github-repos/NVIDIA_SkillEvaluator/`

**One line:** Evaluate and improve AI agent skills and plugins — quality,
security, overlap, compatibility, and real impact across agents
(500+ static rules, A/B runs with and without a skill, CI templates).

**Structure (top 2 levels):**
```
README.md  Dockerfile  Makefile  pyproject.toml  uv.lock
skills/skillevaluator/   (SKILL.md, evals/, references/)
src/skillevaluator/      (CLI: cli.py, evaluation/, harness/, config/)
config/  docs/  examples/  tests/  scripts/  ci/
```

**Content:** 9 SKILL.md files (the count includes skill variants/docs;
the core is `skills/skillevaluator/`). The CLI runs checks backed by 500+
static rules and detection patterns without an LLM key, then compares runs
with and without a skill. `references/` holds command tiers, custom
graders, tier-3 datasets, reports-and-CI guidance, troubleshooting.

**Most valuable for a hunting operator:**
1. `skills/skillevaluator/SKILL.md` — the evaluation methodology: how to
   validate/score a SKILL.md, write evals.json test cases, interpret
   benchmark reports, verdicts, exit codes, and gate skills in CI.
2. `skills/skillevaluator/references/` — command tiers, custom graders,
   tier-3 dataset design. The reusable evaluation patterns.
3. `src/skillevaluator/` — the CLI itself, including the 500+ static rules
   (which include security detection patterns — relevant for catching
   prompt-injection or malicious instructions smuggled into a skill file).

**Complements the others by:** supplying the QUALITY GATE for the unified
toolkit. The user's goal is to combine the best parts of 10 repos — that
means merging overlapping skills, and SkillEvaluator is the tool that
detects overlap/duplication, flags security issues in skill files, and
measures whether a given skill actually improves task outcomes. Run it over
the combined set before trusting it.

**Not useful / out of scope:** the full Python package is heavy (38M);
for toolkit purposes the skill + references are the portable part. The
arXiv paper and CI templates are secondary.

**Single most valuable file:** `skills/skillevaluator/SKILL.md`

---

## 6. google-research_paper-orchestra — `~/workspace/github-repos/google-research_paper-orchestra/`

**One line:** A multi-agent framework for automated AI research-paper
writing (Google Cloud AI Research) — outline, literature review, section
writing, refinement, and plotting agents producing submission-ready LaTeX.

**Structure (top 2 levels):**
```
README.md  paper_writing_cli.py  requirements.txt
methods/     (paper_writer.py, paper_writer_with_plotting.py, agents/, prompts/)
autoraters/  frontend/  templates/ (cvpr2025, iclr2025)  utils/  assets/
methods/agents/: outline, literature_review, section_writing,
  content_refinement, plotting
```

**Content:** 0 SKILL.md files. Python multi-agent pipeline: 5 specialized
agents with matching prompt modules, LaTeX automation, conference
templates, autoraters (evaluation), a frontend.

**Most valuable for a hunting operator:**
1. `methods/paper_writer.py` — the orchestrator: how 5 specialized agents
   are sequenced and how their outputs feed each other.
2. `methods/agents/*.py` + `methods/prompts/*.py` — agent implementations
   and their prompts. A concrete template for "specialized agents with
   narrow prompts + a refinement loop."
3. `autoraters/` — the evaluation pattern (rate your own agents' output).

**Complements the others by:** supplying the MULTI-AGENT ORCHESTRATION
PATTERN, not hunting content. The unified toolkit will itself be a team
of specialized agents (recon, audit, PoC, report); PaperOrchestra shows
how Google structures such a team — narrow agent roles, explicit prompts
per agent, a refinement pass, and autoraters to judge quality. Its
literature-synthesis approach is also adaptable to research write-ups.

**Not useful / out of scope:** the paper-writing CLI itself, LaTeX
templates, the frontend, conference formatting. No vulnerability content
whatsoever. Value here is architectural only.

**Single most valuable file:** `methods/paper_writer.py`

---

## 7. yogsec_Hacking-Tools — `~/bugbounty/yogsec_Hacking-Tools/`

**One line:** A curated list of penetration-testing and ethical-hacking
tools, organized by category (Kali tools + notable utilities).

**Structure:**
```
README.md  (single file, ~1,440 lines)  LICENSE  Supporters/
```

**Content:** 0 SKILL.md files, 0 code. One giant README with ~50
categories: Information Gathering, OSINT, Threat Intel, Wireless, Telecom
& 5G, Satellite & RF, Network, Sniffing & Spoofing, Vuln Analysis, Web App
Analysis, Mobile, Cloud, Container & K8s, Supply Chain, Password Attacks,
Social Engineering, Exploitation, Binary Exploitation, Reverse Engineering,
Hardware, IoT, Automotive, ICS/SCADA, Game Hacking, Malware Dev/Analysis,
AI & ML Security, Red/Purple/Blue Team, Threat Hunting, IDS/IPS, SIEM,
Forensics, Crypto, Privacy, Stress Testing, Compliance, CTF, Reporting.

**Most valuable for a hunting operator:**
1. `README.md` (the whole repo) — a tool-discovery index. When a hunt
   needs a tool for a niche ("which tool for container image scanning?",
   "which for ICS?"), this is the lookup.

**Complements the others by:** supplying the TOOL CATALOG (human-readable).
It pairs with Blitzstrike's `tools-catalog.json`, which is the same idea
in machine-readable form. BugHunter and Pashov name tools per phase; this
repo is the shelf you pick them from.

**Not useful / out of scope:** no methodology, no skills, no code — purely
a link list. Links rot; it is a reference, not a capability. The
"Supporters" section is sponsored placements.

**Single most valuable file:** `README.md`

---

## 8. vxcontrol_pentagi — `~/bugbounty/vxcontrol_pentagi/`

**One line:** PentAGI — an open-source, self-hosted multi-agent system for
autonomous penetration testing. Describe a target and a goal; a team of
specialized AI agents plans the work, runs 20+ professional tools
(nmap, Metasploit, sqlmap) inside an isolated Docker sandbox, remembers
what it learned, and hands you a report.

**Structure (top 2 levels):**
```
README.md (4,200+ lines)  CLAUDE.md  Dockerfile  docker-compose*.yml
backend/    (Go: cmd/, pkg/, migrations/, sqlc/, gqlgen/)
frontend/   (React)
examples/   (configs/, prompts/, reports/, tests/, guides/, proposals/)
scripts/  observability/  licenses/
backend/pkg/: controller, docker, graph, graphiti, providers, resources,
  server, system, templates, terminal, tools, database, flowfiles, ...
backend/cmd/: pentagi, installer, ctester, etester, ftester
```

**Content:** 0 SKILL.md files. Full application (154M): Go backend,
React frontend, PostgreSQL + pgvector for memory, optional Neo4j knowledge
graph (Graphiti), Langfuse observability, 10+ LLM providers plus Ollama /
vLLM local models, REST + GraphQL APIs, Docker sandbox execution.

**Most valuable for a hunting operator:**
1. `examples/prompts/` — the agent prompts (the portable, copyable part).
2. `examples/reports/` — report templates and example outputs.
3. `backend/pkg/docker/` + `backend/pkg/tools/` — the sandbox-isolation
   pattern: agents get Docker, not the host. Directly relevant to running
   autonomous hunting safely.
4. `backend/pkg/graph/` + `backend/pkg/graphiti/` — knowledge-graph memory
   (hosts, services, findings as a graph). A model for hunt memory that
   survives across sessions.
5. `backend/cmd/ctester|etester|ftester` — testing harnesses for the agent
   loop itself.
6. `README.md` — architecture + agent supervision docs.

**Complements the others by:** supplying the AUTONOMOUS EXECUTION LAYER.
BugHunter is methodology (what to do); PentAGI is an agent loop that does
it (plan → run tools in sandbox → remember → report). Combined, you get
autonomous hunting that follows a proven methodology instead of wandering,
with sandbox isolation keeping autonomous runs safe and a knowledge graph
keeping findings across sessions.

**Caveat:** 154M and heavy infra (PostgreSQL, Neo4j, Docker Compose). It
is not a light skill to drop in; its value for this operator is
architectural (agent loop + sandbox + memory design), not something to run
wholesale on this VM. Same authorization rules apply: authorized testing
only.

**Not useful / out of scope:** the React frontend, the Enterprise
features, the installer. The Go backend is reference architecture, not
something to execute here as-is.

**Single most valuable file:** `README.md` (architecture + agent
supervision); runner-up: `examples/prompts/`

---

## 9. claude-bughunter — `~/bugbounty/claude-bughunter/`

**One line:** A skill bundle for bug-bounty hunting and external red-team
work — 83 skills, 15 slash commands, patterns from 681 disclosed
HackerOne reports. (#1 GitHub trending, 2026-11-18.)

**Structure (top 2 levels):**
```
README.md  INSTALL.md  USAGE.md  ENGAGEMENTS.md
skills/    (83 skill dirs)
commands/  (15 slash commands)
cbh/  engine/  mcp/  research/  eval/  scripts/  tests/  docs/
```

**Content:** 83 SKILL.md files in four layers:
- Think: `bb-methodology` (5-phase non-linear workflow), `redteam-mindset`
- Hunt webapps: 58 `hunt-*` skills (24 vuln classes: idor, sqli, nosqli,
  xss, ssrf, ssti, xxe, auth-bypass, jwt-crypto, oauth, saml, session,
  mfa-bypass, ato, race-condition, business-logic, file-upload,
  deserialization, graphql, grpc, websocket, cors, csrf, cache-poison,
  http-smuggling, host-header, open-redirect, clickjacking, brute-force,
  forgot-password, llm-ai, rag-vector, rce, lfi, dom, api-misconfig,
  cloud-misconfig, k8s, cicd, ldap, aspnet, laravel, nextjs, nodejs,
  nosqli, ntlm-info, saml, shadow-api, sharepoint, source-leak, spa-api,
  springboot, tls-network, subdomain, html-injection,
  exceptional-conditions, captcha-bypass, fintech-graphql, misc, dispatch)
- Hit the perimeter: `m365-entra-attack`, `okta-attack`,
  `vmware-vcenter-attack`, `enterprise-vpn-attack`, `cloud-iam-deep`
- Ship it: `triage-validation` (7-Question Gate), `report-writing`,
  `evidence-hygiene`, `bugcrowd-reporting`, `redteam-report-template`
- Web3: `web3-audit` (10 DeFi bug classes + Immunefi paid examples),
  `meme-coin-audit` (Solana/token, rug pulls)
- Recon: `web2-recon`, `offensive-osint`, `osint-methodology`,
  `recon-scope-triage`, `supply-chain-attack-recon`, `security-arsenal`
- Other: `apk-redteam-pipeline`, `ios-redteam-pipeline`,
  `mid-engagement-ir-detection`, `bb-local-toolkit`

Already distilled into a working custom skill at
`~/workspace/custom-skills/bughunter-methodology/SKILL.md` (2026-11-18).

**Most valuable for a hunting operator:**
1. `skills/bb-methodology/SKILL.md` — the 5-phase workflow + mindset +
   discipline rules (marker, body-diff, statistical-sample, shell-loop ban)
   + pushback protocol. The backbone of the unified toolkit.
2. `skills/triage-validation/SKILL.md` — the 7-Question Gate. The
   submission filter that keeps N/A ratio low.
3. `skills/web3-audit/SKILL.md` — 10 DeFi bug classes, Foundry PoC
   template, grep patterns per class, real Immunefi paid examples.
4. `skills/redteam-mindset/SKILL.md` — the DO-NOT-STOP coverage discipline.

**Complements the others by:** being the CORE HUNTING METHODOLOGY — the
backbone everything else plugs into. Pashov adds contract depth,
PentAGI adds the autonomous loop, Blitzstrike adds verification patterns,
NVIDIA adds quality gates, mattpocock adds engineering discipline.

**Gaps (what it does NOT cover):** smart-contract depth (checklist-level
vs Pashov's multi-agent audit), no autonomous agent loop (vs PentAGI), no
skill-quality evaluation (vs NVIDIA), no research/intel engine (vs
last30days).

**Not useful / out of scope:** `meme-coin-audit` is niche (token/rug-pull
due diligence, not bounty hunting); `apk/ios-redteam-pipeline` are mobile
red-team, out of the current lanes.

**Single most valuable file:** `skills/bb-methodology/SKILL.md`

---

## 10. blitzstrike — `~/bugbounty/blitzstrike/`

**One line:** Blitz Strike — "Reconnaissance at speed. Analysis in depth.
Validation before report." An MCP security-audit toolbelt (TypeScript/Bun):
BLITZ recon → EAGLE-EYE analysis → STRIKE live verification, with scope
checks. "A scan hit is a hypothesis. A live test is the verdict."

**Structure (top 2 levels):**
```
README.md  ROADMAP.md  SECURITY.md  chains.json  manuals-index.json
tools-catalog.json  package.json  bun.lock
skills/    (40 .md files — not SKILL.md format)
manuals/   (21 domain dirs)
src/       (TypeScript MCP server)
opencode-agents/  (Blitz / Eagle Eye / Strike agent defs)
templates/  bench/  payloads/  scripts/  test/
```

**Content:** 0 SKILL.md files, but 40 skill `.md` files in `skills/`:
- `bs-*` (orchestration): `bs-orchestrate-engagement`,
  `bs-scope-gate`, `bs-source-audit`, `bs-verify-finding`,
  `bs-write-report`, `bs-web-hunting`, `bs-adversarial-review`
- `ap-*` (attack patterns): AD/NTDS escalation, Kerberos trust abuse,
  CI runner abuse, client-side crypto forgery, installer channels,
  cross-forest trust, Gitea CI injection, IDOR, Linux privesc quickwins,
  multi-domain AD, SSRF cloud metadata, stored XSS admin-bot, VMware
  mem forensics
- `hp-*` (hunting packs): api-security, attack-surface-recon, auth-session,
  business-logic, ci-cd, container-image-scan, dast-active-scan,
  dependency-audit, findings-report, full-security-audit, iac-cloud-posture,
  mobile-app-scan, network-service-scan, sast-code-review, secrets-scan,
  smart-contract-audit, tls-transport, web-app-pentest
- `manuals/` (21 domains): active-directory, blue-team, cloud-native,
  crypto, exploitation, forensics, information-gathering, mobile,
  password, playbooks, post-exploitation, red-team, reporting,
  reverse-engineering, rfid-nfc
- `tools-catalog.json` — machine-readable tool catalog, 15 categories
  (recon, enumeration, exploitation, web, AD, post-exploitation, red-team,
  blue-team, reverse-engineering, forensics, mobile, wireless, cloud,
  crypto, utility)

**Most valuable for a hunting operator:**
1. `skills/bs-verify-finding.md` — hypothesis → live verify with negative
   control. The verification discipline already used in the Meta Muse
   Phase-1 probe.
2. `skills/bs-scope-gate.md` — scope enforcement before any test.
3. `skills/hp-smart-contract-audit.md` — its contract-audit pack
   (overlaps Pashov/BugHunter web3-audit — see overlaps).
4. `tools-catalog.json` — machine-readable tool catalog; the structured
   counterpart to yogsec's human-readable list.
5. `skills/ap-ssrf-cloud-metadata.md` + `skills/ap-idor-exploitation.md`
   — concrete attack-pattern write-ups with bypass tables.

**Complements the others by:** supplying the VERIFICATION LAYER and the
attack-pattern library. BugHunter gives the workflow and the submission
gate; Blitzstrike gives the per-finding verify procedure ("live test is
the verdict") and a deep pattern library, including AD/Kerberos/VMware/
forensics depth that BugHunter does not have. Its MCP server (`src/`) is
the toolbelt implementation; its `opencode-agents/` are the agent
definitions.

**Not useful / out of scope:** the 101M size is mostly the TS codebase +
manuals; the MCP server requires Bun + client config to run (read-only
methodology use does not). `rfid-nfc` manual, `blue-team` manuals are
off-lane. The `bench/` and `payloads/` dirs are secondary.

**Single most valuable file:** `skills/bs-verify-finding.md`

---

## Overlaps / duplicates across repos

| Overlap | Repos involved | Note |
|---|---|---|
| Same vuln classes (IDOR, SSRF, XSS, SQLi, auth bypass, etc.) | BugHunter `hunt-*` vs Blitzstrike `hp-*`/`ap-*` | Two pattern libraries for the same classes. BugHunter's are distilled from 681 disclosed reports; Blitzstrike's are attack-pattern write-ups with bypass tables. Keep both; they cross-check each other. |
| Smart-contract audit | BugHunter `web3-audit` vs Pashov `solidity-auditor` vs Blitzstrike `hp-smart-contract-audit` | Same domain, three depths: checklist (BugHunter) < pack (Blitzstrike) < multi-agent audit + senior SOP (Pashov). Pashov is the depth layer; BugHunter's is the quick triage layer. |
| Tool catalogs | Blitzstrike `tools-catalog.json` vs yogsec `README.md` | Machine-readable vs human-readable. Same purpose; keep the JSON as the structured source, yogsec as the discovery shelf. |
| Pre-audit scoping | Pashov `x-ray` vs BugHunter `recon-scope-triage` | Both scope a target before a full audit. X-ray is protocol-specific (threat model + git analysis); recon-scope-triage is generic. |
| Skill creation vs evaluation | Anthropic `skill-creator` vs NVIDIA `SkillEvaluator` | Complementary, not duplicate: create vs measure. Use both in sequence. |
| Research | mattpocock `research` vs mvanhorn `last30days` | Both research, different mechanisms: primary-source investigation vs engagement-scored multi-platform search. Complementary. |
| Report writing | BugHunter `report-writing` vs Blitzstrike `bs-write-report` | Two report templates; pick one as canonical (BugHunter's, which is platform-aware) and keep Blitzstrike's as reference. |
| Methodology | BugHunter `bb-methodology` vs Blitzstrike `bs-orchestrate-engagement` | Same 5-phase shape; BugHunter's is the richer doc (mindset + discipline rules + pushback protocol). Use BugHunter's as canonical. |

## The 5 strongest complementarities

1. **Pashov (contract depth) + BugHunter (web breadth + validation gates) =
   full-stack coverage.** Web + smart contracts, each at depth, with the
   7-Question Gate as the shared submission filter. This is the highest-value
   pairing for the Immunefi/Safe lane, where PoC-proven contract findings
   are the money.
2. **PentAGI (autonomous loop + Docker sandbox + knowledge-graph memory) +
   BugHunter (methodology) = autonomous hunting that follows a proven
   methodology.** The loop executes; the methodology steers. Sandbox
   isolation keeps autonomous runs safe; the graph keeps findings across
   sessions.
3. **NVIDIA SkillEvaluator (quality/security/overlap gates) + the whole
   combined set = the QA layer.** It catches prompt-injection smuggled into
   skill files, flags the overlaps listed above, and measures whether each
   skill actually improves outcomes. Run it over the combined toolkit
   before trusting it.
4. **Blitzstrike (verify-finding discipline + attack patterns + tool
   catalog) + BugHunter (workflow + 7-Question Gate) = a chain with no weak
   link:** hypothesis → live-verify with negative control → 7-Question
   Gate → report. Each stage has a named procedure from a different repo.
5. **Anthropic skill-creator + spec (the standard) + mattpocock engineering
   skills (diagnosing-bugs, research, code-review, tdd) = the BUILD layer.**
   Write PoCs correctly, debug them when they fail, review them before
   submitting, and package the unified toolkit itself as proper skills.

## Proposed unified-toolkit layering

```
LAYER 0 — Standard:   anthropics spec/ + skill-creator (format + how to build skills)
LAYER 1 — Method:     BugHunter bb-methodology (5-phase workflow, canonical)
LAYER 2 — Hunt:       BugHunter hunt-* (web) + Pashov solidity-auditor/x-ray/fizz (contracts)
                      + Blitzstrike ap-*/hp-* (attack patterns, AD/enterprise depth)
LAYER 3 — Verify:     Blitzstrike bs-verify-finding + BugHunter discipline rules
                      + Pashov senior-auditor-sop (reasoning) + Foundry/Slither PoC
LAYER 4 — Validate:   BugHunter triage-validation (7-Question Gate)
LAYER 5 — Execute:    PentAGI agent-loop + Docker sandbox + knowledge-graph memory
                      (architecture reference; not run wholesale on this VM)
LAYER 6 — Build:      mattpocock diagnosing-bugs / research / code-review / tdd
LAYER 7 — Research:   last30days (intel) + mattpocock research
LAYER 8 — Report:     BugHunter report-writing + anthropics docx/pdf/pptx/xlsx
LAYER 9 — QA:         NVIDIA SkillEvaluator (run over the combined set)
LAYER 10 — Catalog:   Blitzstrike tools-catalog.json + yogsec README (tool lookup)
```

## Notes

- PaperOrchestra contributes no hunting content; its value is the
  multi-agent orchestration pattern only (Layer 5 reference).
- last30days is a research engine, not a hunting skill; keep it in the
  Research layer, not the Hunt layer.
- The unified toolkit should keep ONE canonical doc per overlap (BugHunter
  methodology, BugHunter report template) and keep the others as reference,
  to avoid two competing procedures for the same step.
- Total SKILL.md: 157 (anthropics 20, mattpocock 39, pashov 5, last30days 1,
  NVIDIA 9, BugHunter 83). Blitzstrike adds 40 skill .md files and 21
  manuals outside the SKILL.md format.
