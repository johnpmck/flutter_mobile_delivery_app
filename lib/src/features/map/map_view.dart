import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobile_delivery_app/src/features/map/map_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../common/sample_data.dart';
import '../board/view/stop_details_tile.dart';

/// View for displaying all StopData on a map.
class MapView extends ConsumerWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final src = ref.read(sampleDataProvider);
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext _) {
          return Column(
            children: [
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(src[4].lat, src[4].lon),
                    zoom: 14.0,
                  ),
                  nonRotatedChildren: [
                    AttributionWidget.defaultWidget(
                      source: '\u00A9 OpenStreetMap contributors',
                      onSourceTapped: () {},
                    ),
                  ],
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: ref.watch(deliveryMarkersProvider),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: StopDetailsTile(
                  stopData: src[0],
                  tileIndex: 0,
                  elevated: true,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
