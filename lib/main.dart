import 'dart:convert';

import 'package:PALMHR_MOBILE/screens/home/home.dart';
import 'package:PALMHR_MOBILE/screens/leaveRequest/leaveRequest.dart';
import 'package:PALMHR_MOBILE/screens/onboarding/createAccount.dart';
import 'package:PALMHR_MOBILE/screens/onboarding/login.dart';
import 'package:PALMHR_MOBILE/screens/onboarding/register.dart';
import 'package:PALMHR_MOBILE/screens/onboarding/welcome.dart';
import 'package:PALMHR_MOBILE/screens/performance/analytics.dart';
import 'package:PALMHR_MOBILE/screens/privacyPolicy.dart';
import 'package:PALMHR_MOBILE/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:PALMHR_MOBILE/env/env.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter/services.dart';
import 'package:kinde_flutter_sdk/kinde_flutter_sdk.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import 'themeProvider.dart';



Future<void> initEncryptedHive() async {
    const FlutterSecureStorage secureStorage =  FlutterSecureStorage();
  var containsEncryptionKey = await secureStorage.containsKey(key: 'encryptionKey');
  if (!containsEncryptionKey) {
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: 'encryptionKey', value: base64UrlEncode(key));
  }

}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initEncryptedHive();
  await KindeFlutterSDK.initializeSDK(
    authDomain: Env.kindeAuthDomain,
    authClientId: Env.kindeAuthClientId,
    loginRedirectUri: Env.kindeLoginRedirectUri,
    logoutRedirectUri: Env.kindeLogoutRedirectUri,
    audience: Env.kindeAudience, //optional
    scopes: ["email","profile","offline","openid"] // optional
);

  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabase_anon);


  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(),
    child: const MainApp(),
  ));
}


final sdk = KindeFlutterSDK.instance;
final supabase = Supabase.instance.client;
final userId = Supabase.instance.client.auth.currentSession!.user.id;




class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          theme: FlexThemeData.light(scheme: FlexScheme.green),
          darkTheme: FlexThemeData.dark(scheme: FlexScheme.green),
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          routerConfig: _goRouter,
        );
      },
    );
  }
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter _goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/welcome",
  routes: [
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
    GoRoute(
      path: "/newLeaveRequest",
      name: "/newLeaveRequest",
      builder: (context, state) => const NewLeaveRequest(),
    ),
    GoRoute(
      path: "/privacyPolicy",
      name: "/privacyPolicy",
      builder: (context, state) => const Privacypolicy(),
    ),
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          final isDarkMode = Theme.of(context).brightness == Brightness.dark;
          final bottomNavColor =
              isDarkMode ? Colors.black : Colors.grey.shade200;
          return Scaffold(
            extendBody: true,
            bottomNavigationBar: DotNavigationBar(
              selectedItemColor: Colors.green.shade800,
              backgroundColor: bottomNavColor,
              currentIndex: _getSelectedIndex(state.matchedLocation),
              onTap: (index) {
                _onItemTapped(context, index);
              },
              items: <DotNavigationBarItem>[
                DotNavigationBarItem(
                  icon: const FaIcon(
                    UniconsLine.home_alt,
                    size: 25,
                  ),
                ),
                DotNavigationBarItem(
                  icon: const Icon(
                    UniconsLine.analytics,
                    size: 25,
                  ),
                ),
                DotNavigationBarItem(
                  icon: const Icon(
                    UniconsLine.user_times,
                    size: 25,
                  ),
                ),
                DotNavigationBarItem(
                  icon: const Icon(
                    UniconsLine.setting,
                    size: 25,
                  ),
                ),
              ],
            ),
            body: child,
          );
        },
        routes: [
          GoRoute(
            path: '/home',
            name: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/analytics',
            name: '/analytics',
            builder: (context, state) => const AnalyticScreen(),
          ),
          GoRoute(
            path: '/leave',
            name: '/leave',
            builder: (context, state) => const LeaveRequestScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingScreen(),
          ),
        ]),
  ],
  redirect: (context, state) async {
   final isAuthenticated = await sdk.isAuthenticate();

    if (state.matchedLocation == '/welcome' ||
        state.matchedLocation == '/register') {
      return null;
    }

    if (!isAuthenticated) {
      return '/login';
    }
    if (isAuthenticated) {
      return _checkProfileExists(context).then((exists) {
        if (exists) {
          if (state.matchedLocation == '/analytics') {
            return null;
          }
          if (state.matchedLocation == '/leave') {
            return null;
          }

          if (state.matchedLocation == "/newLeaveRequest") {
            return null;
          }

          if(state.matchedLocation == "/privacyPolicy") {
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
  if (location.startsWith("/leave")) {
    return 2;
  }
  if (location.startsWith("/settings")) {
    return 3;
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
      context.go("/leave");
      break;
    case 3:
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


void updateSystemUIOverlayStyle(ThemeMode themeMode) {
  if (themeMode == ThemeMode.dark) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
  } else {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }
}


Future < Box > hiveEncryptedBox() async {
    // Hive Encrypted Box Added
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String ? key = await secureStorage.read(key: 'encryptionKey');
    var encryptionKey = base64Url.decode(key!);
    var box = await Hive.openBox('myBox', encryptionCipher: HiveAesCipher(encryptionKey));
    return box;
}
Future < String > returnAccessToken() async {
    final box = await hiveEncryptedBox();
    var token = box.get('token', defaultValue: '');
    if (token == '') {
        return await getNewToken();
    } else if (token != null) {
        bool hasExpired = JwtDecoder.isExpired(token);
        if (hasExpired) {
            return await getNewToken();
        }
        return token;
    } else {
        return getNewToken();
    }
}
Future < String > getNewToken() async {
    String ? token = await sdk.getToken();
    if (token == null) return 'Refresh Token Expired'; // Redirect user to the login page
    var box = await hiveEncryptedBox();
    await box.put('token', token);
    return token;
}