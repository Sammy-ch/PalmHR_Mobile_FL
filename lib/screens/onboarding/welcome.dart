import 'package:flutter/material.dart';
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
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode( Colors.black.withOpacity(0.8), BlendMode.darken),
              image: AssetImage("assets/skyscraper2.jpg"),
              fit: BoxFit.cover,
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                    width:double.infinity,
                    height: 60.0,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.green.shade400)
                          ),
                            onPressed: (){
                              context.goNamed("/home");
                            },
                            child: Text("Get Started",style: GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),
                            )
                        )
                    )
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
