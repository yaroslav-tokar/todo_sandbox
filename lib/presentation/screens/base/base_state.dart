import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:todo_sandbox/core/util/logger.dart';
import 'package:todo_sandbox/data/models/note_details_model.dart';
import 'package:todo_sandbox/presentation/arguments/screen_arguments.dart';
import 'package:todo_sandbox/presentation/block/base_block.dart';
import 'package:todo_sandbox/presentation/di/di.dart';

abstract class BaseState<B extends BaseBlock, W extends StatefulWidget>
    extends State<W> {
  B block = locator<B>();

  @protected
  Widget get buildBody;
}

abstract class BaseStateWithArguments<
    B extends BaseBlock,
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
      block.attachArguments(args: _arguments);
    });
  }
}
