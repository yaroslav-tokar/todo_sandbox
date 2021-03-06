import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_sandbox/data/models/toolbar_settings.dart';

ToolbarSettings defaultToolbarSettings = ToolbarSettings(
  title: '',
  onLeftCloseButtonTapped: () => null,
);

class ToolbarConfigMixin {
  final _toolbarSettingsSc = BehaviorSubject<ToolbarSettings>();

  Future<void> updateToolbarSettings(ToolbarSettings? toolbarSettings) async {
    _toolbarSettingsSc.add(toolbarSettings ?? defaultToolbarSettings);
  }

  Future<void> updateToolbarTitle(String toolbarTitle) async {
    _toolbarSettingsSc.add(defaultToolbarSettings..title = toolbarTitle);
  }

  Stream<ToolbarSettings> get toolbarSettingsStream =>
      _toolbarSettingsSc.stream;

  @protected
  ToolbarSettings get toolbarCurrentSettings => _toolbarSettingsSc.value;

  void disposeToolbarStreams() {
    _toolbarSettingsSc.close();
  }
}
