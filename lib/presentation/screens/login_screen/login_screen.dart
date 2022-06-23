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
          child: AnimatedBuilder(
              animation: authController,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (authController.verificationID == null)
                      TextFormField(
                        controller: authController.phoneController,
                        keyboardType: TextInputType.phone,
                        autofillHints: const [AutofillHints.telephoneNumber],
                        decoration: const InputDecoration(
                          label: Text("Phone"),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (phone) => validatePhone(phone: phone),
                      ),
                    if (authController.verificationID != null)
                      TextFormField(
                        controller: authController.otpController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          label: Text("OTP"),
                        ),
                        autofillHints: const [AutofillHints.oneTimeCode],
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        // validator: (phone) => validatePhone(phone: phone),
                      ),
                    defaultSpacer,
                    ElevatedButton(
                        onPressed: authController.verificationID == null
                            ? authController.sendOtp
                            : authController.verifyOtp,
                        child: authController.buttonLoading
                            ? const SizedBox(
                                width: 300,
                                height: defaultPaddingLarge,
                                child: DefaultLoadingWidget())
                            : Text(authController.verificationID == null
                                ? "SENT OTP"
                                : "Verify OTP"))
                  ],
                );
              }),
        ),
      ),
    );
  }
}
