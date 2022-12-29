import 'package:flutter/material.dart';
import 'package:flutter_mobile_delivery_app/src/features/auth/login_view.dart';
import 'package:flutter_mobile_delivery_app/src/features/board/view/confirm_packages_view.dart';
import 'package:flutter_mobile_delivery_app/src/features/board/view/stop_details_view.dart';
import 'package:flutter_mobile_delivery_app/src/features/board/view/release_location_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/features/home/home_view.dart';

const loginRoute = '/login';
const homeRoute = '/';
const deliveryDetailsRoute = '/deliveryDetails';
const confirmDeliveryRoute = '/confirmDelviery';
const releaseLocationRoute = '/releaseLocation';
const unknownRoute = '/notfound';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case loginRoute:
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const LoginView(),
            );
          case homeRoute:
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const HomeView(),
            );
          case deliveryDetailsRoute:
            final args = settings.arguments;
            if (args == null || args is! int) {
              throw 'Must pass type `int` to this view.';
            }
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => StopDetailsView(itineraryIndex: args),
            );
          case confirmDeliveryRoute:
            final args = settings.arguments;
            if (args == null || args is! int) {
              throw 'Must pass type `int` to this view.';
            }
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => ConfirmPackagesView(itineraryIndex: args),
            );
          case releaseLocationRoute:
            final args = settings.arguments;
            if (args == null || args is! int) {
              throw 'Must pass type `int` to this view.';
            }
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => ReleaseLocationView(itineraryIndex: args),
            );
          default:
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const UnknownRoute(),
            );
        }
      },
    );
  }
}

class UnknownRoute extends StatelessWidget {
  const UnknownRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Uh oh! Route not found...'));
  }
}
