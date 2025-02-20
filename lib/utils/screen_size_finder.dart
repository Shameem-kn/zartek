import 'package:flutter/material.dart';

late double screenWidth;
late double screenHeight;

void screenSizeFinder(BuildContext context) {
  Size size = MediaQuery.sizeOf(context);

  screenWidth = size.width;
  screenHeight = size.height;
}
