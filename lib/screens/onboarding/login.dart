import 'package:PALMHR_MOBILE/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim()
      );

      if (mounted) {
       context.goNamed("/home");

        _emailController.clear();
      }
    } on AuthException catch (error) {
      if (mounted) {
       ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text("Unexpected error occurred"))
       );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Unexpected error occurred"))
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
              child: MUISignInCard(
                borderColor: Colors.grey.shade800,
                emailController: _emailController,
                passwordController: _passwordController,
                onSignInPressed: () async {
                  _signIn();
                },
                onRegisterNow: () async {
                  context.go('/register');
                },
              ),
            ),
      ),

    );
  }
}
