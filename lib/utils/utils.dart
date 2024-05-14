import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Utils {
  Size getScreenSize() {
    return MediaQueryData.fromView(WidgetsBinding.instance.window).size;
  }
}
