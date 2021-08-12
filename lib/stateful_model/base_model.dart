import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:todo_sandbox/core/enums.dart';

class BaseModel {
  var _screenViewState = ScreenViewState.ready;
  var _progressViewState = ProgressViewState.idle;

  final _screenViewStateSc = StreamController<ScreenViewState>.broadcast();
  final _progressViewStateSc = StreamController<ProgressViewState>.broadcast();

  //Progress events
  @protected
  void onBusyProgressViewStateEvent() async => _updateProgressViewState(ProgressViewState.busy);
  @protected
  void onIdleProgressViewStateEvent() async => _updateProgressViewState(ProgressViewState.idle);

  //Screen events
  @protected
  void onErrorScreenViewStateEvent() async => _updateScreenViewState(ScreenViewState.error);
  @protected
  void onNotReadyScreenViewStateEvent() async => _updateScreenViewState(ScreenViewState.not_ready);
  @protected
  void onReadyScreenViewStateEvent() async => _updateScreenViewState(ScreenViewState.ready);

  _updateScreenViewState(ScreenViewState state) async {
    this._screenViewState = state;
    _screenViewStateSc.add(_screenViewState);
  }

  _updateProgressViewState(ProgressViewState state) async {
    this._progressViewState = state;
    _progressViewStateSc.add(_progressViewState);
  }

  Stream<ScreenViewState> get screenViewState => _screenViewStateSc.stream;
  Stream<ProgressViewState> get progressViewState => _progressViewStateSc.stream;

  @mustCallSuper
  void dispose() {
    _screenViewStateSc.close();
    _progressViewStateSc.close();
  }
}
