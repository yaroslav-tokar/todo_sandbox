import 'package:flutter/cupertino.dart';
import 'package:todo_sandbox/presentation/arguments/screen_arguments.dart';
import 'package:todo_sandbox/presentation/block/base/base_bloc_with_arguments.dart';
import 'package:todo_sandbox/presentation/screens/base/state/base_state.dart';

abstract class BaseStateWithArguments<
    B extends BaseBlocWithArguments<A>,
    W extends StatefulWidget,
    A extends ScreenArguments> extends BaseState<B, W> {
  @override
  void initState() {
    onAttachBloc();
    super.initState();
  }

  void onAttachBloc() {
    WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) {
      final A? _arguments = ModalRoute.of(context)?.settings.arguments as A?;
      bloc.attachArguments(args: _arguments);
    });
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
