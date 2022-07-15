/// {@template ticker}
/// A ticker that displays ticks every second
/// {@endtemplate}
class Ticker {
  /// {@macro ticker}
  const Ticker();

  /// Countdown timer
  /// Eg. Countdown for 5 seconds
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }

  /// Stopwatch
  /// Eg. Has been charging for 3 minutes
  Stream<Duration> elapsedFrom(DateTime startFrom) {
    return Stream.periodic(const Duration(seconds: 1), (_) {
      return DateTime.now().difference(startFrom);
    });
  }
}
