import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:video_player_test/presentation/screens/login_screen/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.logout),
            onTap:() =>  Get.find<AuthController>().logoutUser(),
          )
        ],
      ),
    );
  }
}
