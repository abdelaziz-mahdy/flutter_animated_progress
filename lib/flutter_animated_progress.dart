library flutter_animated_progress;

import 'package:flutter/material.dart';

class AnimatedLinearProgressIndicator extends ProgressIndicator {
  const AnimatedLinearProgressIndicator({
    Key? key,
    double? value,
    Color? backgroundColor,
    Color? color,
    Animation<Color?>? valueColor,
    this.minHeight,
    String? semanticsLabel,
    String? semanticsValue,
    this.animationDuration = const Duration(milliseconds: 500),
    this.goingBackAnimationDuration = const Duration(milliseconds: 100),
    this.animationCurve = Curves.easeInOut,
  })  : assert(minHeight == null || minHeight > 0),
        super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          color: color,
          valueColor: valueColor,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        );

  /// {@template flutter.material.LinearProgressIndicator.trackColor}
  /// Color of the track being filled by the linear indicator.
  ///
  /// If [AnimatedLinearProgressIndicator.backgroundColor] is null then the
  /// ambient [AnimatedLinearProgressIndicator.linearTrackColor] will be used.
  /// If that is null, then the ambient theme's [ColorScheme.background]
  /// will be used to draw the track.
  /// {@endtemplate}
  @override
  Color? get backgroundColor => super.backgroundColor;

  /// {@template flutter.material.LinearProgressIndicator.minHeight}
  /// The minimum height of the line used to draw the linear indicator.
  ///
  /// If [AnimatedLinearProgressIndicator.minHeight] is null then it will use the
  /// ambient [AnimatedLinearProgressIndicator.linearMinHeight]. If that is null
  /// it will use 4dp.
  /// {@endtemplate}
  final double? minHeight;

  /// The animation duration for the progress.
  /// If animationDuration is null then it will use the default Duration(milliseconds: 500).
  final Duration? animationDuration;

  /// The animation duration for the progress when going back.
  /// If animationDuration is null then it will use the default Duration(milliseconds: 100).
  final Duration? goingBackAnimationDuration;

  /// The animation Curve for the progress when going back.
  /// If animationCurve is null then it will use the default Curves.easeInOut.
  final Curve animationCurve;
  @override
  _AnimatedLinearProgressIndicatorState createState() =>
      _AnimatedLinearProgressIndicatorState();
}

class _AnimatedLinearProgressIndicatorState
    extends State<AnimatedLinearProgressIndicator>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  AnimationController? _goingBackController;
  Tween<double>? _tween;
  Animation<double>? _animation;
  Animation<double>? _goingBackAnimation;
  bool _goingBack = false;
  void _setControllers() {
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _goingBackController = AnimationController(
      duration: widget.goingBackAnimationDuration,
      vsync: this,
    );
    _tween = Tween(begin: widget.value, end: widget.value);
    _animation = _tween?.animate(
      CurvedAnimation(
        curve: widget.animationCurve,
        parent: _controller!,
      ),
    );
    _goingBackAnimation = _tween?.animate(
      CurvedAnimation(
        curve: widget.animationCurve,
        parent: _goingBackController!,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _setControllers();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _goingBack ? _goingBackAnimation! : _animation!,
        builder: (context, child) {
          return LinearProgressIndicator(
            key: widget.key,
            value: _goingBack ? _goingBackAnimation!.value : _animation!.value,
            backgroundColor: widget.backgroundColor,
            color: widget.color,
            valueColor: widget.valueColor,
            minHeight: widget.minHeight,
            semanticsLabel: widget.semanticsLabel,
            semanticsValue: widget.semanticsValue,
          );
        });
  }

  @override
  void didUpdateWidget(AnimatedLinearProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((oldWidget.animationDuration != widget.animationDuration) ||
        (oldWidget.goingBackAnimationDuration !=
            widget.goingBackAnimationDuration) ||
        (oldWidget.animationCurve != widget.animationCurve)) {
      //print("duration is changed remaking the controller and tween");
      _setControllers();
    }
    //print(" old value ${_tween?.begin }  new value ${oldWidget.value},old end ${_tween?.end},animationValue ${_animation?.value}");

    //animation old value
    double animationOldValue = 0;
    if (_goingBack) {
      animationOldValue = _goingBackAnimation!.value;
    } else {
      animationOldValue = _animation!.value;
    }
    if (_animation!.value > widget.value!) {
      _goingBack = true;
      _tween?.begin = animationOldValue;
      _controller?.reset();
      _goingBackController?.reset();
      _tween?.end = widget.value;
      _goingBackController?.forward();
    } else {
      _goingBack = false;
      _tween?.begin = animationOldValue;
      _controller?.reset();
      _goingBackController?.reset();
      _tween?.end = widget.value;
      _controller?.forward();
    }
  }

  @override
  dispose() {
    _controller?.dispose(); // you need this
    super.dispose();
  }
}

class AnimatedCircularProgressIndicator extends ProgressIndicator {
  const AnimatedCircularProgressIndicator({
    Key? key,
    double? value,
    Color? backgroundColor,
    Color? color,
    Animation<Color?>? valueColor,
    String? semanticsLabel,
    this.strokeWidth = 4.0,
    String? semanticsValue,
    this.animationDuration = const Duration(milliseconds: 500),
    this.goingBackAnimationDuration = const Duration(milliseconds: 100),
    this.animationCurve = Curves.easeInOut,
  }) : super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          color: color,
          valueColor: valueColor,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        );

  /// The width of the line used to draw the circle.
  final double strokeWidth;

  /// The animation duration for the progress.
  /// If animationDuration is null then it will use the default Duration(milliseconds: 500).
  final Duration? animationDuration;

  /// The animation duration for the progress when going back.
  /// If animationDuration is null then it will use the default Duration(milliseconds: 500).
  final Duration? goingBackAnimationDuration;

  /// The animation Curve for the progress when going back.
  /// If animationCurve is null then it will use the default Curves.easeInOut.
  final Curve animationCurve;

  @override
  _AnimatedCircularProgressIndicatorState createState() =>
      _AnimatedCircularProgressIndicatorState();
}

class _AnimatedCircularProgressIndicatorState
    extends State<AnimatedCircularProgressIndicator>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  AnimationController? _goingBackController;
  Tween<double>? _tween;
  Animation<double>? _animation;
  Animation<double>? _goingBackAnimation;
  bool _goingBack = false;
  void _setControllers() {
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _goingBackController = AnimationController(
      duration: widget.goingBackAnimationDuration,
      vsync: this,
    );
    _tween = Tween(begin: widget.value, end: widget.value);
    _animation = _tween?.animate(
      CurvedAnimation(
        curve: widget.animationCurve,
        parent: _controller!,
      ),
    );
    _goingBackAnimation = _tween?.animate(
      CurvedAnimation(
        curve: widget.animationCurve,
        parent: _goingBackController!,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _setControllers();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _goingBack ? _goingBackAnimation! : _animation!,
        builder: (context, child) {
          return CircularProgressIndicator(
            key: widget.key,
            value: _goingBack ? _goingBackAnimation!.value : _animation!.value,
            backgroundColor: widget.backgroundColor,
            color: widget.color,
            valueColor: widget.valueColor,
            strokeWidth: widget.strokeWidth,
            semanticsLabel: widget.semanticsLabel,
            semanticsValue: widget.semanticsValue,
          );
        });
  }

  @override
  void didUpdateWidget(AnimatedCircularProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((oldWidget.animationDuration != widget.animationDuration) ||
        (oldWidget.goingBackAnimationDuration !=
            widget.goingBackAnimationDuration) ||
        (oldWidget.animationCurve != widget.animationCurve)) {
      //print("duration is changed remaking the controller and tween");
      _setControllers();
    }
    //print(" old value ${_tween?.begin }  new value ${oldWidget.value},old end ${_tween?.end},animationValue ${_animation?.value}");
    //animation old value
    double animationOldValue = 0;
    if (_goingBack) {
      animationOldValue = _goingBackAnimation!.value;
    } else {
      animationOldValue = _animation!.value;
    }
    if (_animation!.value > widget.value!) {
      _goingBack = true;
      _tween?.begin = animationOldValue;
      _controller?.reset();
      _goingBackController?.reset();
      _tween?.end = widget.value;
      _goingBackController?.forward();
    } else {
      _goingBack = false;
      _tween?.begin = animationOldValue;
      _controller?.reset();
      _goingBackController?.reset();
      _tween?.end = widget.value;
      _controller?.forward();
    }
  }

  @override
  dispose() {
    _controller?.dispose(); // you need this
    super.dispose();
  }
}
