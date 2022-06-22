import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player_test/presentation/screens/login_screen/auth_controller.dart';
import 'package:video_player_test/presentation/screens/navigation_screen/navigation_screen.dart';
import 'package:video_player_test/utils/constants.dart';
import 'package:video_player_test/utils/validators.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return AnimatedBuilder(
        animation: authController,
        builder: (context, child) => authController.user == null
            ? const LoginScreen()
            : const NavigationScreen());
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Form(
          key: authController.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  label: Text("Phone"),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (phone) => validatePhone(phone: phone),
              ),
              defaultSpacer,
              ElevatedButton(
                  onPressed: authController.sentOtp,
                  child: const Text("SENT OTP"))
            ],
          ),
        ),
      ),
    );
  }
}
