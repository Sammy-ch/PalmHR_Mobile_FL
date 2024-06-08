import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:PALMHR_MOBILE/routes/app_router.gr.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: BottomNavigationBar(
              unselectedItemColor: Colors.white,
              elevation: 15.0,
              backgroundColor: Colors.black87,
              currentIndex: tabsRouter.activeIndex,
              onTap: (value) {
                  tabsRouter.setActiveIndex(value);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_max_outlined),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.analytics_outlined),
                    label: "Analytics"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: "Settings"
                )
              ],
            ),
          ),
        ) ,
      );
      },
    );
  }
}
