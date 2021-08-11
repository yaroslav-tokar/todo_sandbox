import 'package:flutter/material.dart';
import 'package:todo_sandbox/di/di.dart';
import 'package:todo_sandbox/stateful_model/base_model.dart';

abstract class BaseStateWithModel<T extends BaseModel, W extends StatefulWidget>
    extends State<W> {
  @protected
  T statefulModel = locator<T>();

  @protected
  Widget? buildBody();
}
