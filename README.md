# Hunting Toolkit

All-in-one hunting toolkit: a unified methodology for bug-bounty hunting, built by distilling 9+ security repos into working skills — not read-only clones.

## What it is

One master skill + focused skills, each distilled from real repos and proven in live hunts:

| Skill | Source | What it does |
|---|---|---|
| `skills/hunting-toolkit/` | Master skill (11 layers) | The operating framework: load first on any hunt. Target rule: always aim top 1–5, never the consolation pool. |
| `skills/bughunter-methodology/` | Claude-BugHunter (elementalsouls) | 5-phase workflow, 7-Question Gate, marker/body-diff/statistical-sample/shell-loop discipline, pushback protocol. |
| `skills/makefun_bounty_entries/` | make.fun bounty workflow | Enter coding bounties end to end. Analyze the deciding metric before submitting; never spend SOL, never pay fees, never submit copied code. |
| `skills/immunefi_bounty_review/` | Immunefi review workflow | Verify a program live, review contracts with Slither triage + Foundry proofs before recommending or submitting. |
| `skills/telegram_gifts_valuation/` | Telegram Gifts workflow | Judge whether a Telegram Gift is worth buying, keeping, or selling. |

`TOOLKIT.md` is the hub index (repo map + key pairings). `REPO_SURVEY.md` is the full survey of the 157 SKILL.md files across the cloned repos. `scripts/trending-watch.sh` is the daily GitHub-trending watcher (clones keyword-matching repos, reports only when something new lands).

## How it was built

Each repo was cloned shallow, surveyed, and distilled into a working skill — then combined so the layers complement each other:

- **Pashov contract depth + BugHunter web breadth** — best for Immunefi/Safe.
- **PentAGI autonomous loop + BugHunter methodology** — autonomous hunting.
- **Blitzstrike verify + BugHunter 7-Question Gate** — no claim without evidence.
- **NVIDIA SkillEvaluator** — QA gate. **mattpocock engineering** — PoC build layer.

## Upstream repos (not vendored — clone them yourself)

The toolkit references these repos; it does not re-host them:

- `elementalsouls/Claude-BugHunter` — BugHunter methodology
- `yogsec/Hacking-Tools`, `vxcontrol/pentagi` — tooling + autonomous loop
- Blitzstrike — read-only verification methodology
- Pashov, mattpocock, NVIDIA SkillEvaluator, and others — see `REPO_SURVEY.md`

## Keeping it up to date

A daily watcher fetches GitHub trending, clones keyword-matching repos, surveys them, distills new skills, and updates this repo. New repos are clone-only — install scripts and repo code are never executed by the watcher.

## Rules

- Target top 1–5, not the consolation pool. The prize zone is the target; any bonus pool is a fallback only.
- Before building/submitting any entry: identify the deciding metric, study the live top entries, verify competitiveness before spending a scarce slot.
- Never submit via a second account to evade a quota. Never spend money, SOL, or fees unless the user explicitly approves that exact spend.
- Verify every claim against code with file + line evidence (Blitzstrike discipline).
