import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:math' as math;

import '../../../common/sample_data.dart';
import 'stop_details_tile.dart';

class BoardView extends ConsumerWidget {
  const BoardView({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sampleItinerary = ref.watch(sampleDataProvider)
      ..where((d) => d.completed == false).toList();
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            key: PageStorageKey<String>(name),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final itemIdx = index ~/ 2;
                    return (index.isEven)
                        ? StopDetailsTile(
                            stopData: sampleItinerary[itemIdx],
                            tileIndex: itemIdx,
                          )
                        : const Divider(
                            height: 1.0,
                            thickness: 0,
                          );
                  },
                  semanticIndexCallback: (widget, localIndex) {
                    return (localIndex.isEven) ? localIndex ~/ 2 : null;
                  },
                  childCount: math.max(0, (sampleItinerary.length * 2 - 1)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
