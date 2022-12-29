import 'package:flutter_riverpod/flutter_riverpod.dart';

// final assignmentDetailsIndexProvider = StateProvider<int>((_) => 0);

/// A List<String> of all tracking numbers for a selected delivery.
final selectedTrackingNumbersProvider = StateProvider<List<String>>((_) => []);

/// Tracking numbers that have already been "scanned".
final confirmedTrackingNumbersProvider = StateProvider<List<String>>((_) => []);

/// The number of "completed" stops.
final completedStopsProvider = StateProvider<int>((_) => 0);
