import 'package:flutter/material.dart';
import 'package:flutter_mobile_delivery_app/src/common/sample_data.dart';
import 'package:flutter_mobile_delivery_app/src/features/board/view/board_view.dart';
import 'package:flutter_mobile_delivery_app/src/features/home/home_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../map/map_view.dart';
import '../summary/summary_view.dart';
import 'home_drawer.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final _tabs = ['Itinerary', 'Map', 'Summary'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _changeTab(int tabIndex) {
    ref.read(homeTabProvider.notifier).state = tabIndex;
    _tabController.animateTo(
      tabIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        final tabIndex = ref.read(homeTabProvider);
        if (tabIndex != 0) {
          _changeTab(0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        drawer: const HomeDrawer(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: Colors.teal,
                  title: Text(_tabs[ref.watch(homeTabProvider)]),
                  pinned: true,
                  forceElevated: innerBoxIsScrolled,
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.help),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                  bottom: TabBar(
                    controller: _tabController,
                    indicatorColor: theme.colorScheme.onPrimary,
                    onTap: (value) => _changeTab(value),
                    tabs: [
                      Tab(
                        child: Row(
                          children: [
                            const Icon(Icons.list_rounded),
                            const SizedBox(width: 8.0),
                            Text(
                                '(${ref.watch(sampleDataProvider).where((d) => d.completed == false).toList().length})'),
                          ],
                        ),
                      ),
                      const Tab(child: Icon(Icons.map_rounded)),
                      const Tab(child: Icon(Icons.summarize_rounded)),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              BoardView(name: 'Itinerary'),
              MapView(),
              SummaryView(name: 'Summary'),
            ],
          ),
        ),
      ),
    );
  }
}
