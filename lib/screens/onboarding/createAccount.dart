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
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Create Account',
            style: GoogleFonts.dmSans(fontSize: 25, color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
            onPressed: () => context.go('/login'),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("First Name"),
                  const SizedBox(height: 5),
                  MUIPrimaryInputField(
                    hintText: "First Name",
                    controller: _firstNameController,
                    filledColor: Colors.white,
                    enabledBorderColor: Colors.grey,
                  ),
                  const Gap(20),
                  const Text("Last Name"),
                  const SizedBox(height: 5),
                  MUIPrimaryInputField(
                    hintText: "Last Name",
                    controller: _lastNameController,
                    filledColor: Colors.white,
                    enabledBorderColor: Colors.grey,
                  ),
                  const Gap(20),
                  const Text("Position"),
                  const SizedBox(height: 5),
                  MUIPrimaryInputField(
                    hintText: "Position",
                    controller: _positionController,
                    filledColor: Colors.white,
                    enabledBorderColor: Colors.grey,
                  ),
                  const Gap(20),
                  const Text("Work Email"),
                  const SizedBox(height: 5),
                  MUIPrimaryInputField(
                    hintText: "Work Email",
                    controller: _workEmailController,
                    filledColor: Colors.white,
                    enabledBorderColor: Colors.grey,
                  ),
                  const Gap(30),
                  const Text("Organization Id"),
                  const SizedBox(height: 5),
                  MUIPrimaryInputField(
                    isObscure: true,
                    hintText: "Enter Organization Id",
                    controller: _organizationIdController,
                    filledColor: Colors.white,
                    enabledBorderColor: Colors.grey,
                  ),
                  const Gap(13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                _createAccount(
                                  _firstNameController.text,
                                  _lastNameController.text,
                                  _positionController.text,
                                  _workEmailController.text,
                                  _organizationIdController.text,
                                );
                              },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.black),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : const Text("Create Account"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _createAccount(
      String firstName, String lastName, String position, String workEmail, String organizationId) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await supabase.from('EmployeeProfile').insert({
        'profile_id': userId,
        'first_name': firstName,
        'last_name': lastName,
        'position': position,
        'email': workEmail,
        'org_id': organizationId,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account created successfully"),
          backgroundColor: Colors.green,
        ),
      );

      // Clear the input fields
      _firstNameController.clear();
      _lastNameController.clear();
      _positionController.clear();
      _workEmailController.clear();
      _organizationIdController.clear();

      context.go('/home');

    } on PostgrestException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("An unexpected error occurred"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}