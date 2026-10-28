---
name: routine
description: "Run the four-pass pre-merge routine on a common_widgets_flutter branch or PR — /simplify, /code-review, the local gates, and a consumer-impact check across the apps — triaging every finding and committing each pass separately. Stops at the human review gate; never merges. Use for: the routine, run the routine, quality passes, pre-merge checks, has this done the routine."
---

# Pre-merge routine (library edition)

A trimmed port of chargeplus_customer's five-pass routine. The app-only
passes (`driver-critic`, `deep-review`, `verify-sim`) don't apply to a
widget library; the consumer-impact pass replaces them, because this repo's
real risk is what a merge does to the apps (CLAUDE.md, blast-radius rules).

CI checks format, analyze, tests and coverage, but nothing about the
consumers — run all four passes on every substantive PR (docs-only or
config-only PRs: pass 3 and pass 4 only).

## Order

**`/simplify` → `/code-review` → gates → consumer impact.**

The two passes that change code run first; the gates and the impact check
then judge the code that will actually merge. Never run passes in parallel.

## Preflight

```bash
git fetch origin develop --quiet
git diff origin/develop...HEAD --stat     # scope
git status --short                        # must be clean; never stash
flutter pub get                           # a fresh worktree needs it
```

## Triage rule

Every finding is **applied** or **skipped with a concrete, checkable
reason** — never "I disagree". Roughly a third of agent findings are wrong:
verify before applying, and prove the skip when you can (a throwaway test,
then delete it).

**Fix, don't just report.** Commit each pass separately (Conventional
Commits: `refactor(<widget>): …` for simplify, `fix`/`test(<widget>): …`
for code-review) and push it in the same pass. A pass is not finished while
its accepted findings sit uncommitted.

## Pass 3 — gates

```bash
dart format --line-length 80 --output=none --set-exit-if-changed lib test
flutter analyze lib test
very_good test --coverage --test-randomize-ordering-seed random
```

Then confirm the PR's CI (`gh pr checks <n>`) is green, including the
coverage floor and the markdown spell check (a new word goes in
`.github/cspell.json` `words`). Plus `dart run build_runner build -d` if a json_serializable model changed
(the regenerated `.g.dart` must be committed). All green, or the pass is ❌.
New or changed public widgets need dartdoc and a test under
`test/widgets/` (CLAUDE.md) — a missing one is a finding, fix it here.

## Pass 4 — consumer impact

1. List the public-API change: `git diff origin/develop...HEAD --
   lib/common_widgets_flutter.dart lib/src/` — removed/renamed exports,
   constructor params (removed, renamed, now required, changed default or
   type), changed visuals or behavior of an existing widget.
2. For every changed symbol, find its callers on each consumer's `develop`
   without touching their working trees (sibling checkouts):

   ```bash
   for c in chargeplus_customer chargeplus_partner chargeplus_customer_web; do
     git -C ../$c fetch -q origin develop
     git -C ../$c grep -n '<Symbol>' origin/develop -- '*.dart'
   done
   ```

   A missing sibling checkout → mark the pass ⚠️ partial and name it.
3. Verdict, one of:
   - **Additive** — no caller breaks. Say so with the grep evidence.
   - **Visual/behavior change** — list the call sites that will look or
     act differently on their next `pub get`.
   - **Breaking** — list every call site per app. Per CLAUDE.md this PR
     must not merge until the matching consumer PRs exist; link them, or
     mark the pass ❌ blocked with what is missing.

## Update the PR after every pass

Keep the routine's state in the PR body, in one marked block that a re-run
replaces:

```
<!-- routine:status -->
### Quality routine

| Pass | Status | Findings | Commit |
| --- | --- | --- | --- |
| /simplify | ✅ done | 4 → 2 applied, 2 skipped | `abc1234` |
| /code-review | ✅ done | 1 → applied | `def5678` |
| gates | ✅ green | format · analyze · test | — |
| consumer impact | ✅ additive | 0 call sites break (customer 12, partner 3, web 1) | — |

<what was skipped and why — one line each>
<!-- /routine:status -->
```

Read the body first (`gh pr view <n> --json body`), replace between the
markers if present, otherwise append; never clobber the rest. Write the body
to a scratchpad file and `gh pr edit <n> --body-file <file>`. Mark a pass ⚠️
partial or ❌ blocked with its reason — a table of green ticks where one pass
proved nothing is worse than no routine.

## Report

Per pass: findings, applied, skipped **and why**; the gate results; the
consumer-impact verdict with call-site counts; the PR URL. **Never merge —
stop at the human review gate**, even if asked to "finish it".
