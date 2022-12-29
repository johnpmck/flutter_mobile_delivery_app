import 'package:flutter/material.dart';

/// A Mock loading dialog to simulate making a network request. This would be shown when a user is completing a delivery/stop.
class CompleteStopDialog extends StatelessWidget {
  const CompleteStopDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
          child: Center(child: Text('Confirming delivery...')),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
          child: Center(child: CircularProgressIndicator.adaptive()),
        ),
      ],
    );
  }
}
