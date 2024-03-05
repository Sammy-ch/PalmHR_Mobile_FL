import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

@RoutePage()
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                SettingHeader(),
                SettingsPage()
              ],
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
          Text("Settings",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))
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
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
      decoration: const BoxDecoration(
        color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      child: Row(
        children: [
          const Icon(Icons.account_box_outlined,size: 50.0,),
          const SizedBox(width: 15.0),
          const  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Alain Cherubin",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Text("sammystcherubin@gmail.com")
            ],
          ),
          SizedBox(width: 50.0),
          IconButton(onPressed: (){}, icon: const Icon(Icons.logout,size: 45.0,))
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
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 700,
      child: ListView(
        children: [
          // User card
          BigUserCard(
            backgroundColor: Colors.blueGrey,
            userName: "Alain Cherubin",
            userProfilePic: AssetImage("assets/logo.png"),
            cardActionWidget: SettingsItem(
              icons: Icons.edit,
              iconStyle: IconStyle(
                withBackground: true,
                borderRadius: 50,
                backgroundColor: Colors.black,
              ),
              title: "Modify",
              subtitle: "Tap to change your data",
              onTap: () {
                print("OK");
              },
            ),
          ),
          SettingsGroup(
            items: [
              SettingsItem(
                onTap: () {},
                icons: CupertinoIcons.pencil_outline,
                iconStyle: IconStyle(),
                title: 'Appearance',
                subtitle: "Make Ziar'App yours",
              ),
              SettingsItem(
                onTap: () {},
                icons: Icons.dark_mode_rounded,
                iconStyle: IconStyle(
                  iconsColor: Colors.white,
                  withBackground: true,
                  backgroundColor: Colors.red,
                ),
                title: 'Dark mode',
                subtitle: "Automatic",
                trailing: Switch.adaptive(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          SettingsGroup(
            items: [
              SettingsItem(
                onTap: () {},
                icons: Icons.info_rounded,
                iconStyle: IconStyle(
                  backgroundColor: Colors.purple,
                ),
                title: 'About',
                subtitle: "Learn more about Ziar'App",
              ),
            ],
          ),
          // You can add a settings title
          SettingsGroup(
            settingsGroupTitle: "Account",
            items: [
              SettingsItem(
                onTap: () {},
                icons: Icons.exit_to_app_rounded,
                title: "Sign Out",
              ),
              SettingsItem(
                onTap: () {},
                icons: CupertinoIcons.delete_solid,
                title: "Delete account",
                titleStyle: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
