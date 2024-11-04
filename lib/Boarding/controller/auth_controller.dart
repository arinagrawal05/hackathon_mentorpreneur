import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mvp_app/Events/user_model.dart';
import 'package:event_mvp_app/Utils/app_utils.dart';
import 'package:event_mvp_app/Boarding/enter_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AuthController extends GetxController {
  // @override
  // void dispose() {
  //   super.dispose();
  //   amountController.value?.dispose();
  //   totalBillController.value?.dispose();
  //   creditController.value?.dispose();
  //   walletController.value?.dispose();
  // }

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  User? _user;
  User get user => _user!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserModel userModel = UserModel(
      userId: "userId",
      phone: "dummy phone",
      name: "dummy name",
      age: 12,
      type: "type",
      isAvailable: true,
      isMale: true,
      skillsSelected: ["Dart", "Python"],
      occupation: "occupation",
      businessIdea: "businessIdea",
      timestamp: Timestamp.now());
  // AuthProvider() {
  //   checkSign();
  // }

  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("isLogged") ?? false;
    update();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("isLogged", true);
    _isSignedIn = true;
    update();
  }

  // signin
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    print(isLoading.toString());
    _isLoading = true;

    update();
    print(isLoading.toString());

    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            _isLoading = false;
            update();

            AppUtils.navigateslide(
                EnterOtpPage(
                  verificationId: verificationId,
                  phone: phoneNumber,
                ),
                context);
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      AppUtils.showSnackMessage(e.message.toString());
    }
    update();
  }

  // verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    update();

    try {
      print("hello guys 1");

      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
      print("hello guys 2");

      if (user != null) {
        print("hello guys 3");
        // carry our logic
        _user = user;
        onSuccess();
      }
      _isLoading = false;
      update();
    } on FirebaseAuthException catch (e) {
      AppUtils.showSnackMessage(e.message.toString());
      _isLoading = false;
      update();
    }
  }

  // DATABASE OPERTAIONS
  // Future<bool> checkExistingUser() async {
  //   DocumentSnapshot snapshot =
  //       await _firebaseFirestore.collection("Users").doc(_user!.uid).get();
  //   if (snapshot.exists) {
  //     print("USER EXISTS");
  //     return true;
  //   } else {
  //     print("NEW USER");
  //     return false;
  //   }
  // }

  void addUser(
      String name,
      int age,
      String phone,
      String type,
      List skills,
      String occupation,
      String bussinessIdea,
      bool isAvailable,
      bool isMale) async {
    var id = const Uuid().v4();
    FirebaseFirestore.instance.collection("Users").doc(id).set({
      "userid": id,
      "phone": phone,
      "name": name,
      "age": age,
      "type": type,
      "isAvailable": isAvailable,
      "isMale": isMale,
      "skills_selected": skills,
      "occupation": occupation,
      "bussiness_idea": bussinessIdea,
      "timestamp": Timestamp.now()
    }).then((value) {
      print("new user registered");
    }).then((value) {
      getUserModel(phone).then((model) {
        feedUserModel(model);
        AppUtils.setUserdata(model.toJson());
      });
      AppUtils.setpref(true);
    });
  }

  Future<bool> isUserMatch(
    String phone,
  ) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .where("phone", isEqualTo: phone)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking user match: $e");
      return false;
    }
  }

  Future<UserModel> getUserModel(String phone) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .where("phone", isEqualTo: phone)
        .get();
    if (querySnapshot.docs.isEmpty) {
      print("no user got to model" + phone.toString());
    }
    var userData = querySnapshot.docs.first;
    return UserModel.fromFirestore(userData);
  }

  void feedUserModel(UserModel model) {
    userModel = model;
    print("feed model to getx");

    update();
  }
  // void saveUserDataToFirebase({
  //   required BuildContext context,
  //   required UserModel userModel,
  //   required File profilePic,
  //   required Function onSuccess,
  // }) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   try {
  //     // uploading image to firebase storage.
  //     await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
  //       userModel.photoUrl = value;
  //       userModel.fcmToken = DateTime.now().millisecondsSinceEpoch.toString();
  //       userModel.phone = _firebaseAuth.currentUser!.phoneNumber!;
  //       userModel.userid = _firebaseAuth.currentUser!.uid;
  //     });
  //     _userModel = userModel;

  //     // uploading to database
  //     await _firebaseFirestore
  //         .collection("users")
  //         .doc(_uid)
  //         .set(userModel.toMap())
  //         .then((value) {
  //       onSuccess();
  //       _isLoading = false;
  //       notifyListeners();
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     AppUtils.showSnackMessage(e.message.toString());
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<String> storeFileToStorage(String ref, File file) async {
  //   UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
  //   TaskSnapshot snapshot = await uploadTask;
  //   String downloadUrl = await snapshot.ref.getDownloadURL();
  //   return downloadUrl;
  // }

  // Future getDataFromFirestore() async {
  //   await _firebaseFirestore
  //       .collection("Users")
  //       .doc(_firebaseAuth.currentUser!.uid)
  //       .get()
  //       .then((DocumentSnapshot snapshot) {
  //     _userModel = UserModel.fromFirestore(snapshot);
  //   });
  // }

  // STORING DATA LOCALLY
  // Future saveUserDataToSP() async {
  //   SharedPreferences s = await SharedPreferences.getInstance();
  //   await s.setString("user_model", jsonEncode(userModel.toMap()));
  // }

  // Future getDataFromSP() async {
  //   SharedPreferences s = await SharedPreferences.getInstance();
  //   String data = s.getString("user_model") ?? '';
  //   _userModel = UserModel.fromFirestore(jsonDecode(data));
  //   _uid = _userModel!.userid;
  //   notifyListeners();
  // }

  // Future userSignOut() async {
  //   SharedPreferences s = await SharedPreferences.getInstance();
  //   await _firebaseAuth.signOut();
  //   _isSignedIn = false;
  //   notifyListeners();
  //   s.clear();
  // }
}
