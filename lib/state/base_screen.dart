import 'package:flutter/material.dart';
import 'package:todo_sandbox/core/enums.dart';
import 'package:todo_sandbox/stateful_model/base_model.dart';
import 'package:todo_sandbox/view/blocking_view.dart';
import 'package:todo_sandbox/view/progress_view.dart';
import 'package:todo_sandbox/view/reloadable_error_view.dart';

class BaseScreenView<T extends BaseBlock> extends StatelessWidget {
  final bool hasToolbar;
  final String title;
  final bool hasBackBtn;
  final Widget content;
  final ScreenViewState screenViewState;

  final T block;

  const BaseScreenView({
    Key? key,
    required this.hasBackBtn,
    required this.block,
    required this.hasToolbar,
    required this.title,
    required this.content,
    this.screenViewState = ScreenViewState.ready,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _buildScreen();

  Widget _buildScreen() {
    final AppBar? appBar = hasToolbar ? _buildAppBar() : null;

    final Widget screenContent = _buildScreenContent();

    return Scaffold(
        appBar: appBar,
        body: Column(
          children: [
            Expanded(
              child: screenContent,
            )
          ],
          mainAxisSize: MainAxisSize.max,
        ));
  }

  Widget _buildScreenContent() => StreamBuilder<ScreenViewState>(
      initialData: screenViewState,
      stream: block.screenViewState,
      builder: (context, snapshot) {
        Widget bodyContent = SizedBox.shrink();

        switch (snapshot.data) {
          case ScreenViewState.ready:
            bodyContent = Stack(children: [content, _buildProgressView()]);
            break;
          case ScreenViewState.not_ready:
            bodyContent = BlockingView();
            break;
          case ScreenViewState.error:
            bodyContent = RetryView(
              onReloadBtnClicked: () => block.lastCallableFunction?.call(),
            );
            break;
        }

        return bodyContent;
      });

  Widget _buildProgressView() => StreamBuilder<ProgressViewState>(
      initialData: ProgressViewState.idle,
      stream: block.progressViewState,
      builder: (context, snapshot) => snapshot.data == ProgressViewState.busy
          ? ProgressView()
          : SizedBox.shrink());

  AppBar _buildAppBar() => AppBar(title: Text(title));
}
