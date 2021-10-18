import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'dart:async';
import 'package:treatment_checkup_app/main.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class FirebaseSignInService{

  FirebaseUser user;

  Future<void> checkLogin()async{
    user = await FirebaseAuth.instance.currentUser();
  }

  Future<void> signOut(BuildContext ct) async {
    print("SIGNING OUT");
    await UserTypeService().resetSingleton();
    await FirebaseAuth.instance.signOut();
   RestartWidget.restartApp(ct);
  }



}