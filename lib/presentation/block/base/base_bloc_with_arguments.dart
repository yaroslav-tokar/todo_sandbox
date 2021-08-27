import 'package:flutter/material.dart';
import 'package:todo_sandbox/presentation/arguments/screen_arguments.dart';
import 'package:todo_sandbox/presentation/block/base/base_block.dart';

abstract class BaseBlocWithArguments<A extends ScreenArguments> extends BaseBloc {
  @protected
  A? arguments;

  void attachArguments({A? args});
}
