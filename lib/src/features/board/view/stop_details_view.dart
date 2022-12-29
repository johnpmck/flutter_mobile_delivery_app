// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobile_delivery_app/main.dart';
import 'package:flutter_mobile_delivery_app/src/common/sample_data.dart';
import 'package:flutter_mobile_delivery_app/src/common/stop_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../controller/board_controller.dart';
import 'stop_details_tile.dart';

/// Widget for showing a map of the current stop.
class _StopMapWidget extends StatelessWidget {
  const _StopMapWidget({super.key, required this.stopData});

  final StopData stopData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(
            stopData.lat,
            stopData.lon,
          ),
          zoom: 17.0,
        ),
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: '\u00A9 OpenStreetMap contributors',
            onSourceTapped: () {},
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 24.0,
                height: 24.0,
                point: LatLng(
                  stopData.lat,
                  stopData.lon,
                ),
                builder: (_) => const Icon(
                  Icons.place,
                  color: Color(0xFF005996),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Navigation arrows for changing the selected stop
///
/// Button for opening Google Maps using the `lat` and `lon` of the stop as the destination.
class _StopControlWidget extends ConsumerWidget {
  const _StopControlWidget({
    super.key,
    required this.onNextStop,
    required this.onPreviousStop,
  });

  final void Function(bool, WidgetRef) onNextStop;
  final void Function(bool, WidgetRef) onPreviousStop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => onNextStop(true, ref),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                elevation: 0,
                foregroundColor: Theme.of(context).colorScheme.onSurface),
            child: Row(
              children: const [
                Icon(Icons.pin_drop),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text('Start Navigation'),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => onPreviousStop(false, ref),
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}

/// Widget for listing all attributes of the stop; signature required, overweight, etc.
class _StopAttributesWidget extends StatelessWidget {
  const _StopAttributesWidget({super.key, required this.stopData});

  final StopData stopData;

  Icon _getAttributeIcon(String attribute) {
    switch (attribute) {
      case 'alternate_location':
        return const Icon(Icons.home_work_outlined);
      case 'signature_required':
        return const Icon(Icons.person_outline);
      default:
        return const Icon(Icons.home_work_outlined);
    }
  }

  String _getAttributeString(String attribute) {
    final split = attribute.replaceAll('_', ' ');
    final firstLetter = split.substring(0, 1);
    final captializeFirst = firstLetter.toUpperCase();
    return '$captializeFirst${split.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Wrap(
          direction: Axis.vertical,
          spacing: 12,
          children: [
            const Text(
              'Information',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...stopData.attributes
                .map(
                  (e) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _getAttributeIcon(e),
                      const SizedBox(width: 8.0),
                      // Text(e),
                      Text(_getAttributeString(e)),
                    ],
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

/// Display all information about the StopData that corresponds to `itineraryIndex`.
class StopDetailsView extends ConsumerStatefulWidget {
  StopDetailsView({super.key, required this.itineraryIndex});

  int itineraryIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeliveryDetailsViewState();
}

class _DeliveryDetailsViewState extends ConsumerState<StopDetailsView> {
  late int _itineraryIndex;

  @override
  void initState() {
    super.initState();
    _itineraryIndex = widget.itineraryIndex;
  }

  void _changeItineraryIndex(bool forward, WidgetRef ref) {
    List<StopData> sampleData = ref.read(sampleDataProvider);
    int nextStop = forward ? (_itineraryIndex + 1) : (_itineraryIndex - 1);
    if (nextStop > sampleData.length) {
      nextStop = 0;
    } else if (nextStop < 0) {
      nextStop = sampleData.length;
    }

    setState(() {
      _itineraryIndex = nextStop;
    });
  }

  @override
  Widget build(BuildContext context) {
    StopData stopData = ref.watch(sampleDataProvider)[_itineraryIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Assignment Details'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          StopDetailsTile(
            stopData: stopData,
            tileIndex: 0,
          ),
          _StopMapWidget(stopData: stopData),
          _StopControlWidget(
            onNextStop: (b, r) => _changeItineraryIndex(b, r),
            onPreviousStop: (b, r) => _changeItineraryIndex(b, r),
          ),
          _StopAttributesWidget(stopData: stopData),
          // ~ Non-Deliver & Start options.
          Container(
            padding: const EdgeInsets.all(8),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('You have opted not to complete this stop.'),
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Non Deliver',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(selectedTrackingNumbersProvider.notifier)
                            .state = stopData.trackingNums;
                        Navigator.of(context).pushNamed(
                          confirmDeliveryRoute,
                          arguments: _itineraryIndex,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        margin: const EdgeInsets.only(left: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Start',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
