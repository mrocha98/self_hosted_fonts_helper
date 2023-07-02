import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade300
          : Colors.grey.shade900,
      highlightColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade100
          : Colors.grey.shade400,
      child: child,
    );
  }
}
