import 'package:flutter/cupertino.dart';

class Dimension {
  static var device = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  static double screenHeight = device.size.height;
  static double screenWidth = device.size.width;

  static double height8 = screenHeight / 80;
  static double height10 = screenHeight / 64;
  static double height35 = screenHeight / 18.28;
  static double height6 = screenHeight / 106.67;
  static double height30 = screenHeight / 21.33;


  static double width2 = screenWidth / 180;
  static double width10 = screenWidth / 36;
  static double width70 = screenWidth / 5.14;
  static double width4 = screenWidth / 90;
  static double width65 = screenWidth / 5.53;

}
