import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_sandbox/util/logger.dart';

enum ViewState { idle, busy }

class BaseStatefulModel extends ChangeNotifier {
  ViewState _viewState = ViewState.busy;

  final _viewStateController = StreamController<ViewState>();

  void consumeLoadableCall(Function callable) async {
    onBusy();
    callable.call();
    onIdle();
  }

  void setViewState(ViewState viewState) {
    _updateViewState(viewState);
  }

  onIdle() => _updateViewState(ViewState.idle);

  onBusy() => _updateViewState(ViewState.busy);

  _updateViewState(ViewState viewState) {
    Logger.i('ViewState\t$viewState');
    this._viewState = viewState;
    notifyListeners();
    // _viewStateController.add(_viewState);
  }

  @mustCallSuper
  void disposeModel() {
    _viewStateController.close();
  }

  ViewState get viewState => _viewState;
}
