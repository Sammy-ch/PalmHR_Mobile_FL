import 'package:PALMHR_MOBILE/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modular_ui/modular_ui.dart';
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Image.asset("assets/logo.png",scale: 15),
            Gap(40),
            Text("Log in to your \n Account",style: GoogleFonts.notoSans(fontSize: 30.0,color: Colors.white,fontWeight: FontWeight.bold)),
              Text("Enter your Email and Password to login",style: GoogleFonts.notoSans(fontSize: 15.0,color: Colors.grey,fontWeight: FontWeight.w400)),
              Gap(40),
              loginForm()
            ],),
        ),
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



  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration:  InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Colors.white)
                ),
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.black,
                  focusColor: Colors.green
              ),
            ),
            const Gap(30),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration:  InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                  focusColor: Colors.green
              ),
            ),
            Gap(50),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),

              child: SizedBox(
                width: double.infinity,
                  height: 60.0,
                  child: ElevatedButton(
                style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green.shade400)
                ),
                      onPressed: (){}, child: Text("Log In",style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),))),
            )
          ],
        )
    );
  }
}
