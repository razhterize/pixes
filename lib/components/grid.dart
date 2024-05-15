import 'package:flutter/widgets.dart';
import 'package:pixes/foundation/app.dart';

class SliverGridViewWithFixedItemHeight extends StatelessWidget {
  const SliverGridViewWithFixedItemHeight(
      {required this.delegate,
        required this.maxCrossAxisExtent,
        required this.itemHeight,
        super.key});

  final SliverChildDelegate delegate;

  final double maxCrossAxisExtent;

  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
        builder: ((context, constraints) => SliverGrid(
          delegate: delegate,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: maxCrossAxisExtent,
              childAspectRatio:
              calcChildAspectRatio(constraints.crossAxisExtent)),
        ).sliverPadding(EdgeInsets.only(bottom: context.padding.bottom))));
  }

  double calcChildAspectRatio(double width) {
    var crossItems = width ~/ maxCrossAxisExtent;
    if (width % maxCrossAxisExtent != 0) {
      crossItems += 1;
    }
    final itemWidth = width / crossItems;
    return itemWidth / itemHeight;
  }
}

class GridViewWithFixedItemHeight extends StatelessWidget {
  const GridViewWithFixedItemHeight(
      { required this.builder,
        required this.itemCount,
        required this.maxCrossAxisExtent,
        required this.itemHeight,
        super.key});

  final Widget Function(BuildContext, int) builder;

  final int itemCount;

  final double maxCrossAxisExtent;

  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: ((context, constraints) => GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: maxCrossAxisExtent,
              childAspectRatio:
              calcChildAspectRatio(constraints.maxWidth)),
          itemBuilder: builder,
          itemCount: itemCount,
          padding: EdgeInsets.only(bottom: context.padding.bottom),
        )));
  }

  double calcChildAspectRatio(double width) {
    var crossItems = width ~/ maxCrossAxisExtent;
    if (width % maxCrossAxisExtent != 0) {
      crossItems += 1;
    }
    final itemWidth = width / crossItems;
    return itemWidth / itemHeight;
  }
}