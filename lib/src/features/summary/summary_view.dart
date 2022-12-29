import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/sample_data.dart';
import '../board/view/stop_details_tile.dart';

/// View for displaying a summary of remaining stops and completed stops.
class SummaryView extends ConsumerWidget {
  const SummaryView({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final srcData = ref.watch(sampleDataProvider);
    final completedStops = srcData.where((d) => d.completed == true).toList();
    final remainingStops = srcData.where((d) => d.completed == false).toList();
    final nextStop = srcData[0];
    int deliveredItems = 0;
    int remainingItems = 0;

    for (var r in remainingStops) {
      remainingItems += r.trackingNums.length;
    }

    for (var c in completedStops) {
      deliveredItems += c.trackingNums.length;
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext _) {
          return CustomScrollView(
            key: PageStorageKey<String>(name),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(_),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  ExpansionTile(
                    key: const PageStorageKey('remaining_work'),
                    initiallyExpanded: true,
                    title: const Text('Work Remaining'),
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 24.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Remaining Stops: ${remainingStops.length}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            direction: Axis.vertical,
                            spacing: 16.0,
                            children: [
                              Text(
                                  'Remaining Deliveries: ${remainingStops.length}'),
                              const Text('Remaining Pickups: 0'),
                            ],
                          ),
                          Wrap(
                            direction: Axis.vertical,
                            spacing: 16.0,
                            children: [
                              Text('Remaining Packages: $remainingItems'),
                              const Text('No new pickups'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      Container(
                        margin: const EdgeInsets.only(bottom: 24.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Next Stop',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      StopDetailsTile(
                        stopData: nextStop,
                        tileIndex: 0,
                      ),
                    ],
                  ),
                  ExpansionTile(
                    key: const PageStorageKey('completed_work'),
                    title: const Text('Work Completed'),
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 24.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Stops Completed: ${completedStops.length}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            direction: Axis.vertical,
                            spacing: 16.0,
                            children: [
                              Text(
                                  'Completed Deliveries: ${completedStops.length}'),
                              const Text('Completed Pickups: 3'),
                            ],
                          ),
                          Wrap(
                            direction: Axis.vertical,
                            spacing: 16.0,
                            children: [
                              Text('Packages Delivered: $deliveredItems'),
                              // Text('No new pickups'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ]),
              )
            ],
          );
        },
      ),
    );
  }
}
