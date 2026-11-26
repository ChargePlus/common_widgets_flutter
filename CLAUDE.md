# common_widgets_flutter

Unpublished shared widget library (`publish_to: none`) consumed by
chargeplus_customer, chargeplus_partner, and chargeplus_customer_web via
git URL with NO ref pin — and all three consumers gitignore pubspec.lock.
Anything merged to `main` silently reaches every app on its next
`pub get`, with no lockfile diff for reviewers to catch.

## Process: pstack

pstack is the process here (`.claude/settings.json` enables the plugin at
project scope). Start non-trivial work with `/pstack:poteto-mode` and read
`.claude/extensions/pstack.md` first: it lists the hard stops and the
add-on gates. The review gates are in `.claude/extensions/review/gates.md`;
they stop at Ezra's review and never merge. Codex, where it is available,
is a pstack subagent (`.claude/agents/codex.md`). `AGENTS.md` points Codex
back at this file — keep repo guidance here.

This repository is public on GitHub: never commit keys, tokens, internal
hostnames or customer data, in code, examples or screenshots.

## Blast-radius rules

- A breaking public-API change is allowed ONLY when the same piece of
  work updates every consumer app in lockstep — plan the consumer PRs
  before merging the library change.
- CI (`ci` workflow, VeryGood `flutter_package`) runs on PRs and pushes
  to main/develop: format, analyze, `very_good test` with
  `min_coverage: 20`, semantic PR titles, and a spell check over ALL
  markdown — a typo in any `.md` fails the build. Run
  `dart format --line-length 80 --set-exit-if-changed lib test`,
  `flutter analyze lib test` and `flutter test` locally before pushing.

## Conventions

- One widget per file: `lib/src/<snake_case>.dart`, exported from the
  single barrel `lib/common_widgets_flutter.dart`; models under
  `lib/src/models/` with their own sub-barrel.
- Dense dartdoc is the bar: class doc with a usage example plus every
  constructor parameter documented (see `bullet_point_text.dart`).
- Tests: `test/widgets/<name>_test.dart` mirroring the source file. Wrap
  in MaterialApp/Scaffold; prefer text/key finders over counting
  internal animated wrappers; dialog/search widgets get an open+close
  smoke test first. Coverage is thin (6 of 20 widgets) — new widgets
  don't ship untested.
- Don't deepen the `flutter_adaptive_scaffold` dependency
  (`Breakpoint.activeBreakpointOf`) — consumer apps are actively
  migrating off it; only `BulletPointText` still uses it.
- Release = pubspec version bump (`X.Y.Z+build`) as commit
  `build: vX.Y.Z` on a `release/X.Y.Z` branch, merged to main+develop,
  bare-semver tag. Cut it with the `cut-release` skill.
- README's MIT badge is stale — there is no LICENSE file; don't
  propagate the claim.
