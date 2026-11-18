# Immunefi Bounty Review

## Verify the program live before you recommend it

- Open the Immunefi program page in `browser.browse` before you name a program as a candidate and confirm the page loads and lists the program as live.

- Search Immunefi for the exact program name and record zero results as no live program instead of treating a triage list entry as proof.

- Never recommend a program from a morning triage list or a cached list without rechecking its live page in the same session.

- Tell the user plainly when a program has no live page and name the check you ran instead of moving on to a review.

- Wait for the user to pick a verified program before you start a review.

## Confirm scope, repo and payout terms before you review

- Read the live program page and record the maximum payout, the severity tiers, whether KYC is required and whether a proof of concept is required for every severity.

- Read the scope section and record the in scope assets, the out of scope items and any conditional payout rule such as a risk ratio or a split payment.

- Identify the core repository from the scope and the program page and record its owner, name, commit or tag and file count before you read code.

- Check that the repository you plan to review matches the scope and correct the repository name at once when you find a governance or staking repository instead of the core contracts.

- Ask the user to confirm any submission gate you find, such as a login, a Discord connection, an identity check or a paid submit slot, before you promise a submission date.

## Triage with Slither and prove with Foundry

- Run Slither over the scoped repository and triage every finding as a real candidate, a false positive or intended behaviour with a reason for each decision.

- Rank the surviving candidates by funds at risk and by how cleanly they fit the scope and work the strongest candidate first.

- Build a Foundry proof of concept for each surviving candidate and run it until it passes or fails cleanly.

- Treat a candidate as proven only when the proof shows theft, loss or a permanent lock and treat a break even or self harm only result as a negative.

- Record acknowledged findings from earlier audits and do not re-report them.

## Close out cleanly and record the result

- Write a report that names the program, the repository commit, the Slither result, each candidate, each proof result and the submit or do not submit decision.

- Save the report and the proof files under a review folder in the workspace and record their paths in your answer.

- Close a clean negative with do not submit and name the strongest candidate and why its proof failed to steal or lock funds.

- Tell the user when a fresh scan is needed for the next target and do not reuse a closed program list without a new live check.

## Available connectors

- Use `muse.connector_search` to find other connectors and `muse.skill_search` to find related skills.

- If nothing here fits, look on the web for a maintained API or MCP server and set it up with [Custom Connectors and MCPs](/opt/muse/skills/custom-connector-setup/SKILL.md), or build a custom connector.

## Websites

- [Immunefi](https://immunefi.com/) for live program pages, payout tiers, KYC rules, proof requirements and scope. Carry the exact program slug into `browser.browse` and verify the program is live, the maximum payout, the scope assets and the repository link there.

## Alternatives for better results

- Run a fresh Immunefi scan for the next target after every program closes instead of reusing an old candidate list.

- Pick the cleanest in scope finding first when several findings are proven because a clean finding submits sooner than a larger finding with scope caveats.

- Keep the proof small and focused on one candidate at a time so a failed proof clearly closes that candidate.
