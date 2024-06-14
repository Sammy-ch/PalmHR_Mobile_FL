import 'package:PALMHR_MOBILE/routes/auth_guard.dart';
import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: WelcomeRoute.page,initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: MainRoute.page, children: [
          AutoRoute(page: HomeRoute.page, guards: [AuthGuard()]),
          AutoRoute(page: AnalyticRoute.page, guards: [AuthGuard()]),
          AutoRoute(page: SettingRoute.page, guards: [AuthGuard()]),
        ]),
      ];
}
