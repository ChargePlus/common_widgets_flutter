# Common Widgets Flutter

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Common Widget Flutter is a repository that manages common widgets like PageTitle, DateTimePicker

## Testing

This package includes a growing test suite for widgets and models.

### Run all tests

```
flutter test
```

### Adding new widget tests

1. Create a file under `test/widgets/` (mirrors `lib/src/`).
2. Wrap the widget with `MaterialApp` / `Scaffold` as needed.
3. Prefer simple, resilient expectations (e.g. find text / keys) instead of
	relying on internal animated wrapper counts.
4. For interactive widgets that use `showDialog`, `showSearch` etc., start with
	a smoke test (open + close) to ensure stability before asserting fine-grained
	behavior.

### Model tests

Serialization models (e.g. `ExpandableSearchItem`) should have tests under
`test/models/` validating `toJson` / `fromJson`, equality, and convenience
getters.

### Guidelines

* Keep tests fast; avoid pumping long animations unless necessary.
* Use keys sparingly for elements you need to assert repeatedly.
* When adding dependencies for testing (e.g. mocking), declare them under
  `dev_dependencies` in `pubspec.yaml`.

### Future improvements

* Add Golden tests for visual regression of core widgets.
* Add coverage reporting integration.

## Usage
To use this plugin, add `common_widgets_flutter` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
