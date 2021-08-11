import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:todo_sandbox/stateful_model/base_stateful_model.dart';

class BaseModel {
  final _loadState = StreamController<ViewState>.broadcast();

  Stream<ViewState> get loadState => _loadState.stream;

  @mustCallSuper
  void dispose() {
    _loadState.close();
  }
}
