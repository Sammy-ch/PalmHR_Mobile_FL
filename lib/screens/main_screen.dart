import 'package:apex_time_sync_flutter/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class mainScreen extends StatelessWidget {
  const mainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  AutoTabsRouter(routes: const [
      HomeRoute(),
      AnalyticRoute(),
      SettingRoute(),
    ],
      builder: (context,child) {
      final tabsRouter = AutoTabsRouter.of(context);
      return Scaffold(
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: (value) {
              tabsRouter.setActiveIndex(value);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.stacked_bar_chart),
                label: "Analytics"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings"
            )
          ],
        ) ,
      );
      },
    );
  }
}
