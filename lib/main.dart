import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:PALMHR_MOBILE/routes/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://ltgepwdhemwwgjoftqlm.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx0Z2Vwd2RoZW13d2dqb2Z0cWxtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI1NzkwNjUsImV4cCI6MjAyODE1NTA2NX0.iQrEzAwwp5Q73q0pUd-TORKU-xFd5UPGssX0oWcWXVc",
  );

  runApp(const MainApp());
}

final supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return MaterialApp.router(
      theme: FlexThemeData.light(scheme: FlexScheme.amber),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
    );
  }
}
