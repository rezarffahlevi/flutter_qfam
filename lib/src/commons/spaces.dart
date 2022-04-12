import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Spaces {
  static smallHorizontal() {
    return SizedBox(width: 7);
  }

  static smallVertical() {
    return SizedBox(height: 7);
  }

  static normalHorizontal() {
    return SizedBox(width: 14);
  }

  static normalVertical() {
    return SizedBox(height: 14);
  }

  static largeHorizontal() {
    return SizedBox(width: 28);
  }

  static largeVertical() {
    return SizedBox(height: 28);
  }

  static endScroll() {
    return SizedBox(height: 50);
  }
}
