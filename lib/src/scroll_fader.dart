import 'package:flutter/material.dart';

/// {@template scroll_fader}
/// Scroll Fader for a ListView
/// {@endtemplate}
class ScrollFader extends StatefulWidget {
  /// {@macro scroll_fader}
  const ScrollFader({
    required this.child,
    super.key,
    this.scrollDirection = Axis.horizontal,
  });

  /// This property is used to configure an [ScrollFader]'s child.
  final Widget child;

  /// This property is used to configure shader direction
  final Axis scrollDirection;

  @override
  State<ScrollFader> createState() => _ScrollFaderState();
}

class _ScrollFaderState extends State<ScrollFader> {
  double _stopStart = 0;
  double _stopEnd = 1;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        setState(() {
          _stopStart = scrollNotification.metrics.pixels / 10;
          _stopEnd = (scrollNotification.metrics.maxScrollExtent -
                  scrollNotification.metrics.pixels) /
              10;

          _stopStart = _stopStart.clamp(0.0, 1.0);
          _stopEnd = _stopEnd.clamp(0.0, 1.0);
        });
        return true;
      },
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: widget.scrollDirection == Axis.horizontal
                ? Alignment.centerLeft
                : Alignment.topCenter,
            end: widget.scrollDirection == Axis.horizontal
                ? Alignment.centerRight
                : Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.background,
              Colors.transparent,
              Colors.transparent,
              Theme.of(context).colorScheme.background,
            ],
            stops: [0.0, 0.1 * _stopStart, 1 - 0.1 * _stopEnd, 1.0],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: widget.child,
      ),
    );
  }
}
