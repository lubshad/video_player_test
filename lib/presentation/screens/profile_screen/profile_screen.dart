import 'package:basic_template/basic_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player_test/presentation/screens/login_screen/auth_controller.dart';
import 'package:video_player_test/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(defaultPadding),
        children: [
          defaultSpacer,
          CircleAvatar(
            radius: defaultPaddingLarge,
            backgroundImage: authController.user?.photoURL == null
                ? null
                : CachedNetworkImageProvider(authController.user!.photoURL!),
          ),
          defaultSpacer,
          TextFormField(
              initialValue: authController.user?.displayName,
              decoration: const InputDecoration(label: Text("Name")),
              onChanged: (value) =>
                  authController.user?.updateDisplayName(value)),
          defaultSpacer,
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              initialValue: authController.user?.email,
              decoration: const InputDecoration(label: Text("Email")),
              onChanged: (value) async {
                if (value.isEmail) {
                  try {
                    await authController.user?.updateEmail(value);
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.message.toString())));
                  }
                }
              }),
          defaultSpacer,
          TextFormField(
            keyboardType: TextInputType.datetime,
            // initialValue: authController.user,
            decoration: const InputDecoration(label: Text("Date of Birth")),
          ),
          defaultSpacer,
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(Icons.logout),
            onTap: () => Get.find<AuthController>().logoutUser(),
          )
        ],
      ),
    );
  }
}
