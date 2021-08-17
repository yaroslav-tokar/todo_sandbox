import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sandbox/presentation/di/di.dart';
import 'package:todo_sandbox/presentation/view_model/base_stateful_model.dart';

class BaseNotifiableScreen<T extends BaseStatefulModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Function(T) onModelReady;

  const BaseNotifiableScreen({required this.onModelReady, required this.builder});

  @override
  _BaseNotifiableScreenState<T> createState() => _BaseNotifiableScreenState<T>();
}

class _BaseNotifiableScreenState<T extends BaseStatefulModel>
    extends State<BaseNotifiableScreen<T>> {
  T statefulModel = locator<T>();

  @override
  void initState() {
    widget.onModelReady(statefulModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<T>(
        create: (BuildContext context) => statefulModel,
        child: Consumer<T>(builder: widget.builder),
      );
}
