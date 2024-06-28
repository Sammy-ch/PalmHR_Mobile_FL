import 'package:PALMHR_MOBILE/screens/home/home.dart';
import 'package:PALMHR_MOBILE/screens/onboarding/createAccount.dart';
import 'package:PALMHR_MOBILE/screens/onboarding/login.dart';
import 'package:PALMHR_MOBILE/screens/onboarding/register.dart';
import 'package:PALMHR_MOBILE/screens/onboarding/welcome.dart';
import 'package:PALMHR_MOBILE/screens/performance/analytics.dart';
import 'package:PALMHR_MOBILE/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:go_router/go_router.dart';
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
final userId = Supabase.instance.client.auth.currentSession!.user.id;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: FlexThemeData.dark(scheme: FlexScheme.amber),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: _goRouter,
    );
  }
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter _goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/login",
  routes: [
     GoRoute(
            path: '/home',
            name: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
    GoRoute(
      path: '/welcome',
      name: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: "/createAccount",
      name: "/createAccount",
      builder: (context, state) => const CreateAccount(),
    ),
    // ShellRoute(
    //     navigatorKey: _shellNavigatorKey,
    //     builder: (context, state, child) {
    //       return Scaffold(
    //         bottomNavigationBar: BottomNavigationBar(
    //           backgroundColor: Colors.black,
    //           currentIndex: _getSelectedIndex(state.matchedLocation),
    //           onTap: (index) {
    //             _onItemTapped(context, index);
    //           },
    //           items: const [
    //             BottomNavigationBarItem(
    //               icon: Icon(Icons.home_max_rounded),
    //               label: 'Home',
    //             ),
    //             BottomNavigationBarItem(
    //               icon: Icon(Icons.bar_chart_rounded),
    //               label: 'analytics',
    //             ),
    //             BottomNavigationBarItem(
    //               icon: Icon(Icons.settings),
    //               label: 'settings',
    //             ),
    //           ],
    //         ),
    //         body: child,
    //       );
    //     },
    //     routes: [
    //       GoRoute(
    //         path: '/home',
    //         name: '/home',
    //         builder: (context, state) => const HomeScreen(),
    //       ),
    //       GoRoute(
    //         path: '/analytics',
    //         name: '/analytics',
    //         builder: (context, state) => const AnalyticScreen(),
    //       ),
    //       GoRoute(
    //         path: '/settings',
    //         name: 'settings',
    //         builder: (context, state) => const SettingScreen(),
    //       ),
    //     ]),
  ],
  redirect: (context, state) {
    final session = Supabase.instance.client.auth.currentSession;
    final isLoggedIn = session != null;

    if (state.matchedLocation == '/welcome') {
      return null;
    }

    if (state.matchedLocation == '/register') {
      return null;
    }

    if (!isLoggedIn) {
      return '/login';
    }
    if (isLoggedIn) {
      return _checkProfileExists(context).then((exists) {
        if (exists) {
          if (state.matchedLocation == '/analytics') {
            return null;
          }

          if (state.matchedLocation == '/settings') {
            return null;
          }
          return '/home';
        } else {
          return '/createAccount';
        }
      });
    }
    return null;
  },
);

int _getSelectedIndex(String location) {
  if (location.startsWith("/home")) {
    return 0;
  }
  if (location.startsWith("/analytics")) {
    return 1;
  }
  if (location.startsWith("/settings")) {
    return 2;
  }
  return 0;
}

void _onItemTapped(BuildContext context, int index) {
  switch (index) {
    case 0:
      context.go("/home");
      break;
    case 1:
      context.go("/analytics");
      break;
    case 2:
      context.go("/settings");
      break;
  }
}

Future<bool> _checkProfileExists(BuildContext context) async {
  try {
    final data = await Supabase.instance.client
        .from("EmployeeProfile")
        .select()
        .eq("profile_id", userId)
        .single();
    return true;
  } catch (error) {
    // Handle error or log it
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error checking profile existence: $error"),
      ),
    );
    return false;
  }
}
