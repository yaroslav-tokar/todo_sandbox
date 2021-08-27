import 'package:flutter/material.dart';

class ToolbarSettings {
  String? title;
  final bool hasBackButton;
  final bool? hasLeftCloseButton;
  final Function? onLeftCloseButtonTapped;
  final GlobalKey? key;

  ToolbarSettings({
    this.key,
    this.hasLeftCloseButton = false,
    this.onLeftCloseButtonTapped,
    this.hasBackButton = false,
    this.title,
  });
}
