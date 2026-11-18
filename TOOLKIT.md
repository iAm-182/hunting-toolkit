# Hunting Toolkit — Hub

One toolkit, ten repos, one workflow. Built 2026-11-18 from the repos the
user sent. The working skills live in `~/workspace/custom-skills/`; the
repos below are the read-only sources.

## Working skills (use these)

| Skill | Path | When to load |
|---|---|---|
| **hunting-toolkit** (master) | `~/workspace/custom-skills/hunting-toolkit/SKILL.md` | START of any hunt — the orchestrator, routes to every layer |
| **bughunter-methodology** | `~/workspace/custom-skills/bughunter-methodology/SKILL.md` | Distilled BugHunter methodology (5-phase workflow, 7-Question Gate, discipline rules) |

## Source repos (read-only)

| Repo | Location | Size | Skills | Role |
|---|---|---|---|---|
| elementalsouls/Claude-BugHunter | `~/bugbounty/claude-bughunter/` | 7.1M | 83 | CORE methodology + web hunt patterns + 7-Question Gate |
| shinthink/blitzstrike | `~/bugbounty/blitzstrike/` | 101M | 40 .md | Verification layer + attack patterns + tool catalog |
| pashov/skills | `~/workspace/github-repos/pashov_skills/` | 18M | 5 | Smart-contract DEPTH (12-agent audit, senior SOP, x-ray, fizz) |
| anthropics/skills | `~/workspace/github-repos/anthropics_skills/` | 17M | 20 | Standard (spec + skill-creator) + docx/pdf/pptx/xlsx reports |
| mattpocock/skills | `~/workspace/github-repos/mattpocock_skills/` | 1.8M | 39 | BUILD layer (diagnosing-bugs, research, code-review, tdd) |
| NVIDIA/SkillEvaluator | `~/workspace/github-repos/NVIDIA_SkillEvaluator/` | 38M | 9 | QA gate (500+ rules, overlap, A/B impact) |
| mvanhorn/last30days-skill | `~/workspace/github-repos/mvanhorn_last30days-skill/` | 69M | 1 | Research/intel engine (Reddit/X/YouTube/HN/GitHub/Polymarket) |
| google-research/paper-orchestra | `~/workspace/github-repos/google-research_paper-orchestra/` | 4.9M | 0 | Multi-agent orchestration pattern (reference only) |
| yogsec/Hacking-Tools | `~/bugbounty/yogsec_Hacking-Tools/` | 1.1M | 0 | Tool index (~50 categories, README) |
| vxcontrol/pentagi | `~/bugbounty/vxcontrol_pentagi/` | 154M | 0 | Autonomous agent loop + sandbox + knowledge graph (architecture reference) |

Total: 157 SKILL.md files + 40 Blitzstrike skill .md files + 21 manuals.
Full survey: `REPO_SURVEY.md` in this directory.

## Layer map

```
L0  Standard   anthropics spec + skill-creator
L1  Method     BugHunter bb-methodology (canonical)
L2  Hunt       BugHunter hunt-* (web) + Pashov (contracts) + Blitzstrike ap-*/hp-*
L3  Verify     Blitzstrike bs-verify-finding + BugHunter discipline + Pashov senior SOP
L4  Validate   BugHunter triage-validation (7-Question Gate)
L5  Execute    PentAGI agent-loop + sandbox + knowledge graph (reference)
L6  Build      mattpocock diagnosing-bugs / research / code-review / tdd
L7  Research   last30days (intel) + mattpocock research
L8  Report     BugHunter report-writing + anthropics docx/pdf/pptx/xlsx
L9  QA         NVIDIA SkillEvaluator
L10 Catalog    Blitzstrike tools-catalog.json + yogsec README
```

## How the pieces complement each other

1. **Pashov + BugHunter** = full-stack coverage (web breadth + contract
   depth), highest value for the Immunefi/Safe lane.
2. **PentAGI + BugHunter** = autonomous hunting that follows a proven
   methodology, sandboxed, with findings kept in a knowledge graph.
3. **SkillEvaluator + everything** = QA layer; run it over the combined
   set before trusting it.
4. **Blitzstrike + BugHunter** = no weak link: hypothesis → live-verify
   with negative control → 7-Question Gate → report.
5. **Anthropic skill-creator + mattpocock engineering** = the BUILD layer:
   write PoCs correctly, debug them, review them, package the toolkit
   itself as proper skills.

## Rules

- Only hunt in-scope, authorized targets. User approves each active test
  first. Read-only recon until then.
- One canonical doc per overlap (BugHunter methodology + report template);
  the rest are reference.
- New repos the user sends: clone shallow, survey, distill into a custom
  skill if it adds a layer — don't just read-only clone.
- Daily trending check: `github-trending-watch` cron (every day) scans
  https://github.com/trending and clones interesting repos here.
