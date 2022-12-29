import 'package:flutter/material.dart';
import 'package:flutter_mobile_delivery_app/main.dart';
import 'package:flutter_mobile_delivery_app/src/common/sample_data.dart';
import 'package:flutter_mobile_delivery_app/src/common/stop_data.dart';
import 'package:flutter_mobile_delivery_app/src/common/tracking_number_text_widget.dart';
import 'package:flutter_mobile_delivery_app/src/features/board/controller/board_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A condensed version of `StopDetailsTile`.
class _DeliveryInfoTile extends StatelessWidget {
  const _DeliveryInfoTile({
    super.key,
    required this.trackingNumber,
    required this.hin,
    required this.deliveryTime,
  });

  final String trackingNumber;
  final String hin;
  final DateTime deliveryTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          start: const BorderSide(color: Colors.teal, width: 6.0),
          top: BorderSide(color: theme.dividerColor, width: 1.0),
          bottom: BorderSide(color: theme.dividerColor, width: 1.0),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TrackingNumberTextWidget(trackingNumber: trackingNumber),
              Text(hin),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text('00:00 \u2013 23:59'),
              SizedBox(width: 8.0),
              Icon(Icons.schedule_outlined),
            ],
          )
        ],
      ),
    );
  }
}

/// Present this dialog to confirm that a user wants to navigate away from `ConfirmPackagesView`.
class _ConfirmLeaveDialog extends StatelessWidget {
  const _ConfirmLeaveDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        content: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
              'Are you sure you want to navigate away? All items that have been scanned will need to be scanned again.'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
        ],
      ),
    );
  }
}

/// Mock view for scanning all packages for a specific `StopData`.
class ConfirmPackagesView extends ConsumerStatefulWidget {
  const ConfirmPackagesView({super.key, required this.itineraryIndex});

  final int itineraryIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConfirmPackagesViewState();
}

class _ConfirmPackagesViewState extends ConsumerState<ConfirmPackagesView> {
  late final int _itineraryIndex;
  late final StopData _stopData;

  @override
  void initState() {
    super.initState();
    _itineraryIndex = widget.itineraryIndex;
    _stopData = ref.read(sampleDataProvider)[_itineraryIndex];
  }

  Future<bool> _confirmExit() async {
    final leave = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const _ConfirmLeaveDialog(),
    );

    if (leave != null && leave is bool) {
      if (leave) {
        ref.read(confirmedTrackingNumbersProvider.notifier).state = [];
        return true;
      } else {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final selectedTrackingNums = ref.watch(selectedTrackingNumbersProvider);

    return WillPopScope(
      onWillPop: () async => await _confirmExit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0,
          title: const Text('Delivery'),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.local_shipping,
                    size: 30.0,
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _stopData.addressLineOne,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        _stopData.addressLineTwo,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text('${_stopData.numPieces}'),
                      const SizedBox(width: 8.0),
                      const Icon(Icons.inventory_2_outlined),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: selectedTrackingNums.isEmpty
                  ? Center(
                      child: Text('All items have been scanned!',
                          style: theme.textTheme.titleLarge))
                  : ListView(
                      shrinkWrap: true,
                      children: selectedTrackingNums
                          .map((e) => _DeliveryInfoTile(
                                trackingNumber: e,
                                hin: _stopData.hin,
                                deliveryTime: _stopData.deliverByTime,
                              ))
                          .toList(),
                    ),
            ),
            ExpansionTile(
              leading: const Icon(Icons.check, color: Colors.green),
              title: Text(
                  'Confirmed: ${ref.watch(confirmedTrackingNumbersProvider).length}'),
              children: ref
                  .watch(confirmedTrackingNumbersProvider)
                  .map(
                    (e) => ListTile(
                      title: TrackingNumberTextWidget(trackingNumber: e),
                    ),
                  )
                  .toList(),
            ),
            Container(
              decoration: BoxDecoration(
                border: BorderDirectional(
                  top: BorderSide(
                    color: theme.dividerColor,
                    width: 1.0,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final exit = await _confirmExit();
                        if (exit && mounted) Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: theme.colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: Text(
                        'Cancel',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: selectedTrackingNums.isEmpty
                          ? () {
                              // confirm/complete
                              Navigator.of(context).pushNamed(
                                  releaseLocationRoute,
                                  arguments: _itineraryIndex);
                            }
                          : () {
                              // scan
                              List<String> allNums = ref
                                  .read(selectedTrackingNumbersProvider)
                                  .toList();

                              // add to confirmed tracking nums.
                              List<String> confirmed =
                                  ref.read(confirmedTrackingNumbersProvider);
                              confirmed.add(allNums.first);
                              ref
                                  .read(
                                      confirmedTrackingNumbersProvider.notifier)
                                  .state = confirmed;
                              allNums.remove(allNums.first);
                              ref
                                  .read(
                                      selectedTrackingNumbersProvider.notifier)
                                  .state = allNums;
                            },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.grey.shade200,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: selectedTrackingNums.isEmpty
                          ? Text(
                              'Continue',
                              style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.onPrimary),
                            )
                          : const Icon(
                              Icons.qr_code_outlined,
                              size: 20.0,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
