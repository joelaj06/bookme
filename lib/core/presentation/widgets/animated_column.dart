import 'dart:async';

import 'package:flutter/material.dart';

class AppAnimatedColumn extends StatefulWidget {
  const AppAnimatedColumn({
    AnimationController? animationController,
    required this.children,
    Key? key,
    this.mainAxisAlignment,
    this.duration = const Duration(milliseconds: 1000),
    this.delay,
    this.crossAxisAlignment,
    this.direction = Axis.vertical,
    this.mainAxisSize,
  })  : _animationController = animationController,
        super(key: key);

  final AnimationController? _animationController;
  final List<Widget> children;
  final Duration? duration;
  final Duration? delay;
  final MainAxisAlignment? mainAxisAlignment;
  final Axis direction;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;

  @override
  _AppAnimatedColumnState createState() => _AppAnimatedColumnState();
}

class _AppAnimatedColumnState extends State<AppAnimatedColumn>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  Timer? delay;
  @override
  void initState() {
    _animationController = widget._animationController ??
        AnimationController(
          vsync: this,
          duration: widget.duration ??
              Duration(
                milliseconds: widget.children.length * 200,
              ),
        );
    if (widget._animationController == null) {
      delay = Timer(widget.delay ?? Duration.zero, () {
        _animationController?.forward();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    delay?.cancel();
    if (widget._animationController == null) {
      _animationController?.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (BuildContext context, Widget? child) {
        return Column(
          mainAxisSize: widget.mainAxisSize ?? MainAxisSize.max,
          crossAxisAlignment:
              widget.crossAxisAlignment ?? CrossAxisAlignment.start,
          mainAxisAlignment:
              widget.mainAxisAlignment ?? MainAxisAlignment.start,
          children: <Widget>[
            ...List<Widget>.generate(widget.children.length, (int index) {
              return FadeTransition(
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(
                  CurvedAnimation(
                    curve: Interval(
                      1 / widget.children.length * index * 0.25,
                      1 / widget.children.length * index,
                      curve: Curves.easeInOut,
                    ),
                    parent: _animationController!,
                  ),
                ),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: widget.direction == Axis.vertical
                        ? Offset(0.0, index == 0 ? 1.5 : .5)
                        : const Offset(.25, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      curve: Interval(
                        index == 0
                            ? 0
                            : 1 / widget.children.length * (index + 1) * 0.20,
                        index == 0
                            ? .5
                            : 1 / widget.children.length * (index + 1),
                        curve: index == 0
                            ? Curves.fastLinearToSlowEaseIn
                            : Curves.linearToEaseOut,
                      ),
                      parent: _animationController!,
                    ),
                  ),
                  child: widget.children[index],
                ),
              );
            })
          ],
        );
      },
    );
  }
}

class AppAnimatedRow extends StatefulWidget {
  const AppAnimatedRow({
    AnimationController? animationController,
    required this.children,
    Key? key,
    this.mainAxisAlignment,
    this.duration,
    this.delay,
    this.crossAxisAlignment,
    this.direction = Axis.vertical,
    this.mainAxisSize,
  })  : _animationController = animationController,
        super(key: key);

  final AnimationController? _animationController;
  final List<Widget> children;
  final Duration? duration;
  final Duration? delay;
  final MainAxisAlignment? mainAxisAlignment;
  final Axis direction;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;

  @override
  _AppAnimatedRowState createState() => _AppAnimatedRowState();
}

class _AppAnimatedRowState extends State<AppAnimatedRow>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = widget._animationController ??
        AnimationController(
            vsync: this,
            duration: widget.duration ??
                Duration(milliseconds: widget.children.length * 300));

    if (widget._animationController == null) {
      Future<void>.delayed(widget.delay ?? const Duration(milliseconds: 100))
          .then((_) => _animationController.forward());
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget._animationController == null) {
      _animationController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Row(
          mainAxisSize: widget.mainAxisSize ?? MainAxisSize.max,
          crossAxisAlignment:
              widget.crossAxisAlignment ?? CrossAxisAlignment.start,
          mainAxisAlignment:
              widget.mainAxisAlignment ?? MainAxisAlignment.start,
          children: <Widget>[
            ...List<Widget>.generate(widget.children.length, (int index) {
              return FadeTransition(
                key: ValueKey<int>(index),
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(
                  CurvedAnimation(
                    curve: Interval(
                      1 / widget.children.length * index * 0.1,
                      1 / widget.children.length * index,
                      curve: Curves.easeInOut,
                    ),
                    parent: _animationController,
                  ),
                ),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: widget.direction == Axis.vertical
                        ? const Offset(0.0, 1.0)
                        : const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      curve: Interval(
                        1 / widget.children.length * index * 0.1,
                        1 / widget.children.length * index,
                        curve: Curves.ease,
                      ),
                      parent: _animationController,
                    ),
                  ),
                  child: widget.children[index],
                ),
              );
            })
          ],
        );
      },
    );
  }
}
