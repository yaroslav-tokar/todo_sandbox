import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_sandbox/core/enums.dart';
import 'package:todo_sandbox/util/logger.dart';


class BaseStatefulModel extends ChangeNotifier {
  ScreenViewState _viewState = ScreenViewState.ready;

  final _viewStateController = StreamController<ScreenViewState>();

  void consumeLoadableCall(Function callable) async {
    onBusy();
    callable.call();
    onIdle();
  }

  void setViewState(ScreenViewState viewState) {
    _updateViewState(viewState);
  }

  onIdle() => _updateViewState(ScreenViewState.ready);

  onBusy() => _updateViewState(ScreenViewState.ready);

  _updateViewState(ScreenViewState viewState) {
    Logger.i('ViewState\t$viewState');
    this._viewState = viewState;
    notifyListeners();
    // _viewStateController.add(_viewState);
  }

  @mustCallSuper
  void disposeModel() {
    _viewStateController.close();
  }

  ScreenViewState get viewState => _viewState;
}
