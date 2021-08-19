import 'dart:async';

import 'package:rxdart/rxdart.dart';

class ToolbarConfigMixin {
  final _toolbarTitleSc = BehaviorSubject<String>();

  void updateToolbarTitle(String newTitle) {
    _toolbarTitleSc.add(newTitle);
  }

  Stream<String> get toolbarTitleStream => _toolbarTitleSc.stream;

  String get toolbarTitle => _toolbarTitleSc.value;

  void disposeToolbar() {
    _toolbarTitleSc.close();
  }
}
