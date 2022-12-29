import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'stop_data.dart';

/// Centroid -> 43.201036276725105, -71.5374248096564

List<StopData> _sampleData = [
  /// City Hall -> 43.20618657861024, -71.54010825303821
  StopData(
    id: 'G9Qb2vHVtK',
    label: 'Concord, NH, City Hall',
    addressLineOne: '41 Green Street',
    addressLineTwo: 'Concord, NH 03301',
    hin: '7376',
    numPieces: 1,
    deliverByTime: DateTime.now(),
    distance: 2.39,
    lat: 43.20618657861024,
    lon: -71.54010825303821,
    trackingNums: ['1Z54F78A0450293517'],
    attributes: ['alternate_location', 'signature_required'],
    completed: false,
  ),

  /// NH Library -> 43.20750426667522, -71.53869204669401
  StopData(
    id: 'KkNZ12Gf6B',
    label: 'NH State Library',
    addressLineOne: '20 Park Street',
    addressLineTwo: 'Concord, NH 03301',
    hin: '7346',
    numPieces: 2,
    deliverByTime: DateTime.now(),
    distance: 2.47,
    lat: 43.20750426667522,
    lon: -71.53869204669401,
    trackingNums: ['1Z54F78A0450293517', '1Z33G36C0341371253'],
    attributes: [],
    completed: false,
  ),

  /// Vanacore Law Offices -> 43.210710391817486, -71.5413957133363
  StopData(
    id: 'YCrVWsNHQq',
    label: 'Vanacore Law Offices',
    addressLineOne: '19 Washington Street #4341',
    addressLineTwo: 'Concord, NH 03301',
    hin: '7421',
    numPieces: 1,
    deliverByTime: DateTime.now(),
    distance: 2.83,
    lat: 43.210710391817486,
    lon: -71.5413957133363,
    trackingNums: ['1Z54F78A0450293517'],
    attributes: [],
    completed: false,
  ),

  /// Fraser Insurance Services -> 43.20350419380824, -71.53933041234743
  StopData(
    id: 'ndEVbxv6Tp',
    label: 'Fraser Insurance Services',
    addressLineOne: '7 Green Street',
    addressLineTwo: 'Concord, NH 03301',
    hin: '7421',
    numPieces: 1,
    deliverByTime: DateTime.now(),
    distance: 3.06,
    lat: 43.20350419380824,
    lon: -71.53933041234743,
    trackingNums: ['1Z54F78A0450293517'],
    attributes: [],
    completed: false,
  ),

  /// Anderson & Cloues -> 43.20406726976916, -71.53945915837231
  StopData(
    id: 'H9txuSAWZA',
    label: 'Anderson & Cloues',
    addressLineOne: '13 Green Street',
    addressLineTwo: 'Concord, NH 03301',
    hin: '8541',
    numPieces: 3,
    deliverByTime: DateTime.now(),
    distance: 3.29,
    lat: 43.20406726976916,
    lon: -71.53945915837231,
    trackingNums: [
      '1Z54F78A0450293517',
      '1ZLNX48EMZZWLO8766',
      '1ZHAIWGY93AGVQ4234'
    ],
    attributes: [],
    completed: false,
  ),

  /// South Mane Barbershop -> 43.20276905904602, -71.53555386220698
  StopData(
    id: 'mWJfCmImOG',
    label: 'South Mane Barbershop',
    addressLineOne: '28 S Main Street #1B',
    addressLineTwo: 'Concord, NH 03301',
    hin: '7483',
    numPieces: 1,
    deliverByTime: DateTime.now(),
    distance: 3.35,
    lat: 43.20276905904602,
    lon: -71.53555386220698,
    trackingNums: ['1Z54F78A0450293517'],
    attributes: [],
    completed: false,
  ),

  /// Thompson Insurance Agency -> 43.20090772073001, -71.53348319680822
  StopData(
    id: '7eTpR3Zy76',
    label: 'Thompson Insurance Agency',
    addressLineOne: '63 S Main Street',
    addressLineTwo: 'Concord, NH 03301',
    hin: '7397',
    numPieces: 1,
    deliverByTime: DateTime.now(),
    distance: 3.65,
    lat: 43.20090772073001,
    lon: -71.53348319680822,
    trackingNums: ['1Z54F78A0450293517'],
    attributes: [],
    completed: false,
  ),

  /// The UPS Store -> 43.20055187015315, -71.5327965512697
  StopData(
    id: 'SA1HfY441H',
    label: 'The UPS Store',
    addressLineOne: '75 S Main Street',
    addressLineTwo: 'Concord, NH 03301',
    hin: '7386',
    numPieces: 1,
    deliverByTime: DateTime.now(),
    distance: 3.65,
    lat: 43.20055187015315,
    lon: -71.5327965512697,
    trackingNums: ['1Z54F78A0450293517'],
    attributes: [],
    completed: false,
  ),

  /// Genoa Healthcare -> 43.19733347910527, -71.53227620273749
  StopData(
    id: 'RPTDoekbfV',
    label: 'Genoa Healthcare',
    addressLineOne: '10 West Street',
    addressLineTwo: 'Concord, NH 03301',
    hin: '7376',
    numPieces: 1,
    deliverByTime: DateTime.now(),
    distance: 2.39,
    lat: 43.19733347910527,
    lon: -71.53227620273749,
    trackingNums: ['1Z54F78A0450293517'],
    attributes: [],
    completed: false,
  ),

  /// RePetes Comic Shop -> 43.19483842486461, -71.53232448244715
  StopData(
    id: 'BI9mgiifwq',
    label: 'RePetes Comics & Collectibles',
    addressLineOne: '106B S State Street',
    addressLineTwo: 'Concord, NH 03301',
    hin: '7346',
    numPieces: 2,
    deliverByTime: DateTime.now(),
    distance: 2.47,
    lat: 43.19483842486461,
    lon: -71.53232448244715,
    trackingNums: ['1Z54F78A0450293517', '1ZA4YSJK9T5CDJ5431'],
    attributes: [],
    completed: false,
  ),

  /// Amos Cleaners -> 43.19271089994974, -71.53161101490603
  StopData(
    id: 'oiBpvQiI3W',
    label: 'Amos Cleaners',
    addressLineOne: '267 S Main Street',
    addressLineTwo: 'Concord, NH 03301',
    hin: '7421',
    numPieces: 1,
    deliverByTime: DateTime.now(),
    distance: 2.83,
    lat: 43.19271089994974,
    lon: -71.53161101490603,
    trackingNums: ['1Z54F78A0450293517'],
    attributes: [],
    completed: false,
  ),

  /// Adult & Pediatric Dermatology, PC -> 43.192663968417534, -71.53267316961124
  StopData(
    id: 'jWTZ3u7MWa',
    label: 'Adult & Pediatric Dermatology, PC',
    addressLineOne: '2 Pillsbury Street, Suite 501',
    addressLineTwo: 'Concord, NH 03301',
    hin: '7421',
    numPieces: 1,
    deliverByTime: DateTime.now(),
    distance: 3.06,
    lat: 43.192663968417534,
    lon: -71.53267316961124,
    trackingNums: ['1Z54F78A0450293517'],
    attributes: [],
    completed: false,
  ),

  /// NH State Council of the Arts -> 43.19167057582891, -71.53298430583574
  StopData(
    id: 'RipSGFVD1v',
    label: 'NH State Council of the Arts',
    addressLineOne: '19 Pillsbury Street #1',
    addressLineTwo: 'Concord, NH 03301',
    hin: '8541',
    numPieces: 3,
    deliverByTime: DateTime.now(),
    distance: 3.29,
    lat: 43.19167057582891,
    lon: -71.53298430583574,
    trackingNums: [
      '1Z54F78A0450293517',
      '1ZMQF8XEWAQT0A9213',
      '1ZEJRT2CVVI4IF9867'
    ],
    attributes: [],
    completed: false,
  ),

  /// P&M Heating Services -> 43.188643366435514, -71.53175585420364
  StopData(
    id: 'qLkKx5cKc5',
    label: 'P & M Heating Services',
    addressLineOne: '307 S Main Street',
    addressLineTwo: 'Concord, NH 03301',
    hin: '7483',
    numPieces: 1,
    deliverByTime: DateTime.now(),
    distance: 3.35,
    lat: 43.188643366435514,
    lon: -71.53175585420364,
    trackingNums: ['1Z54F78A0450293517'],
    attributes: [],
    completed: false,
  ),

  /// Music Workshop of Concord -> 43.18655473910633, -71.53409474038851
  StopData(
    id: 'NswOIRJeVv',
    label: 'Music Workshop of Concord',
    addressLineOne: '64 Dunklee Street',
    addressLineTwo: 'Concord, NH 03301',
    hin: '7397',
    numPieces: 1,
    deliverByTime: DateTime.now(),
    distance: 3.65,
    lat: 43.18655473910633,
    lon: -71.53409474038851,
    trackingNums: ['1Z54F78A0450293517'],
    attributes: [],
    completed: false,
  ),

  /// Amsden H&H Sons Surveyors -> 43.18554951279963, -71.53334640412828
  StopData(
    id: 'XHNuXYLMdw',
    label: 'Amsden H & H Sons Surveyors',
    addressLineOne: '5 Wilfred Avenue A',
    addressLineTwo: 'Concord, NH 03301',
    hin: '7386',
    numPieces: 1,
    deliverByTime: DateTime.now(),
    distance: 3.65,
    lat: 43.18554951279963,
    lon: -71.53334640412828,
    trackingNums: ['1Z54F78A0450293517'],
    attributes: [],
    completed: false,
  ),
];

class SampleDataNotifier extends StateNotifier<List<StopData>> {
  SampleDataNotifier() : super(_sampleData);

  void updateStopData(StopData updatedData) {
    var current = state.toList();
    current.removeWhere((d) => d.id == updatedData.id);
    current.add(updatedData);
    current.sort((a, b) => a.distance.compareTo(b.distance));
    state = current;
  }
}

/// Global provider for sample data.
final sampleDataProvider =
    StateNotifierProvider<SampleDataNotifier, List<StopData>>(
        (_) => SampleDataNotifier());
