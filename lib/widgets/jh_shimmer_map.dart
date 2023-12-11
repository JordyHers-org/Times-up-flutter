import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMap extends StatelessWidget {
  const ShimmerMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).scaffoldBackgroundColor,
      highlightColor: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
