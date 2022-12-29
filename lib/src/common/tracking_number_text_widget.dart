import 'package:flutter/material.dart';

class TrackingNumberTextWidget extends StatelessWidget {
  const TrackingNumberTextWidget({super.key, required this.trackingNumber});

  final String trackingNumber;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
      text: TextSpan(
        text: trackingNumber.substring(0, 2),
        style:
            theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
        children: [
          TextSpan(
            text: '  ${trackingNumber.substring(2, 8)}',
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: '  ${trackingNumber.substring(8, 10)}',
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: '  ${trackingNumber.substring(10, 14)}',
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: '  ${trackingNumber.substring(14, trackingNumber.length)}',
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
