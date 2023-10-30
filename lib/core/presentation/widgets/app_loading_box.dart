import 'dart:ui';

import 'package:flutter/material.dart';

class AppLoadingBox extends StatelessWidget {

  const AppLoadingBox({super.key,
    required this.loading,
    this.duration = const Duration(milliseconds: 300),
    this.size = 50.0,
    required this.child,
  });
  final bool loading;
  final Duration duration;
  final double size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
       child,
        if (loading)
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 1.0,
              sigmaY: 1.0,
            ),
            child: Container(
              color: Colors.black12.withOpacity(0.05), // Transparent overlay
              child: Center(
                child: SizedBox(
                  width: size,
                  height: size,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
