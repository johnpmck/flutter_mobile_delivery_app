import 'package:flutter/material.dart';
import 'package:flutter_mobile_delivery_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../common/stop_data.dart';

/// Widget for displaying individual StopData.
class StopDetailsTile extends ConsumerWidget {
  StopDetailsTile({
    Key? key,
    required this.stopData,
    required this.tileIndex,
    this.elevated = false,
  }) : super(key: key);

  final StopData stopData;
  final int tileIndex;
  final bool elevated;

  final GlobalKey _key = GlobalKey();

  static const _addressTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          deliveryDetailsRoute,
          arguments: tileIndex,
        );
      },
      child: Slidable(
        key: _key,
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onError,
              label: 'Non Deliver',
              onPressed: (_) {},
            ),
          ],
        ),
        child: Card(
          elevation: elevated ? 2.0 : 0,
          margin: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 96.0,
                width: 4.0,
                color: Colors.teal,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.local_shipping),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            stopData.addressLineOne.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: _addressTextStyle,
                          ),
                          Text(
                            stopData.addressLineTwo.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: _addressTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.home_work,
                          size: 18.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /// Fill remaining horizontal sapce in Row.
              Expanded(child: Container()),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        '${stopData.hin} - ${stopData.numPieces}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Icon(Icons.inventory_2_outlined),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Text('00:00 - 23:59'),
                      Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Icon(Icons.schedule),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text('${stopData.distance} mi'),
                      const Icon(Icons.place),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.drag_indicator),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
