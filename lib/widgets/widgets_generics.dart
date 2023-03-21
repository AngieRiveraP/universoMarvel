import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletons/skeletons.dart';

class ParagraphShimmer extends StatelessWidget {
  final int lines;
  final double space;
  final double height;

  const ParagraphShimmer({super.key,
    required this.lines,
    required this.space,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
        themeMode: ThemeMode.dark,
        shimmerGradient:  LinearGradient(
          colors: [
            Colors.blueGrey.withOpacity(0.9),
            Colors.black.withOpacity(0.6),
            Colors.white.withOpacity(0.9),
          ],
          stops: const [
            0.1,
            0.5,
            0.9,
          ],
        ),
        child: SkeletonParagraph(
          style: SkeletonParagraphStyle(
              lines: lines,
              spacing: space,
              padding: const EdgeInsets.all(0),
              lineStyle: SkeletonLineStyle(
                  height: height, borderRadius: BorderRadius.circular(16))),
        ));
  }
}

class ParagraphShimmerLight extends StatelessWidget {
  final int lines;
  final double space;
  final double height;

  const ParagraphShimmerLight({super.key,
    required this.lines,
    required this.space,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
        themeMode: ThemeMode.light,
        shimmerGradient:  const LinearGradient(
          colors: [
            Colors.grey,
            Colors.white,
            Colors.grey
          ],
          stops: [
            0.1,
            0.5,
            0.9,
          ],
        ),
        child: SkeletonParagraph(
          style: SkeletonParagraphStyle(
              lines: lines,
              spacing: space,
              padding: const EdgeInsets.all(0),
              lineStyle: SkeletonLineStyle(
                  height: height, borderRadius: BorderRadius.circular(16))),
        ));
  }
}

Widget loadingMore() {
  return const ClassicFooter(
    loadingText: "",
    noDataText: "",
    idleText: "",
    failedText: "",
    canLoadingText: "",
    noMoreIcon: null,
    failedIcon: null,
    idleIcon: null,
  );
}
