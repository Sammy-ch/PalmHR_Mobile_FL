import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [LeaveHeader(), Gap(50), LeaveActivity()],
        ),
      )),
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
        Text("Leave Request",
            style:
                GoogleFonts.dmSans(fontSize: 25, fontWeight: FontWeight.bold)),
        IconButton(
            onPressed: () => showBarModalBottomSheet(
                  expand: true,
                  context: context,
                  builder: (context) => const NewLeaveRequest(),
                ),
            icon: const Icon(Icons.add_circle_outlined,
                size: 40, color: Colors.green))
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardBackgroundColor =
        isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200;
    return Container(
      decoration: BoxDecoration(
          color: cardBackgroundColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Half Day Application",
                    style: GoogleFonts.dmSans(
                        color: Colors.grey.shade600, fontSize: 18)),
                Text("Mon, 28 Nov",
                    style: GoogleFonts.dmSans(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text("Sick",
                    style:
                        GoogleFonts.dmSans(color: Colors.orange, fontSize: 15))
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Approved",
                  style: GoogleFonts.dmMono(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewLeaveRequest extends StatefulWidget {
  const NewLeaveRequest({super.key});

  @override
  State<NewLeaveRequest> createState() => _NewLeaveRequestState();
}

class _NewLeaveRequestState extends State<NewLeaveRequest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Leave Request",
              style:
                  GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Gap(50),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200, width: 2.0)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Type",
                            style: GoogleFonts.dmSans(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500)),
                        Text("Casual",
                            style: GoogleFonts.dmSans(
                                fontSize: 18,
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.w600)),
                        Gap(20),
                        Text("Cause",
                            style: GoogleFonts.dmSans(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500)),
                        Text("Trip to Cannes",
                            style: GoogleFonts.dmSans(
                                fontSize: 18,
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.w600)),
                        const Gap(20),
                        Text("From",
                            style: GoogleFonts.dmSans(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500)),
                        Text("Mon, 28 Nov 2024",
                            style: GoogleFonts.dmSans(
                                fontSize: 18,
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.w600)),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
