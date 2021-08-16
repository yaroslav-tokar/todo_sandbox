import 'package:flutter/material.dart';
import 'package:todo_sandbox/custom_view/blocking_view.dart';
import 'package:todo_sandbox/custom_view/progress_view.dart';
import 'package:todo_sandbox/custom_view/reloadable_error_view.dart';
import 'package:todo_sandbox/data/enums.dart';
import 'package:todo_sandbox/presentation/block/base_block.dart';


class BaseScreenView<T extends BaseBlock> extends StatelessWidget {
  final bool hasToolbar;
  final String title;
  final bool hasBackBtn;
  final Widget content;
  final ScreenViewState screenViewState;
  final bool canPop;

  final T block;

  const BaseScreenView({
    Key? key,
    required this.hasBackBtn,
    required this.block,
    required this.hasToolbar,
    required this.title,
    required this.content,
    this.screenViewState = ScreenViewState.ready,
    this.canPop = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _buildScreen();

  Widget _buildScreen() {
    final AppBar? appBar = hasToolbar ? _buildAppBar() : null;

    final Widget screenContent = _buildScreenContent();

    final Widget scaffold = Scaffold(
        appBar: appBar,
        body: Column(
          children: [
            Expanded(
              child: screenContent,
            )
          ],
          mainAxisSize: MainAxisSize.max,
        ));

    return WillPopScope(child: scaffold, onWillPop: () async => canPop);
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
          case ScreenViewState.notReady:
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
