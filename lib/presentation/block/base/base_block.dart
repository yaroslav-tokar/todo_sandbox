import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:todo_sandbox/config/mixin/toolbar_config_mixin.dart';
import 'package:todo_sandbox/core/resourses/data_state.dart';
import 'package:todo_sandbox/core/usecase/use_case.dart';
import 'package:todo_sandbox/core/util/logger.dart';
import 'package:todo_sandbox/data/enums.dart';
import 'package:todo_sandbox/data/models/note_details_model.dart';
import 'package:todo_sandbox/data/network/api_components.dart';
import 'package:todo_sandbox/presentation/arguments/screen_arguments.dart';

typedef OnSuccess = Function<T>(T? data);
typedef OnError = Function(ResponseError errorMessage);
typedef OnDone = Function();

abstract class BaseBloc with ToolbarConfigMixin {
  Function? lastCallableFunction;

  ScreenViewState _screenViewState = ScreenViewState.ready;
  ProgressViewState _progressViewState = ProgressViewState.idle;

  final _screenViewStateSc = StreamController<ScreenViewState>.broadcast();
  final _progressViewStateSc = StreamController<ProgressViewState>.broadcast();

  //Progress events
  @protected
  Future<void> onBusyProgressViewStateEvent() async =>
      _updateProgressViewState(ProgressViewState.busy);

  @protected
  Future<void> onIdleProgressViewStateEvent() async =>
      _updateProgressViewState(ProgressViewState.idle);

  //Screen events
  @protected
  Future<void> onErrorScreenViewStateEvent() async =>
      _updateScreenViewState(ScreenViewState.error);

  @protected
  Future<void> onNotReadyScreenViewStateEvent() async =>
      _updateScreenViewState(ScreenViewState.notReady);

  @protected
  Future<void> onReadyScreenViewStateEvent() async =>
      _updateScreenViewState(ScreenViewState.ready);

  Future<void> _updateScreenViewState(ScreenViewState state) async {
    _screenViewState = state;
    _screenViewStateSc.add(_screenViewState);
  }

  Future<void> _updateProgressViewState(ProgressViewState state) async {
    _progressViewState = state;
    _progressViewStateSc.add(_progressViewState);
  }

  Stream<ScreenViewState> get screenViewState => _screenViewStateSc.stream;

  Stream<ProgressViewState> get progressViewState =>
      _progressViewStateSc.stream;

  Future<void> consumeSimpleCall<T>({
    required UseCase call,
    required Function(T? data) onSuccess,
    required OnError onError,
    OnDone? onDone,
  }) async {
    lastCallableFunction = () async {
      onBusyProgressViewStateEvent();

      final DataState<T> callResult = await call() as DataState<T>;
      if (callResult is DataStateSuccess) {
        onSuccess.call(callResult.data);
      } else if (callResult is DataStateFailed) {
        onError.call(ResponseError(Object(), 'UnknownError'));
      }

      await Future.delayed(const Duration(milliseconds: 1500));

      onIdleProgressViewStateEvent();
    };
    lastCallableFunction?.call();
  }


  @mustCallSuper
  void dispose() {
    disposeToolbar();
    _screenViewStateSc.close();
    _progressViewStateSc.close();
    lastCallableFunction = null;
  }
}
