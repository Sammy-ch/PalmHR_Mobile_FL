import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modular_ui/modular_ui.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              'Create Account',
              style: GoogleFonts.lato(fontSize: 25),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => context.canPop(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("First Name"),
                SizedBox(
                  height: 5,
                ),
                MUIPrimaryInputField(
                  hintText: "First Name",
                  controller: TextEditingController(),
                  filledColor: Colors.black,
                  enabledBorderColor: Colors.grey,
                ),
                const Gap(20),
                Text("Last Name"),
                SizedBox(
                  height: 5,
                ),
                MUIPrimaryInputField(
                  hintText: "Last Name",
                  controller: TextEditingController(),
                  filledColor: Colors.black,
                  enabledBorderColor: Colors.grey,
                ),
                const Gap(20),
                Text("Position"),
                SizedBox(
                  height: 5,
                ),
                MUIPrimaryInputField(
                  hintText: "Position",
                  controller: TextEditingController(),
                  filledColor: Colors.black,
                  enabledBorderColor: Colors.grey,
                ),
                const Gap(20),
                Text("Work Email"),
                SizedBox(
                  height: 5,
                ),
                MUIPrimaryInputField(
                  hintText: "Work Email",
                  controller: TextEditingController(),
                  filledColor: Colors.black,
                  enabledBorderColor: Colors.grey,
                ),
                const Gap(30),
                Text("Organization Id"),
                SizedBox(
                  height: 5,
                ),
                MUIPrimaryInputField(
                  isObscure: true,
                  hintText: "Enter Organization Id",
                  controller: TextEditingController(),
                  filledColor: Colors.black,
                  enabledBorderColor: Colors.grey,
                ),
                // ElevatedButton(
                //   onPressed: () {},
                //   child: Text("Create Account"),
                //   style: ButtonStyle(
                //       backgroundColor: WidgetStateProperty.all(Colors.green),
                //       shape: WidgetStateProperty.all(RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10)))),
                // )
              ],
            ),
          )),
    );
  }
}
