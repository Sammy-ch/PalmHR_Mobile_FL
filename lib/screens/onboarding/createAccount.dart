
import 'package:PALMHR_MOBILE/main.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modular_ui/modular_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _positionController = TextEditingController();
  final _workEmailController = TextEditingController();
  final _organizationIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              'Create Account',
              style: GoogleFonts.lato(fontSize: 25),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => context.go('/login'),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("First Name"),
                const SizedBox(
                  height: 5,
                ),
                MUIPrimaryInputField(
                  hintText: "First Name",
                  controller: TextEditingController(),
                  filledColor: Colors.white,
                  enabledBorderColor: Colors.grey,
                ),
                const Gap(20),
                const Text("Last Name"),
                const SizedBox(
                  height: 5,
                ),
                MUIPrimaryInputField(
                  hintText: "Last Name",
                  controller: TextEditingController(),
                  filledColor: Colors.white,
                  enabledBorderColor: Colors.grey,
                ),
                const Gap(20),
                const Text("Position"),
                const SizedBox(
                  height: 5,
                ),
                MUIPrimaryInputField(
                  hintText: "Position",
                  controller: TextEditingController(),
                  filledColor: Colors.white,
                  enabledBorderColor: Colors.grey,
                ),
                const Gap(20),
                const Text("Work Email"),
                const SizedBox(
                  height: 5,
                ),
                MUIPrimaryInputField(
                  hintText: "Work Email",
                  controller: TextEditingController(),
                  filledColor: Colors.white,
                  enabledBorderColor: Colors.grey,
                ),
                const Gap(30),
                const Text("Organization Id"),
                const SizedBox(
                  height: 5,
                ),
                MUIPrimaryInputField(
                  isObscure: true,
                  hintText: "Enter Organization Id",
                  controller: TextEditingController(),
                  filledColor: Colors.white,
                  enabledBorderColor: Colors.grey,
                ),
                const Gap(13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _createAccount(
                          _firstNameController.text,
                          _lastNameController.text,
                          _positionController.text,
                          _workEmailController.text,
                          _organizationIdController.text,
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.green.shade400),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)))),
                      child: const Text("Create Account"),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Future<void> _createAccount(
      firstName, lastName, position, workEmail, organizationId) async {
    try {
      final response = await supabase.from('EmployeeProfile').insert({
        'profile_id': userId,
        'first_name': firstName,
        'last_name': lastName,
        'position': position,
        'email': workEmail,
        'org_id': organizationId,
      });
    } on PostgrestException catch (error) {
      print(error.message);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: const Text("An unexpected error occurred"),
      //     backgroundColor: Theme.of(context).colorScheme.error,
      //   ),
      // );
    }
  }
}
