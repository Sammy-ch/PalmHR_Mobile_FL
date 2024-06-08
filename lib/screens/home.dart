import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';


@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              HeaderComponent()
            ],
          ),
        ),
      ),
    );
  }
}



class HeaderComponent extends StatefulWidget {
  const HeaderComponent({super.key});

  @override
  State<HeaderComponent> createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  @override
  Widget build(BuildContext context) {
    return  Row(
          children: [
             Row(
                children: [
                const GFAvatar(
                    backgroundColor: Colors.black26,
                  ),
                  const SizedBox(width: 10),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                   Text('Good Morning,',style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.normal)),
                    Text('Allan Cherubin',style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.normal)),

                    ],
                  )
                ],
              ),
             const Spacer(flex: 1),
         Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 2), // Outline color
                    borderRadius: BorderRadius.circular(8), // Optional: to make the border rounded
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.notifications_active_rounded
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 2), // Outline color
                  borderRadius: BorderRadius.circular(8), // Optional: to make the border rounded
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.logout
                  ),
                ),
              )
            ],
)
          ],
      );
  }
}
