import 'package:flutter/material.dart';

/// A decorated control with ink feedback, keyboard focus.
class AppTappable extends StatelessWidget {
  const AppTappable({
    super.key,
    required this.onTap,
    required this.child,
    this.decoration = const BoxDecoration(),
    this.width,
    this.height,
    this.padding,
    this.alignment,
  });

  final VoidCallback onTap;
  final Widget child;
  final BoxDecoration decoration;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final ShapeBorder shape = decoration.shape == BoxShape.circle
        ? const CircleBorder()
        : RoundedRectangleBorder(
            borderRadius: decoration.borderRadius ?? BorderRadius.zero,
          );
    return Material(
      color: Colors.transparent,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: Ink(
        width: width,
        height: height,
        decoration: decoration,
        child: InkWell(
          onTap: onTap,
          customBorder: shape,
          splashColor: decoration.gradient == null
              ? Colors.black12
              : Colors.white54,
          highlightColor: Colors.black12,
          hoverColor: Colors.black12,
          focusColor: Colors.black26,
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Align(
              alignment: alignment ?? Alignment.center,
              widthFactor: 1,
              heightFactor: 1,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
