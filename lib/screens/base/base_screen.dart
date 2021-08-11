import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sandbox/di/di.dart';
import 'package:todo_sandbox/stateful_model/base_stateful_model.dart';

class BaseScreen<T extends BaseStatefulModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Function(T) onModelReady;

  BaseScreen({required this.onModelReady, required this.builder});

  @override
  _BaseScreenState<T> createState() => _BaseScreenState<T>();
}

class _BaseScreenState<T extends BaseStatefulModel>
    extends State<BaseScreen<T>> {
  T statefulModel = locator<T>();

  @override
  void initState() {
    widget.onModelReady(statefulModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<T>(
        create: (context) => statefulModel,
        child: Consumer<T>(builder: widget.builder),
      );
}
