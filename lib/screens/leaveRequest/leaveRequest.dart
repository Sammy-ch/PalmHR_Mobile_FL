import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:intl/intl.dart';

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
            onPressed: () => context.go('/newLeaveRequest'),
            icon: const Icon(UniconsLine.file_plus_alt,
                size: 30, color: Colors.green))
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
  DateTime? startDate;
  DateTime? endDate;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final ModalBackgroundColor =
        isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: ModalBackgroundColor),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.go("/leave");
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    Gap(10),
                    Text(
                      "New Leave",
                      style: GoogleFonts.inter(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                Container(
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.grey.shade800
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                            Text("Holiday",
                                style: GoogleFonts.dmSans(
                                    fontSize: 17, fontWeight: FontWeight.w600)),
                            Gap(20),
                            Text("Cause",
                                style: GoogleFonts.dmSans(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500)),
                            Gap(5),
                            const TextField(
                              maxLines: 3,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Write your reason',
                              ),
                            ),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text("From",
                                        style: GoogleFonts.dmSans(
                                            fontSize: 15,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500)),
                                    Text(
                                        startDate != null
                                            ? DateFormat('MMM d, y')
                                                .format(startDate!)
                                            : "Not selected",
                                        style: GoogleFonts.dmSans(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("to",
                                        style: GoogleFonts.dmSans(
                                            fontSize: 15,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500)),
                                    Text(
                                      endDate != null
                                          ? DateFormat('MMM d, y')
                                              .format(endDate!)
                                          : "Not selected",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Gap(30),
                            Center(
                              child: SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      padding: WidgetStateProperty.all(
                                          EdgeInsets.all(5)),
                                      backgroundColor:
                                          WidgetStateProperty.all(Colors.green),
                                      shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)))),
                                  onPressed: () {
                                    showCustomDateRangePicker(
                                      context,
                                      dismissible: true,
                                      minimumDate: DateTime.now()
                                          .subtract(const Duration(days: 30)),
                                      maximumDate: DateTime.now()
                                          .add(const Duration(days: 30)),
                                      endDate: endDate,
                                      startDate: startDate,
                                      backgroundColor: Colors.white,
                                      primaryColor: Colors.green,
                                      onApplyClick: (start, end) {
                                        setState(() {
                                          endDate = end;
                                          startDate = start;
                                        });
                                      },
                                      onCancelClick: () {
                                        setState(() {
                                          endDate = null;
                                          startDate = null;
                                        });
                                      },
                                    );
                                  },
                                  child: Text("Select Date",
                                      style: GoogleFonts.lato(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
                Gap(30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: WidgetStateProperty.all(EdgeInsets.all(15)),
                        backgroundColor: WidgetStateProperty.all(Colors.green),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {},
                    child: Text(
                        "Apply for ${startDate != null && endDate != null ? endDate!.difference(startDate!).inDays + 1 : 0} Days Leave",
                        style: GoogleFonts.lato(
                            fontSize: 18, color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
