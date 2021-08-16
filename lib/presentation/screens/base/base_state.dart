import 'package:flutter/material.dart';
import 'package:todo_sandbox/presentation/block/base_block.dart';
import 'package:todo_sandbox/presentation/di/di.dart';

abstract class BaseStateWithModel<T extends BaseBlock, W extends StatefulWidget>
    extends State<W> {

  @protected
  T statefulModel = locator<T>();

  @protected
  Widget? buildBody();
}
