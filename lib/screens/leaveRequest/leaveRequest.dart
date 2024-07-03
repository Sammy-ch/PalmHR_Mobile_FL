import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: 
      Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            LeaveHeader(),
            Gap(50),
            LeaveActivity()
          ],
        ),
      )
      ),
    );
  }
}

class LeaveHeader extends StatelessWidget {
  const LeaveHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Leave Request",style: GoogleFonts.dmSans(
                fontSize: 25, fontWeight: FontWeight.bold)),
        IconButton(onPressed: (){}, icon: const Icon(Icons.add_circle_outlined,size: 40,color: Colors.green) )
                ],
    );
  }
}


class LeaveActivity extends StatefulWidget {
  const LeaveActivity({super.key});

  @override
  State<LeaveActivity> createState() => _LeaveActivityState();
}

class _LeaveActivityState extends State<LeaveActivity> {
  @override
  Widget build(BuildContext context) {
        final isDarkMode =  Theme.of(context).brightness == Brightness.dark;
    final cardBackgroundColor = isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200;
    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(5)
      ),
      child:  Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Half Day Application",style: GoogleFonts.dmSans(color: Colors.grey.shade600,fontSize: 18)),
                Text("Mon, 28 Nov",style: GoogleFonts.dmSans(fontSize: 20,fontWeight: FontWeight.bold)),
                Text("Sick",style: GoogleFonts.dmSans(color: Colors.orange,fontSize: 15))
              ],
            ),            
            Container(
              decoration: BoxDecoration(color: Colors.green.shade300, borderRadius: BorderRadius.circular(5)),
              child: 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Approved",style: GoogleFonts.dmMono(color: Colors.green.shade800,fontWeight: FontWeight.w700),),
                ),
              
            )
          ],
        ),
      ),
    );
  }
}