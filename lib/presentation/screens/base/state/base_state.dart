import 'package:flutter/material.dart';
import 'package:todo_sandbox/presentation/block/base/base_block.dart';
import 'package:todo_sandbox/presentation/di/di.dart';

abstract class BaseState<B extends BaseBloc, W extends StatefulWidget>
    extends State<W> {
  B bloc = locator<B>();

  @protected
  Widget get buildBody;
}
