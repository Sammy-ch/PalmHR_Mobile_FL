// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:apex_time_sync_flutter/screens/analytics.dart' as _i1;
import 'package:apex_time_sync_flutter/screens/home.dart' as _i2;
import 'package:apex_time_sync_flutter/screens/settings.dart' as _i3;
import 'package:auto_route/auto_route.dart' as _i4;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    AnalyticRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AnalyticScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    SettingRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SettingScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AnalyticScreen]
class AnalyticRoute extends _i4.PageRouteInfo<void> {
  const AnalyticRoute({List<_i4.PageRouteInfo>? children})
      : super(
          AnalyticRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnalyticRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SettingScreen]
class SettingRoute extends _i4.PageRouteInfo<void> {
  const SettingRoute({List<_i4.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
