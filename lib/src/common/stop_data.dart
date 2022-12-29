class StopData {
  StopData({
    required this.id,
    required this.label,
    required this.addressLineOne,
    required this.addressLineTwo,
    required this.hin,
    required this.numPieces,
    required this.deliverByTime,
    required this.distance,
    required this.lat,
    required this.lon,
    required this.trackingNums,
    required this.attributes,
    this.releaseLocation,
    required this.completed,
  });

  final String id;
  final String label;
  final String addressLineOne;
  final String addressLineTwo;
  final String hin;
  final int numPieces;
  final DateTime deliverByTime;
  final double distance;
  final double lat;
  final double lon;
  final List<String> trackingNums;
  final List<String> attributes;
  String? releaseLocation;
  bool completed;

  @override
  bool operator ==(Object other) =>
      other is StopData &&
      other.id == id &&
      other.label == label &&
      other.addressLineOne == addressLineOne &&
      other.addressLineTwo == addressLineTwo &&
      other.hin == hin &&
      other.numPieces == numPieces &&
      other.deliverByTime == deliverByTime &&
      other.distance == distance &&
      other.lat == lat &&
      other.lon == lon &&
      other.trackingNums == trackingNums &&
      other.attributes == attributes &&
      other.releaseLocation == releaseLocation &&
      other.completed == completed;

  @override
  int get hashCode => Object.hash(
      id,
      label,
      addressLineOne,
      addressLineTwo,
      hin,
      numPieces,
      deliverByTime,
      distance,
      lat,
      lon,
      Object.hashAll(trackingNums),
      Object.hashAll(attributes),
      releaseLocation,
      completed);
}
