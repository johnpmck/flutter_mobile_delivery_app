import 'package:flutter/material.dart';
import 'package:flutter_mobile_delivery_app/main.dart';
import 'package:flutter_mobile_delivery_app/src/common/sample_data.dart';
import 'package:flutter_mobile_delivery_app/src/common/stop_data.dart';
import 'package:flutter_mobile_delivery_app/src/features/board/view/complete_stop_dialog.dart';
import 'package:flutter_mobile_delivery_app/src/features/board/view/stop_details_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signature/signature.dart';

/// View for selecting the appropriate release location for the package(s).
///
/// In addition, this view provides functionality to "complete" a stop.
class ReleaseLocationView extends ConsumerStatefulWidget {
  const ReleaseLocationView({super.key, required this.itineraryIndex});

  final int itineraryIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReleaseLocationViewState();
}

class _ReleaseLocationViewState extends ConsumerState<ReleaseLocationView> {
  late final SignatureController _sigController;
  late final int _itineraryIndex;
  bool _showClear = false;
  bool _isLandscape = false;

  @override
  void initState() {
    super.initState();
    _sigController = SignatureController(
      penStrokeWidth: 4.0,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
    _sigController.addListener(
        () => setState(() => _showClear = _sigController.isNotEmpty));
    _itineraryIndex = widget.itineraryIndex;
  }

  void _chooseReleaseLocation(String location, StopData stopData) {
    setState(() {
      stopData.releaseLocation = location;
    });
  }

  void _clearCanvas() {
    setState(() {
      _sigController.clear();
    });
  }

  Future<void> _completeStop(StopData stopData) async {
    // Complete this stop.
    stopData.completed = true;
    ref.read(sampleDataProvider.notifier).updateStopData(stopData);

    // Show a sample loading dialog.
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CompleteStopDialog(),
    );

    // Pause for effect...
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      // Pop back to Home/BoardView.
      Navigator.of(context)
          .popUntil((route) => route.settings.name == homeRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dh = MediaQuery.of(context).size.height;
    final dw = MediaQuery.of(context).size.width;
    final stopData = ref.watch(sampleDataProvider)[_itineraryIndex];

    final signatureRequired =
        stopData.attributes.contains('signature_required');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Release Location'),
        elevation: 0,
      ),
      body: Column(
        children: [
          StopDetailsTile(stopData: stopData, tileIndex: _itineraryIndex),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Text(
              signatureRequired
                  ? 'A signature is required to release the package(s)'
                  : 'Select the appropriate package release location',
              style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: theme.textTheme.titleLarge?.fontWeight),
            ),
          ),
          const Divider(thickness: 1.0, height: 1.0),
          Expanded(
            child: signatureRequired
                ? Stack(
                    children: [
                      Positioned(
                        bottom: _isLandscape ? dh * 0.25 : dh * 0.2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.edit_rounded,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 2.0),
                              Container(
                                height: 2.0,
                                width: dw - 32.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Signature(
                        controller: _sigController,
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  )
                : ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        onTap: () =>
                            _chooseReleaseLocation('Front door', stopData),
                        leading: const Icon(Icons.door_front_door_outlined),
                        title: const Text('Front door'),
                        trailing: const Icon(Icons.navigate_next),
                        selected: stopData.releaseLocation == 'Front door',
                      ),
                      const Divider(thickness: 1.0, height: 1.0),
                      ListTile(
                        onTap: () =>
                            _chooseReleaseLocation('Back door', stopData),
                        leading: const Icon(Icons.door_back_door_outlined),
                        title: const Text('Back door'),
                        trailing: const Icon(Icons.navigate_next),
                        selected: stopData.releaseLocation == 'Back door',
                      ),
                      const Divider(thickness: 1.0, height: 1.0),
                      ListTile(
                        onTap: () =>
                            _chooseReleaseLocation('Side door', stopData),
                        leading: const Icon(Icons.meeting_room_outlined),
                        title: const Text('Side door'),
                        trailing: const Icon(Icons.navigate_next),
                        selected: stopData.releaseLocation == 'Side door',
                      ),
                      const Divider(thickness: 1.0, height: 1.0),
                      ListTile(
                        onTap: () => _chooseReleaseLocation('Garage', stopData),
                        leading: const Icon(Icons.garage_outlined),
                        title: const Text('Garage'),
                        trailing: const Icon(Icons.navigate_next),
                        selected: stopData.releaseLocation == 'Garage',
                      ),
                      const Divider(thickness: 1.0, height: 1.0),
                      ListTile(
                        onTap: () => _chooseReleaseLocation('Porch', stopData),
                        leading: const Icon(Icons.deck_rounded),
                        title: const Text('Porch'),
                        trailing: const Icon(Icons.navigate_next),
                        selected: stopData.releaseLocation == 'Porch',
                      ),
                      const Divider(thickness: 1.0, height: 1.0),
                      ListTile(
                        onTap: () => _chooseReleaseLocation('Other', stopData),
                        leading: const SizedBox.shrink(),
                        title: const Text('Other'),
                        trailing: const Icon(Icons.navigate_next),
                        selected: stopData.releaseLocation == 'Other',
                      ),
                      const Divider(thickness: 1.0, height: 1.0),
                    ],
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: signatureRequired
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.center,
              children: [
                if (signatureRequired)
                  TextButton(
                    onPressed: _showClear ? _clearCanvas : null,
                    child: const Text('Clear'),
                  ),
                ElevatedButton(
                  onPressed: signatureRequired && _showClear
                      ? () => _completeStop(stopData)
                      : signatureRequired && !_showClear
                          ? null
                          : stopData.releaseLocation == null
                              ? null
                              : () => _completeStop(stopData),
                  child: const Text('Complete'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
