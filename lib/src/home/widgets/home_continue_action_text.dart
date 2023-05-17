import 'package:flutter/material.dart';

import '../../core/locale/app_localizations.dart';

class HomeContinueActionText extends StatefulWidget {
  const HomeContinueActionText({super.key});

  @override
  State<HomeContinueActionText> createState() => _HomeContinueActionTextState();
}

class _HomeContinueActionTextState extends State<HomeContinueActionText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
      lowerBound: 0.5,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: _animation,
          child: Icon(
            Icons.arrow_back_rounded,
            size: Theme.of(context).textTheme.bodyLarge!.fontSize! * 1.2,
          ),
        ),
        const SizedBox(width: 4),
        Text(AppLocalizations.of(context)!.homeContinueAction),
      ],
    );
  }
}
