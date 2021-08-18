import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_sandbox/core/util/logger.dart';
import 'package:todo_sandbox/data/enums.dart';


class BaseStatefulModel extends ChangeNotifier {
  ScreenViewState _viewState = ScreenViewState.ready;

  final _viewStateController = StreamController<ScreenViewState>();

  Future<void> consumeLoadableCall(Function callable) async {
    onBusy();
    callable.call();
    onIdle();
  }

  void setViewState(ScreenViewState viewState) {
    _updateViewState(viewState);
  }

  void onIdle() => _updateViewState(ScreenViewState.ready);

  void onBusy() => _updateViewState(ScreenViewState.ready);

  void _updateViewState(ScreenViewState viewState) {
    logInfo('ViewState\t$viewState');
    _viewState = viewState;
    notifyListeners();
    // _viewStateController.add(_viewState);
  }

  @mustCallSuper
  void disposeModel() {
    _viewStateController.close();
  }

  ScreenViewState get viewState => _viewState;
}
