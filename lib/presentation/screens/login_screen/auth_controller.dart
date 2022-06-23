import 'package:basic_template/basic_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  AuthController() {
    firebaseAuthInstance.userChanges().listen((newUser) {
      user = newUser;
      notifyListeners();
    });
  }

  User? user;
  final firebaseAuthInstance = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>(debugLabel: 'login_form_key');
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  bool buttonLoading = false;
  makeButtonLoading() {
    buttonLoading = true;
    notifyListeners();
  }

  makeButtonNotLoading() {
    buttonLoading = false;
    notifyListeners();
  }

  String? verificationID;

  sendOtp() async {
    if (validate()) {
      await firebaseAuthInstance.verifyPhoneNumber(
        phoneNumber: "+91${phoneController.text}",
        verificationCompleted: (PhoneAuthCredential credential) {
          makeButtonNotLoading();
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            logger.info('The provided phone number is not valid.');
          }
          makeButtonNotLoading();
        },
        timeout: const Duration(seconds: 60),
        codeSent: (String verificationId, int? resendToken) {
          verificationID = verificationId;
          logger.info(verificationId);
          phoneController.clear();
          otpController.clear();
          makeButtonNotLoading();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  verifyOtp() async {
    makeButtonLoading();
    logger.info(verificationID);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID!, smsCode: otpController.text);
    try {
      await firebaseAuthInstance.signInWithCredential(credential);
      makeButtonNotLoading();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
      makeButtonNotLoading();
    }
  }

  logoutUser() {
    firebaseAuthInstance.signOut();
  }
}
