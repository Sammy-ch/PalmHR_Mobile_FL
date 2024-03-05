import 'package:apex_time_sync_flutter/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return MaterialApp.router(
      theme: FlexThemeData.light(scheme: FlexScheme.mandyRed,useMaterial3: true),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.yellowM3),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
    );
  }
}
