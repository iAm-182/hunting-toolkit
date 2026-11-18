# Make.fun Bounty Entries

## Triage a new competition

- Read the competition page and the unpacked kit RULES.txt before you build anything and note the deadline, the prize, the entrypoint and the size caps.

- Check whether the entry is buildable with no money, key, account or SOL spend and build it when it is.

- Record a competition as blocked and tell the user once what is missing when it needs money, a key, an account or SOL.

- Never spend SOL, never buy credits or pay fees and never submit copied code.

- Start a fresh agent session at or after the competition opening because a session that began before it cannot be entered.

## Analyze the deciding metric before you submit

- Do NOT submit a first draft just to be early. The quota (reputation total, usually 2) is precious: a mediocre first submission wastes a slot a better version needs, and a better version built later cannot be submitted once the quota is exhausted.

- Before you build, identify the DECIDING metric: read the leaderboard rankKey, the scoring formula, and how ties are broken. Then study the live top entries to see what actually separates the winners from the rest. Optimize the entry for THAT metric, not just for passing the kit check or a generic good score.

- The chess lesson (2026-11-17): tiny-chess-01 v4 was submitted with max elo 2110 and a 6-0-0 record, ranking #39 of 7931 — but 377 entries were tied at elo 2110, so the ranking was decided by spare_plies (efficiency). v4 had 967 spare_plies; rank #20 needed 991. v5 (997 spare_plies) would have reached ~rank 15-17 and the $14 reward, but the quota was already spent on v4. Had the tiebreaker been analyzed BEFORE the first submit, v5 could have been the first entry.

- Before submitting, verify the entry is competitive on the deciding metric against the LIVE leaderboard (not just the kit's local practice score). If it is not in the reward zone on that metric, keep improving it instead of submitting — a submission that cannot win wastes a slot.

- **Target TOP 1-5, not top 1000.** The prize zone (top 50, with top 10 getting the biggest share) is the target; the top-1000 rewards pool is only a small bonus, never the goal. Framing top 1000 as the target and top 50 as the "stretch" is backwards. Study what the live top 1-5 entries do (download and view their actual images/artifacts when the API exposes them) and build to BEAT the #1 entry on the deciding metric, not just to enter the bonus pool. This target rule applies to ALL hunting, not just make.fun — encoded also in the hunting-toolkit skill and MEMORY.md (user rule, 2026-11-18).

## Check quota before you build

- Check the submission quota before you start building or improving an entry and record the result.

- Read the reputation total and the day cap from the quota result and treat the reputation total as the binding limit when it is lower than the API maximum.

- Do not start a build when the quota shows no submission slot remains for that competition.

- Plan at most two submissions for a competition when the reputation total is two, with the first submission early and the second only for a measurably better iteration.

- Re-check the quota at the competition opening when an earlier check returned no quota because the competition was not yet open.

## Build and grade the entry

- Build from the kit starter in a repository created at or after the competition opens and keep it public with an OSI-approved license.

- Make the GitHub owner the account login or add owner info holding a linked wallet at the submitted commit.

- Grade the entry locally with the kit grade-local command until it behaves as expected and run the replay check when the entry must stay deterministic.

- Keep every agent session whole, top-level and subagent sessions together, because the transcript gate matches the code against the sessions that wrote it.

- Never rewrite a session from memory and never put a secret or a provider key in the repository or in a transcript.

## Bundle transcripts and submit

- Run the bundle command from the unpacked kit directory and declare all five agent facts with flags for harness, harness version, provider, model and effort.

- Read the harness version from the kit kit.json harness_version field and never guess it.

- List every MCP server used with the mcp flag or pass mcp none when no MCP server was used.

- Pass a system-prompt file or a one-line withheld reason because entries received from 2026-11-17 are rejected without a run record.

- Redact personal details with the redact flag and never redact code, files the entry ships, commands, tool output or reasoning.

- Run the kit check command on the repository and the bundle and fix each failed check before you submit.

- Submit a GitHub repository entry with the submit command naming the competition, the repository URL, the commit and a title that names what the entry does.

- Enter as a source bundle when there is no GitHub repository by running init first in an empty repository and submitting with the source flag and a keypair.

- Keep the init anchor line quoted in the sessions so the thinking fresh check can credit the lines.

- Record the submission id and the claim code and keep the claim code private.

- Treat the latest submission with a receipt before the deadline as the final entry.

- Stop after one create_repository 403 and ask the user to create the repository manually or adjust the GitHub App installation instead of retrying it.

- Never ask the user for a GitHub token.

- Follow the entry with the status command and record its stage, its practice score and its deadlines.

## Submit one recording only

- Submit one recording only when you submit with a recording.

- Choose the recording that covers the most lines of the submitted commit.

- Do not name a second recording to cover the remaining lines because the site rejects recordings that share a document.

- Design a large first build so one recording covers most of the final code and keep later changes additive rather than rewriting whole modules.

- Keep the coverage of the chosen recording above the 30 percent transcript floor and check it before you submit.

## Available connectors

- Use connector search to find other connectors and skill search to find related skills.

- If nothing here fits, look on the web for a maintained API or MCP server and set it up with Custom Connectors and MCPs, or build a custom connector.

## Websites

- Use make.fun for open competitions, deadlines, prizes and entry status. Carry the competition slug into the browser and verify the deadline, the prize and the entry requirements there.

## Alternatives for better results

- Improve an existing entry before the deadline when a later submission replaces the earlier one and the practice score shows a real gain.

- Plan distribution before building a referral-scored entry because verified signups decide its result, not the build alone.

- Split a large build across sessions only when every session stays inside the competition window and each one is bundled with the entry.
