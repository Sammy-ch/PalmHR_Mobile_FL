import 'package:PALMHR_MOBILE/main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gap/gap.dart';

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
            bottom: 200.0,
            child: Image.asset(
              "assets/skyscraper3.jpg",
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(50),
                Image.asset("assets/logo.png", scale: 7),
                const Gap(80),
                const loginForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class loginForm extends StatefulWidget {
  const loginForm({super.key});

  @override
  State<loginForm> createState() => _loginFormState();
}

class _loginFormState extends State<loginForm> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  bool _isLoading = false;

  Future<void> _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await supabase.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      if (mounted) {
        context.go('/home');
        _emailController.clear();
      }
    } on AuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message)));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Unexpected error occurred'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

 Future<void> _signUp() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await supabase.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      if (mounted) {
        context.go('/home');
        _emailController.clear();
      }
    } on AuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message)));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Unexpected error occurred'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
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
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              "Sign in to your account",
              style: GoogleFonts.notoSans(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Enter your Email and Password",
              style: GoogleFonts.notoSans(
                fontSize: 15.0,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Gap(40),
            Form(
                child: Column(
              children: <Widget>[
                TextField(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: _emailController,
                  decoration: InputDecoration(
                    isDense: true,
                    icon: const FaIcon(
                      Icons.mail_rounded,
                      size: 30,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          color: Colors.green,
                          style: BorderStyle.solid),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none),
                    labelText: "Email",
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                ),
                const Gap(30),
                TextField(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    isDense: true,
                    icon: const FaIcon(
                      Icons.lock_outline,
                      size: 30,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.green),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none),
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                ),
                const Gap(50),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.green)),
                          onPressed: () {
                            _signIn();
                          },
                          child: AutoSizeText(
                            "Login",
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                ),
                                const Gap(20),
                 ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.green)),
                          onPressed: () {
                            _signUp();
                          },
                          child: AutoSizeText(
                            "Sign Up",
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                )
              ],
            )),
                      
          ],
        ),
      ),
    );
  }
}
