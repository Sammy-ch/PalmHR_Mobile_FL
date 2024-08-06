import 'package:PALMHR_MOBILE/main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gap/gap.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/skyscraper3.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Gap(50),
                Image.asset("assets/logo.png", scale: 7),
                const Expanded(
                  child: SizedBox(),
                ), // This will take up the remaining space
                const SupabaseLogin(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SupabaseLogin extends StatefulWidget {
  const SupabaseLogin({super.key});

  @override
  State<SupabaseLogin> createState() => _SupabaseLoginState();
}

class _SupabaseLoginState extends State<SupabaseLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: SupaEmailAuth(
          redirectTo:
              kIsWeb ? null : 'io.supabase.flutterquickstart://callback',
          onSignInComplete: (response) {
            context.go("/home");
          },
          onSignUpComplete: (response) {},
          metadataFields: [
            MetaDataField(
              prefixIcon: const Icon(Icons.person),
              label: 'Username',
              key: 'username',
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter something';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
