# Review gates

pstack is the process (`.claude/extensions/pstack.md`). These are the gates
it runs on top before a PR goes to Ezra. A gate never replaces a pstack
step.

This library's users are the apps (chargeplus_customer, chargeplus_partner,
chargeplus_customer_web) and the packages under their `packages/`, which
pull it by unpinned git URL with gitignored lock files. A widget change
lands on every screen that renders it, on each app's next `pub get`, with
no lockfile diff for anyone to notice. So the gates ask three questions of
every diff: is the code right, what does every consumer screen look like
now, and what breaks in the consumers. CI answers what a machine answers
the same way every time; these gates keep the judgement.

## The gates

| Gate | Runs when | How |
| --- | --- | --- |
| CI | every PR | `gh pr checks <n>` green on the head: `build` (format, analyze, tests, coverage floor 20%), `semantic_pull_request` (the title) and `spell-check` (every `.md`, `.claude/` included: a new word goes in `.github/cspell.json`). |
| Tests | any change under `lib/` or `test/` | see [Tests](#tests) |
| Cleanup | any change under `lib/` or `test/` | `/pstack:no-comments`; the built-in `/simplify` too when the diff changes over ~100 lines under `lib/` |
| Code review | any change under `lib/`, `test/`, `pubspec.yaml`, `analysis_options.yaml` or `.github/` | the built-in `/code-review` (it also checks CLAUDE.md rules), plus the [repo traps](#repo-traps) |
| Adversarial review | any change under `lib/` | `/pstack:interrogate`, Codex as its non-Claude seat. Each adversary gets the [lenses](#edge-case-lenses) and the repo traps as its starting brief. See [Adversarial review](#adversarial-review). |
| API compatibility | any change under `lib/` or to `pubspec.yaml` | classify the diff as **Additive**, **Visual**, **Behavior** or **Breaking** and name the bump: see [API compatibility](#api-compatibility) |
| Consumer impact | the classification is Visual, Behavior or Breaking, or the diff changes any exported symbol | see [Consumer impact](#consumer-impact) |
| Visual check | the diff changes how any widget renders: a `build` method, a style, a theme read, a size, padding, an animation, or a dependency that draws (`material_ui`, `flutter_animate`) | before and after images across the matrix: see [Visual check](#visual-check) |
| Theming and accessibility | a new widget, or a change to its text, colors, icons or anything tappable | see [Theming and accessibility](#theming-and-accessibility) |
| Fuzz | the diff changes a model under `lib/src/models/` or its `fromJson`/`toJson` | a seeded test that decodes random JSON shaped like the model (missing keys, `null`, wrong types, extra keys) and round-trips valid ones: it throws only the errors the model's dartdoc names, and `fromJson(toJson(x)) == x` |
| Security | the diff touches `.github/workflows/` or adds a dependency | the built-in `/security-review`: actions pinned to a full SHA, `permissions:` no wider than the job needs, and a new dependency maintained and needed |
| Public-API docs | the diff adds or changes an exported symbol, or changes what one does | the CLAUDE.md bar: a class doc with a usage example, every constructor parameter documented, and the doc says what the widget does now (where its style comes from, what it does on tap, what it shows when empty). CI's `public_member_api_docs` lint only proves a doc exists. |
| Public repo | every PR | read the diff, the commit messages, the PR body and its images for anything that must not be public: see [Public repo](#public-repo) |
| Agent instructions | the diff touches `CLAUDE.md`, `AGENTS.md`, `.claude/` or `.codex/` | a fresh agent reads every rule the diff adds or changes against `CLAUDE.md`, `.claude/extensions/pstack.md`, this file and every file the rule names (the skill, agent, hook or script it edits or points to), and quotes each conflict: two rules that disagree, a rule a later line undoes, a step that names a tool or path that does not exist, or anything that weakens a hard stop. Fix each one before the PR goes to Ezra. |
| Independent verdict | every PR except prose-only | pstack Shipping step 1, with a scratch consumer standing in for the app: see [Independent verdict](#independent-verdict) |

Prose-only changes (`*.md` outside `.claude/`) run CI and Public repo only.

**Order:** cleanup → code review → interrogate → API compatibility →
consumer impact → visual check → theming and accessibility → fuzz →
security → public-API docs → public repo → agent instructions →
independent verdict. CI and Tests run on every head you push: fix them
before the verdict. Run the gates in sequence so each sees the fixes from
the ones before it. A fix that moves HEAD re-runs the gates it affects.

## Triage rule

Every finding is **applied** or **skipped with a concrete, checkable
reason**. Never "I disagree". Roughly a third of agent findings are wrong:
verify before applying, and prove the skip when you can (a throwaway test,
then delete it).

**Fix them, do not just report them.** Commit each gate's fixes
separately in Conventional Commits (`refactor(<widget>): …` for cleanup,
`test(<widget>): …` or `fix(<widget>): …` for review, visual and
accessibility findings) and push them in the same pass. A gate is not
finished while its accepted findings sit uncommitted. A gate that finds
nothing says so; no empty commit.

Escalate instead of deciding alone when a fix would change intended
behavior or look, reach well outside the diff, or need a design call.
Report it as a finding you deliberately did not take, with the reason.

## Tests

Run `very_good test --coverage --test-randomize-ordering-seed random` on
every head you push and diff the failing **name set** against
`origin/develop`, never the count. Identical sets mean no regression. A new
or changed public widget ships with a test under `test/widgets/` (CLAUDE.md).

For a bug fix, RED then GREEN must be on **the test that ships**, not a
scratch probe: copy the fixed `lib/` files to the scratchpad, put the merge
base's version in place (`git show $(git merge-base origin/develop HEAD):<path>`;
swap every `lib/` file in the diff together, or the test fails to compile
instead of failing on the defect), confirm the test fails, restore,
confirm it passes. Quote the failure message. Never stash.

A test of how a widget looks asserts the rendered result, not one of its
inputs: read the `RichText` style, the painted size or the color that
lands (the `NotAvailableText` test in #53 is the pattern), with
asymmetric, distinct fixture values so a swap shows.

## Adversarial review

Codex takes interrogate's non-Claude seat as the `codex` subagent with
`Mode: ask` (`.claude/agents/codex.md`). Put every adversary's findings
through interrogate's Verify step: a finding a run proves is confirmed, one
a run disproves is dropped with the output, and one that cannot be run here
is recorded as **verification-blocked** and triaged, never counted as
clean.

**When pstack is not installed in the checkout** (the SessionStart hook
says so), ask Ezra to install it or trust the folder. Until it loads, do
not skip the gate: run the panel by hand, one fresh subagent per entry of
the `interrogate reviewers` line in `.claude/rules/pstack-models.md`, all
in one message, each with the diff, the lenses, the repo traps and the
instruction to break the change and prove each finding with a run. The
Codex seat's brief skips the worker.md pair; a `CODEX UNAVAILABLE` reply
drops the seat with a note. Write "interrogate (panel run by hand: pstack
not installed)" in the Review gates block. `/pstack:no-comments` has no
hand-run form: mark it ❌ blocked with the reason.

### Edge-case lenses

Keep only the rows the diff reaches, and add the ones no lens names.

- **Content:** empty, one item, very many, a very long word or line, a
  `null` optional, a child widget instead of text where the API takes one.
- **Layout:** a narrow phone (320 wide), a wide web layout, unbounded
  constraints (inside a `Row`, a `Column`, a `ListView` or a sliver), and
  2.0× text scale.
- **Theme:** light and dark, a consumer theme with its own font family,
  sizes and `colorScheme`, and a parent `DefaultTextStyle`.
- **Interaction:** tap, double tap, tap while an animation runs, keyboard
  and focus on the web, a dialog dismissed by the barrier or the back
  button.
- **Lifecycle:** a widget rebuilt with new parameters, removed mid
  animation or timer, and controllers and listeners disposed.
- **Host:** with and without `go_router` above it, inside a `Scaffold` and
  not, on the web (chargeplus_customer_web consumes this library).

## API compatibility

List every change to what a consumer can see, then classify the PR by the
most severe one:

- **Additive** (minor bump): a new exported widget or model, or a new
  optional parameter whose default keeps today's look and behavior.
- **Visual** (minor bump): no signature breaks and nothing behaves
  differently, but an existing widget renders differently: size, padding,
  color, font, elevation, animation.
- **Behavior** (minor at least; Ezra decides): an existing widget acts
  differently: what a tap does, what a dialog returns, navigation, focus,
  what it shows when empty, a callback's timing.
- **Breaking** (major bump): an export removed or renamed, a parameter
  removed, renamed, made required or retyped, a changed default, a public
  type that now comes from another package (the `material_ui` move in #52
  was one), a raised `sdk` or `flutter` floor, or a dependency range that
  drops a version a consumer resolves today.
- **Internal** (patch): none of the above (tests, docs, a private
  refactor proven to render and behave the same).

Diff the exported surface: `git diff origin/develop...HEAD --
lib/common_widgets_flutter.dart lib/src/ pubspec.yaml`. Behavior and
Breaking are hard stops for Ezra (`pstack.md`, hard stop 1). A Breaking
change ships as add-new, migrate-callers, delete-old across releases
(`/pstack:principle-migrate-callers-then-delete-legacy-apis`) unless Ezra
says otherwise.

## Consumer impact

1. Find the callers of every changed symbol on each consumer's `develop`,
   without touching their working trees. `git grep` covers their
   `packages/`:

   ```bash
   for c in chargeplus_customer chargeplus_partner chargeplus_customer_web; do
     git -C ../$c fetch -q origin develop
     git -C ../$c grep -n '<Symbol>' origin/develop -- '*.dart'
   done
   ```

   For a Visual change, the list of screens that render the widget is the
   output: it says where the new look lands. Stay out of every key file
   while you search. A missing sibling checkout marks the gate ⚠️
   partial, naming it.
2. Run `/pstack:blast-radius` on the one or two facts the change's safety
   rests on, and take each as far down its "how sure are you" ladder as is
   cheap.
3. **Behavior or Breaking:** prove it against a real consumer. In a
   throwaway detached worktree of each affected consumer at
   `origin/develop` (`git -C ../<c> worktree add --detach <scratch> origin/develop`),
   point the affected package at this checkout with an uncommitted
   `pubspec_overrides.yaml` (`dependency_overrides:
   common_widgets_flutter: {path: <this worktree>}`), run `flutter pub
   get`, `flutter analyze` and the tests of the packages that use the
   changed symbols, then remove the worktree. Never commit in a consumer,
   and never run anything there that needs its API keys.
4. Verdict: **Additive** with the grep evidence, or the call sites per app
   that break, look different or behave differently, with the consumer PRs
   linked or the gate ❌ blocked naming what is missing.

## Visual check

A scratch widget test (in the scratchpad, never committed) pumps each
changed widget in a `MaterialApp` and writes images with
`matchesGoldenFile` under `--update-goldens`, once on the merge base and
once on the head, across the matrix the diff reaches: light and dark, text
scale 1.0 and 2.0, 320 and 1024 wide, and each state the widget has
(enabled, disabled, loading, empty, long text). Load a real font with
`FontLoader` so text is readable rather than boxes. A fresh agent compares
the pairs against the PR's stated intent: an intended change is shown in
the PR as before and after; an unintended difference, an overflow stripe
or a clipped text is a finding.

Goldens are not committed yet: CI renders on Linux and a macOS baseline
would not match. Until the repo has a golden harness, the shipping test
asserts the rendered property instead (see [Tests](#tests)).

## Theming and accessibility

- **Theme:** colors come from `Theme.of(context).colorScheme`, text from
  `textTheme` merged onto the ambient `DefaultTextStyle`, never a
  hard-coded color, font family or size unless it is a parameter. Pump
  it under a consumer-like theme (its own font and colors) and check the
  widget follows it.
- **Copy:** user-facing text is a parameter the app passes already
  translated. A new English literal is a finding; an English default on an
  optional parameter follows the existing ones (`DiscardChangesDialog`,
  `ExpandableSearch`) only when Ezra agrees.
- **Accessibility:** a widget test asserts
  `meetsGuideline(androidTapTargetGuideline)`,
  `meetsGuideline(iOSTapTargetGuideline)`,
  `meetsGuideline(labeledTapTargetGuideline)` and
  `meetsGuideline(textContrastGuideline)` for anything tappable or any
  text the change adds or recolors, seen failing once against a minimal
  mutation. No overflow at 2.0× text scale.

## Public repo

This repository is public on GitHub. The diff, the commit messages, the PR
body and its screenshots carry no:

- key, token, password, dart-define value or `.env` content;
- hostname, URL or endpoint path of a ChargePlus service;
- customer data: names, emails, phone numbers, plates, card details or
  IDs, in a fixture, an example or a screenshot taken from an app;
- private ticket text or internal incident details.

A hit is fixed before the push. One already pushed goes to Ezra at once:
the history needs a rewrite he must approve.

## Independent verdict

pstack Shipping step 1: a fresh agent that did not write the code runs the
change the way a consuming app would, parent against head, and posts `PASS`,
`PASS+NOTES` or `FAIL` on the PR with the full head SHA.

There is no app here, so the agent builds a scratch consumer in the
scratchpad (never committed): a widget test that depends on this checkout
by path and pumps the changed widget the way the apps use it (inside a
`MaterialApp` with a consumer-like theme, the parent widgets the call
sites from Consumer impact use, a `GoRouter` where they have one), then
drives it: taps, text entry, dialogs opened and closed, rebuilt with new
parameters. It runs the same test against the merge base and the head and
quotes the difference, with the visual check's images for anything that
renders. Before building, it asks whether this harness can tell fixed from
broken. When it cannot (a behavior that only shows on a device, in a
browser, or inside one app's screen), it posts `PASS+NOTES (partial:
<reason>)`, never a plain `PASS`.

### Re-verdicts

A verdict covers one head SHA:

- **Same patch** (a rebase, or a merge-forward whose changed lines match):
  `git diff $(git merge-base origin/develop <sha>) <sha> | git patch-id --stable`
  prints the same ID for both heads. Post a re-check comment with both SHAs
  and the ID.
- **Fix commit:** after the gates the fix affects, a fresh agent checks
  only `git diff <verified head> <new head>` the way the full verdict ran,
  and posts a delta verdict that links the full one.
- **Anything else:** rerun the verdict.

## Repo traps

Interrogate adversaries and `/code-review` check the diff against these.
Each one has shipped or nearly shipped here. A trap that can become a
lint, test or CI check should become one (`/pstack:correct`), then leave
this list.

- **Replacing the ambient text style.** `NotAvailableText` set a
  `DefaultTextStyle` that held only a color, so its label lost the theme
  font and size (#53). Merge onto `DefaultTextStyle.of(context).style`
  with a `textTheme` fallback; never replace it.
- **SDK Material.** Since Flutter 3.50 every import is
  `package:material_ui/material_ui.dart`, not `package:flutter/material.dart`
  (#52). Mixing the two puts two `ThemeData` types in a consumer's tree.
- **Floors and ranges.** Raising the `flutter` floor to 3.50.0 was a
  Breaking change that needed a consumer PR in lockstep (#52). Dependency
  ranges span the majors the apps use (`equatable` 2 and 3, `go_router` 17
  and 18); narrowing one breaks a consumer's resolve.
- **`flutter_adaptive_scaffold`.** Do not deepen it: the apps are moving
  off it, and only `BulletPointText` still reads its breakpoints
  (`ChargeQuotaBarChart` reads the `breakpoint` package).
- **Navigation inside a widget.** `DiscardChangesDialog` calls
  `context.pop`, which needs a `GoRouter` above it. A new widget takes a
  callback or returns a value instead of navigating.
- **Barrel exports.** A widget not exported from
  `lib/common_widgets_flutter.dart` (and a model not exported from
  `lib/src/models/models.dart`) is invisible to every consumer.
- **Generated code.** A changed model needs `dart run build_runner build
  -d` and the regenerated `.g.dart` committed.
- **Controllers and streams.** `DateTimePicker`, `DateRangePicker` and
  `ExpandableSearch` each create a `TextEditingController` that nothing
  disposes yet: a change to one of them adds the `dispose`. `ExpandableSearch`
  calls `setState` after `showSearch` returns; a new `setState` after an
  `await` checks `mounted` first. `Ticker.elapsedFrom` never ends, so its
  caller cancels it.
- **Finding animated widgets in tests.** Prefer text and key finders over
  counting internal animated wrappers; open and close a dialog or search
  widget in a smoke test first (CLAUDE.md).

## The Review gates block

Every PR body ends with this block. Read the body first
(`gh pr view <n> --json body`), replace between the markers if present,
never clobber the sections above it, and write it with
`gh pr edit <n> --body-file <file>`.

```
<!-- review-gates -->
### Review gates

API change: Additive | Visual | Behavior | Breaking | Internal → patch | minor | major

| Gate | Result | Evidence |
| --- | --- | --- |
| <gate> | ✅ / ⚠️ partial / ❌ blocked / n/a | <commit, test name, link or reason> |

Verdict: PASS | PASS+NOTES | FAIL on <full head SHA>: <comment link>
<what was skipped and why, one line each>
<!-- /review-gates -->
```

Mark a gate ⚠️ partial or ❌ blocked with its reason whenever it could not
do its job. A green result needs evidence. If the PR title no longer
covers what the branch does, retitle it.

## Report

Per gate: findings, what was applied, what was skipped and why. Then the
API classification, the consumer-impact verdict with call-site counts, the
visual check's images, CI and test results, the RED then GREEN failure
message, the independent verdict, and the PR URL. **Never merge.** Stop at
Ezra's review, even if asked to "finish it".

## Rejected gates

- **Design laws and mockups:** the apps own them and run them on the
  screens that use these widgets; this repo has neither.
- **User critics (personas):** no screen of its own to walk. The apps'
  critics see the widget in context; Consumer impact lists where.
- **i18n as its own gate:** the library ships no translations. The Copy
  rule under Theming and accessibility keeps new text a parameter.
- **Firebase cost, saved state, formal verification, release build:** no
  Firebase, no persisted state, no state machine, no app build.
- **Committed golden tests:** CI's Linux renderer and a macOS baseline
  differ, so a committed golden would fail or be skipped. The visual check
  runs goldens in scratch until the repo has a harness for them.
- **Perf as its own gate:** no benchmark harness. Leaks and rebuild cost
  sit in the repo traps and the Lifecycle lens.
