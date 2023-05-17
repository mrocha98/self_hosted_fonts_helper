import 'package:flutter/material.dart';

class TextList extends StatelessWidget {
  const TextList({
    super.key,
    this.childen = const <Widget>[],
    this.marker = '\u2022',
    this.markerStyle,
  });

  final List<Widget> childen;

  final String marker;

  final TextStyle? markerStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: childen
          .map(
            (widget) => Wrap(
              spacing: 6,
              children: [
                Text(
                  marker,
                  style: markerStyle,
                ),
                widget,
              ],
            ),
          )
          .toList(growable: false),
    );
  }
}
