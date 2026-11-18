# BugHunter Methodology

Distilled from `elementalsouls/Claude-BugHunter` (83 skills, patterns from 681
disclosed HackerOne reports). Full source, read-only clone:
`~/bugbounty/claude-bughunter/` — read the matching `skills/hunt-*/SKILL.md`
there when a hunt targets that vuln class. Blitzstrike methodology lives at
`~/bugbounty/blitzstrike/` (BLITZ → EAGLE-EYE → STRIKE, hypothesis → live
verify with negative control).

**This skill is one layer of the unified Hunting Toolkit.** For the full
picture — contract depth (Pashov), verification (Blitzstrike), PoC
engineering (mattpocock), research (last30days), QA (NVIDIA) — load
`~/workspace/custom-skills/hunting-toolkit/SKILL.md` (the master
orchestrator) instead. Hub index: `~/workspace/github-repos/TOOLKIT.md`.

## Mindset

Hunting is not "find a bug" — it is "prove an attack scenario." Think like an
attacker with a specific goal, not a scanner looking for patterns.

Before touching any tool, each session:
1. **Define**: "Today I target [feature/domain] to achieve [CIA impact]"
2. **Select**: Choose 1-2 vuln classes (IDOR, race condition, etc.)
3. **Execute**: Focus ONLY on selected techniques. No wandering.

Pick one goal per session: Confidentiality, Integrity, Availability,
Account Takeover, or RCE.

Anti-patterns: program hopping (stick with one target min 2 weeks / 30 hours),
tool-only hunting (automation finds duplicates; manual testing finds unique
bugs), rabbit hole (max 45 min per parameter), no goal ("just looking around"
= wasted time).

## Mode confirmation (PART 0 — before anything else)

Confirm the engagement type first. The same target produces a different
report shape depending on the mode. Getting this wrong is the single biggest
waste of time.

| Engagement type | What counts as a finding | What gets rejected |
|---|---|---|
| **Bug bounty** (H1 / Bugcrowd / Intigriti / Immunefi / private VDP) | Impact-demonstrated bugs ONLY. Full chain to attacker-attainable harm. | Hygiene (EoL software alone, permissive CSP alone, stack traces, info disclosure without concrete impact, "best practice" violations) |
| **Red team** (external client engagement) | Hygiene + recon + IoCs + defensive-state observations are ALL deliverables | Nothing — even "no finding here" is reportable |
| **Pentest** (signed SoW / WAPT) | Depends on SoW. Usually accepts hygiene + impact + recon | Out-of-scope assets, unsigned testing |
| **Internal audit** | Compliance-mapped findings (PCI / ISO / NIST) | Findings without a control-mapping |

Write the engagement type as the first line in hunt notes. If it cannot be
answered from the user's instruction, ASK once. Don't assume.

## The 5-phase non-linear workflow

```
Recon → Map → Find → Prove → Report
```
NOT linear. Move freely between phases. Stuck at any phase → go back.
New API found at phase 3 → return to phase 2. WAF blocks at phase 4 →
origin IP from phase 1.

- **Phase 1 RECON**: Maximize attack surface. Subdomain enum → DNS →
  HTTP probing → port scan → tech detect. Google Dorks, JS download, hidden
  param discovery, API mapping. 5-minute rule: nothing after 5 min on a
  host → skip, try next host.
- **Phase 2 MAPPING**: Understand the app like its developer does. Map all
  endpoints, identify auth model, find business-critical flows (payment,
  registration, password reset, data export), download and analyze JS for
  hidden routes/secrets/logic, identify roles and permissions, note "weird"
  behaviors (naming anomalies, error diffs, timing).
- **Phase 3 FIND**: Find the bug. Error-based first, then blind-based.
  Try error-based (`'`, `"`, `{{7*7}}`) → time-based (`SLEEP(10)`) →
  OOB (interactsh) → boolean (`AND 1=1` vs `AND 1=0`). 20-minute rule:
  nothing after 20 min on an endpoint → rotate.
- **Phase 4 PROVE & ESCALATE**: Prove maximum business impact. Turn Low
  into Critical. XSS → steal cookie/token → ATO. IDOR → read PII / change
  password → ATO. SSRF → cloud metadata → keys → RCE. Low-impact alone →
  find a connector gadget and chain it. After proving: can it work with
  0-1 clicks? Does it affect all users or a specific role? What's the
  business $ impact?
- **Phase 5 VALIDATE & REPORT**: Run the 7-Question Gate (below). All 7
  pass → write report. Any fail → KILL the finding. Borderline → triage
  for a quick go/no-go.

Phase priority shifts by target type: SaaS bug-bounty = 10% recon / 70%
hunt / 20% validate+report. External red-team = 40% / 30% / 30%. WAPT =
0% / 60% / 40%.

If a Critical is found in the first 30 minutes of recon: STOP reconning,
validate the Critical fully, report it, then return to recon. If a
candidate won't reproduce on a second account after 4+ hours: it's dead.
Drop it, document the retraction, move on.

## The 7-Question Gate (before writing ANY report)

Ask IN ORDER. One wrong answer = STOP this finding. Kill it. Move on to
the next test class. (Killing a finding does NOT stop the engagement —
every other test class is still pending.)

- **Q1: Can an attacker use this RIGHT NOW, step by step?** Complete the
  template: Setup (what account/access) → Request (exact HTTP method, URL,
  headers, body — copy-paste ready) → Result (what data is read/modified/
  deleted) → Impact (ATO / PII read / money stolen) → Cost (time, $).
  If step 2 cannot be written as a real HTTP request → KILL IT.
- **Q2: Is the impact on the program's accepted impact list?** Check the
  program page "Vulnerability Types" / "Out of Scope." If the bug maps to
  a listed exclusion → KILL IT.
- **Q3: Is the root cause in an in-scope asset?** Vulnerable domain on the
  in-scope list, production asset (not staging/dev unless explicitly in
  scope), not a third-party service the company just uses. Out of scope →
  KILL IT.
- **Q4: Does it require privileged access an attacker can't realistically
  get?** "Admin can do X" = centralization risk = KILL IT (99% of
  programs). "Non-admin can do X that only admin should do" = valid.
- **Q5: Is this already known or accepted behavior?** Search the program's
  disclosed reports, GitHub issues, changelog, API docs. If
  acknowledged/design decision → KILL IT.
- **Q6: Can it be reproduced on a second account / second tool?** For
  Critical/High: reproduce via at least TWO independent tools (curl +
  Python requests, Burp + raw socket). Cross-tool consistency rules out
  tool artefacts. Reproduction commands must be paste-into-shell ready
  in the report.
- **Q7: Is the severity honest?** CVSS 3.1 score must MATCH actual impact,
  not the theoretical maximum. Title: `[Bug Class] in [Endpoint] allows
  [role] to [impact]`. Impact-first summary (sentence 1 = what attacker
  CAN do). Under 600 words. Exact HTTP requests in Steps to Reproduce.

After submission: while waiting for triage, try to escalate further. If a
fix is deployed, re-test for bypass (incomplete patch = new bug).

## Discipline rules (false-positive prevention — non-negotiable)

These are quality gates, not throttles. They tell you which signals are
real findings and which aren't. They do NOT tell you to send fewer probes.

- **Marker Discipline**: When testing reflection, cache poisoning, param
  pollution, or OOB SSRF, the marker MUST be unique and unmistakable:
  random alphanumeric, 8+ chars, no English words, no protocol keywords.
  NEVER use `test`, `marker`, `evil`, `attacker`, `payload`, `javascript`,
  `script`, `AAAA`, `BBBB`, or your domain. Good: `cpmark987abc`,
  `x4hd2k9pq`. Before claiming reflection, search the BASELINE (no-marker)
  response for the marker — if it appears naturally, change the marker.
- **Body-Diff Rule**: A bypass claim requires response BODY differential,
  not just status code. 200 OK with byte-identical body to baseline is NOT
  a bypass. Always diff the body side-by-side before claiming bypass.
  Status-code-only claims are the most common rejected-as-N/A category.
- **Statistical-Sample Rule** (timing claims): Single outliers are NOT
  signal — network jitter routinely produces 2x outliers. Minimum n ≥ 10
  INTERLEAVED trials per group (control + test, randomised order). A signal
  requires the suspect group's mean ≥ 2σ above the control mean.
- **Shell-Loop Ban (>5 iterations)**: Any iteration running more than 5
  times → use Python with try/except per iteration, not shell for-loops.
  Shell loops can silently produce zero iterations. Always count results:
  expected 100 probes but got <50 lines → the loop ate something.

## When the user says "find more" (pushback protocol)

Default assumption: they are correct. You stopped early. Before pushing
back:
1. Re-read 3 more `hunt-*` skills beyond what you loaded, matching the
   observed surface.
2. Re-attack the same surface with the new skill checklists, walking every
   step even if it feels redundant.
3. Document negatives as you go — a confirmed "no bug here" is itself a
   finding (it proves coverage).
4. Only after exhausting 3 new skills' checklists do you push back, and
   only with a concrete list of what was tested.

## Hunt skills index (in ~/bugbounty/claude-bughunter/skills/)

58 `hunt-*` skills, one per vuln class. Read the matching one before
testing that class:
hunt-idor, hunt-sqli, hunt-nosqli, hunt-xss, hunt-ssrf, hunt-ssti,
hunt-xxe, hunt-auth-bypass, hunt-jwt-crypto, hunt-oauth, hunt-saml,
hunt-session, hunt-mfa-bypass, hunt-ato, hunt-race-condition,
hunt-business-logic, hunt-file-upload, hunt-deserialization,
hunt-graphql, hunt-grpc, hunt-websocket, hunt-cors, hunt-csrf,
hunt-cache-poison, hunt-http-smuggling, hunt-host-header,
hunt-open-redirect, hunt-clickjacking, hunt-brute-force,
hunt-forgot-password, hunt-llm-ai, hunt-rag-vector, hunt-rce,
hunt-lfi, hunt-dom, hunt-api-misconfig, hunt-cloud-misconfig,
hunt-k8s, hunt-cicd, hunt-ldap, hunt-aspnet, hunt-laravel,
hunt-nextjs, hunt-nodejs, hunt-springboot, hunt-sharepoint,
hunt-fintech-graphql, hunt-subdomain, hunt-source-leak,
hunt-shadow-api, hunt-spa-api, hunt-tls-network, hunt-html-injection,
hunt-exceptional-conditions, hunt-captcha-bypass, hunt-ntlm-info,
hunt-misc, hunt-dispatch, hunt-ato.

Supporting skills: `bb-local-toolkit` (tool routing by phase),
`evidence-hygiene` (redact cookies/PII before screenshots),
`report-writing` (platform-specific formats), `recon-scope-triage`,
`cloud-iam-deep`, `enterprise-vpn-attack`, `redteam-mindset`.

## Scope and authorization

Only hunt in-scope, authorized targets: a published bug bounty program's
scope, a signed engagement, or the user's own systems. Testing outside a
program's published scope or without a signed engagement is out of bounds.
The user approves each active test first. Read-only recon only until then.
