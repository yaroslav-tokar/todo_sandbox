import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sandbox/presentation/di/di.dart';
import 'package:todo_sandbox/presentation/stateful_models/base_stateful_model.dart';

class BaseStatefulScreen<T extends BaseStatefulModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Function(T) onModelReady;

  BaseStatefulScreen({required this.onModelReady, required this.builder});

  @override
  _BaseStatefulScreenState<T> createState() => _BaseStatefulScreenState<T>();
}

class _BaseStatefulScreenState<T extends BaseStatefulModel>
    extends State<BaseStatefulScreen<T>> {
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
