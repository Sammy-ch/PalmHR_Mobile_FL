import 'package:PALMHR_MOBILE/main.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:PALMHR_MOBILE/themeProvider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [SettingHeader(), SettingsPage()],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingHeader extends StatefulWidget {
  const SettingHeader({super.key});

  @override
  State<SettingHeader> createState() => _SettingHeaderState();
}

class _SettingHeaderState extends State<SettingHeader> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Text("Settings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Row(
        children: [
          const Icon(
            Icons.account_box_outlined,
            size: 50.0,
          ),
          const SizedBox(width: 15.0),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Alain",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Text("sammystcherubin@gmail.com")
            ],
          ),
          const SizedBox(width: 50.0),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.logout,
                size: 45.0,
              ))
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ThemeMode themeMode = ThemeMode.system;
  ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

  var _loading = true;
  String _firstName = '';
  String _lastName = '';
  String _position = '';
  String _profileImage = '';

  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final data = await supabase
          .from("EmployeeProfile")
          .select("*")
          .eq("profile_id", userId)
          .single();

      _firstName = data['first_name'];
      _lastName = data['last_name'];
      _position = data['position'];
      _profileImage = data['profile_image'];
    } on PostgrestException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Unexpected error occurred'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SizedBox(
      height: 700,
      child: ListView(
        children: [
          // User card
          // BigUserCard(
          //   cardRadius: 20,
          //   backgroundColor: Colors.green,
          //   userName: "$_firstName $_lastName",
          //   userProfilePic: _profileImage.isNotEmpty
          //       ? NetworkImage(_profileImage,) as ImageProvider
          //       : const AssetImage("assets/logo.png") as ImageProvider,
          // ),
          SettingsGroup(
            items: [
              SettingsItem(
                icons: Icons.dark_mode_rounded,
                iconStyle: IconStyle(
                  iconsColor: Colors.white,
                  withBackground: true,
                  backgroundColor: Colors.red,
                ),
                title: 'Dark mode',
                subtitle: "Automatic",
                trailing: Switch.adaptive(
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
              ),
            ],
          ),
          SettingsGroup(
            items: [
              SettingsItem(
                onTap: () {
                  context.go("/privacyPolicy");
                },
                icons: Icons.info_rounded,
                iconStyle: IconStyle(
                  backgroundColor: Colors.purple,
                ),
                title: 'Privacy Policy',
                subtitle: "Learn more about PALM HR",
              ),
            ],
          ),
          // You can add a settings title
          SettingsGroup(
            settingsGroupTitle: "Account",
            items: [
              SettingsItem(
                onTap: () async {
                  await supabase.auth.signOut();
                  if (mounted) {
                    context.go("/login");
                  }
                },
                icons: Icons.exit_to_app_rounded,
                title: "Sign Out",
              ),
              // SettingsItem(
              //   onTap: () {},
              //   icons: Icons.delete_forever,
              //   title: "Delete account",
              //   titleStyle: const TextStyle(
              //     color: Colors.red,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
