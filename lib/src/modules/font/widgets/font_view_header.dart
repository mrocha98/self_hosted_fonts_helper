import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/helpers/breakpoints.dart';
import '../../../models/font_model.dart';
import '../../fonts_filter/fonts_filter_controller.dart';

class FontViewHeader extends StatelessWidget {
  const FontViewHeader({
    required this.font,
    super.key,
  });

  final FontModel font;

  Widget _buildFontPropsRow(
    BuildContext context, {
    required String title,
    required String content,
  }) =>
      Row(
        mainAxisSize: MainAxisSize.min,
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              content,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          font.family,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontFamily: font.family,
              ),
        ),
        Text(
          font.category,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontFamily: font.family,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade600
                    : Colors.grey,
              ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: BoxConstraints.loose(
            Size.fromWidth(Breakpoints.lg.toDouble()),
          ),
          child: Wrap(
            spacing: 32,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFontPropsRow(
                    context,
                    title: '${font.variants.length} styles',
                    content: font.variants.map((v) => v.id).join(', '),
                  ),
                  _buildFontPropsRow(
                    context,
                    title: '${font.subsets.length} charsets',
                    content: font.subsets.join(', '),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFontPropsRow(
                    context,
                    title: 'Rank ${font.popularity}',
                    content:
                        'in popularity of ${context.select<FontsFilterController, int>((controller) => controller.totalFonts)} fonts in total',
                  ),
                  _buildFontPropsRow(
                    context,
                    title: 'Last modified ${font.lastModified}',
                    content: '(${font.version})',
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
