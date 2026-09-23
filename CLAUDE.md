# common_widgets_flutter

Private shared widget library (`publish_to: none`) consumed by
chargeplus_customer, chargeplus_partner, and chargeplus_customer_web via
git URL with NO ref pin — and all three consumers gitignore pubspec.lock.
Anything merged to `main` silently reaches every app on its next
`pub get`, with no lockfile diff for reviewers to catch.

## Blast-radius rules

- A breaking public-API change is allowed ONLY when the same piece of
  work updates every consumer app in lockstep — plan the consumer PRs
  before merging the library change.
- There is NO CI here (no analyze/test/format gate at all). Local
  `flutter analyze` + `flutter test` before every push is the only
  safety net.

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
  migrating off it; only 2 legacy widgets still use it.
- Release = pubspec version bump (`X.Y.Z+build`) as commit
  `build: vX.Y.Z` on a `release/X.Y.Z` branch, merged to main+develop,
  bare-semver tag.
- README's MIT badge is stale — there is no LICENSE file; don't
  propagate the claim.
