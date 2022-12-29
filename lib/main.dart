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
      title: 'Mobile Delivery App',
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

/// login -> https://user-images.githubusercontent.com/101197720/210018415-a372c567-784e-4437-b3b9-5a90b88cb29b.jpg
/// 
/// board -> https://user-images.githubusercontent.com/101197720/210018464-c6bb3910-3a13-499a-a121-d6093c587a56.jpg
/// 
/// stop details -> https://user-images.githubusercontent.com/101197720/210018519-e99b25b7-403b-4ce3-8a23-6949632023b0.jpg
/// 
/// scan -> https://user-images.githubusercontent.com/101197720/210018479-65d19f83-b44b-44fe-9265-c27e5044aa42.jpg
/// 
/// map -> https://user-images.githubusercontent.com/101197720/210018685-f5b49e6b-2874-4ecd-996f-0bf5651008c7.jpg
/// 
/// summary -> https://user-images.githubusercontent.com/101197720/210018711-cf50ce90-60de-4055-99bd-fb20a204c1a5.jpg
