import 'package:flutter/material.dart';

import '../../../core/widgets/shimmer_container.dart';

class FontViewLoadingShimmer extends StatelessWidget {
  const FontViewLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(top: 8, bottom: 24),
          sliver: SliverToBoxAdapter(
            child: ShimmerContainer(
              child: Container(
                width: double.infinity,
                height: 164,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 24),
          sliver: SliverToBoxAdapter(
            child: ShimmerContainer(
              child: Container(
                width: double.infinity,
                height: 112,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          child: ShimmerContainer(
            child: Container(
              width: double.infinity,
              height: 112,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
