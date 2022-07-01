import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qfam/firebase_options.dart';
import 'package:flutter_qfam/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: MyColors.primary));

  runApp(const App());
}
