import 'package:flutter/services.dart';
import 'package:flutter_qfam/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: MyColors.primary));
      
  runApp(const App());
}
