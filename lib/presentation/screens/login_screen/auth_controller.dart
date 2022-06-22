import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthController extends ChangeNotifier {
  var user;

  final authInstance = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>(debugLabel: 'login_form_key');
  TextEditingController phoneController = TextEditingController();
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  void sentOtp() async {
    if (validate()) {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await authInstance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }
}
