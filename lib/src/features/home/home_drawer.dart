import 'package:flutter/material.dart';
import 'package:flutter_mobile_delivery_app/src/features/home/home_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  static const _options = <MDAOption>[
    MDAOption(label: 'Activities', icon: Icons.list),
    MDAOption(label: 'Employee', icon: Icons.badge),
    MDAOption(label: 'Timecard', icon: Icons.date_range),
    MDAOption(label: 'Trips', icon: Icons.local_shipping),
    MDAOption(label: 'Messages', icon: Icons.message),
    MDAOption(label: 'Punch out', icon: Icons.exit_to_app),
    MDAOption(label: 'About', icon: Icons.info_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.teal),
            padding: const EdgeInsets.fromLTRB(16, kToolbarHeight, 16, 16),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 16,
              children: [
                const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 62,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'James Holden',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 0.7,
                      ),
                    ),
                    Consumer(builder: (_, ref, child) {
                      return Text(
                        ref.watch(employeeIdProvider) ?? '7120263',
                        style: const TextStyle(color: Colors.white),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
          GridView.builder(
            primary: false,
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 7,
            itemBuilder: (_, idx) => Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              color: Colors.grey.shade200,
              child: Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: [
                  Icon(
                    _options[idx].icon,
                    size: 48,
                  ),
                  Text(
                    _options[idx].label,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MDAOption {
  const MDAOption({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
}
