import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode( Colors.black.withOpacity(0.2), BlendMode.darken),
              image: const AssetImage("assets/skyscraper4.jpg"),
              fit: BoxFit.cover,
            )
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              SizedBox(
                  child:  Image.asset("assets/logo.png", scale: 7),
                ),
                WelcomeButtons(context),
              ],
            ),
          )
        ),
      ),
    );
  }

  Column WelcomeButtons(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            
          const Gap(15),
            SizedBox(
                width:double.infinity,
                height: 70.0,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.green.shade400)
                        ),
                        onPressed: (){
                          context.goNamed("/register");
                        },
                        child: Text("Get Started",style: GoogleFonts.inter(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.white),
                        )
                    )
                )
            )
          ],
        );
  }
}
