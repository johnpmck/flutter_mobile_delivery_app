import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobile_delivery_app/src/common/sample_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

final deliveryMarkersProvider = StateProvider<List<Marker>>((ref) {
  var markers = <Marker>[];
  final sampleData = ref.read(sampleDataProvider);
  for (var sd in sampleData) {
    final markerPoint = LatLng(sd.lat, sd.lon);
    markers.add(
      Marker(
        height: 24.0,
        width: 24.0,
        point: markerPoint,
        builder: (_) => const Icon(
          Icons.place,
          color: Color(0xFF005996),
        ),
      ),
    );
  }

  return markers;
});
