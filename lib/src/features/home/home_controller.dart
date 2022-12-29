import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeTabProvider = StateProvider<int>((_) => 0);
final employeeIdProvider = StateProvider<String?>((_) => null);
