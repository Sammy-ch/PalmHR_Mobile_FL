import 'package:PALMHR_MOBILE/main.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:intl/intl.dart';
import 'package:PALMHR_MOBILE/services/queries.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
          children: [
            LeaveHeader(),
            Gap(20),
            Expanded(child: LeaveActivity()),
          ],
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
  List<Map<String, dynamic>> leaveRequests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLeaveRequests();
  }

  Future<void> fetchLeaveRequests() async {
    try {
      final requests = await fetchEmployeeLeaveRequests(userId);
      setState(() {
        leaveRequests = requests;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching leave requests: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardBackgroundColor =
        isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (leaveRequests.isEmpty) {
      return const Center(child: Text('No leave requests found.'));
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: leaveRequests.length,
      itemBuilder: (context, index) {
        final request = leaveRequests[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: cardBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request['leave_type'] ?? 'Unknown',
                      style: GoogleFonts.dmSans(
                        color: Colors.grey.shade600,
                        fontSize: 18,
                      ),
                    ),
                    Gap(5),
                    Text(
                      DateFormat('EEE, d MMM').format(DateTime.parse(request['leave_start'])),
                      style: GoogleFonts.dmSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(5),
                    Text(
                      '${request['leave_days']} day(s)',
                      style: GoogleFonts.roboto(
                        color: Colors.orange,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: _getStatusColor(request['leave_status']),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      request['leave_status'] ?? 'Unknown',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'APPROVED':
        return Colors.green;
      case 'PENDING':
        return Colors.orange;
      case 'DENIED':
        return Colors.red;
      default:
        return Colors.grey;
    }
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
  String leaveType = 'HOLIDAY'; // Default value
  String leaveReason = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final ModalBackgroundColor =
        isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                      const Gap(10),
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
                              DropdownButtonFormField<String>(
                                value: leaveType,
                                items: ['HOLIDAY', 'SICK', 'PERSONAL']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    leaveType = newValue!;
                                  });
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Leave Type'),
                              ),
                              const Gap(20),
                              Text("Cause",
                                  style: GoogleFonts.dmSans(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                              const Gap(5),
                              TextFormField(
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Write your reason',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    leaveReason = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a reason for your leave';
                                  }
                                  return null;
                                },
                              ),
                              const Gap(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              const Gap(30),
                              Center(
                                child: SizedBox(
                                  width: 150,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        padding: WidgetStateProperty.all(
                                            const EdgeInsets.all(5)),
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.green),
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
                  const Gap(30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          padding:
                              WidgetStateProperty.all(const EdgeInsets.all(15)),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.green),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            startDate != null &&
                            endDate != null) {
                          try {
                            if (userId != null) {
                              await insertEmployeeLeaveForm(
                                requestedLeaveDate: DateTime.now(),
                                leaveId: userId,
                                leaveType: leaveType,
                                leaveStart: startDate!,
                                leaveEnd: endDate!,
                                leaveDays:
                                    endDate!.difference(startDate!).inDays + 1,
                                leaveStatus: 'PENDING',
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Leave request submitted successfully')),
                              );
                              context.go('/leave');
                            } else {
                              throw Exception('User not logged in');
                            }
                          } on PostgrestException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${e.message}")),
                            );
                          }
                        }
                      },
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
      ),
    );
  }
}
