import 'package:flutter/material.dart';
import 'package:todo_sandbox/data/enums.dart';
import 'package:todo_sandbox/presentation/block/base/base_block.dart';
import 'package:todo_sandbox/presentation/custom_view/blocking_view.dart';
import 'package:todo_sandbox/presentation/custom_view/progress_view.dart';
import 'package:todo_sandbox/presentation/custom_view/reloadable_error_view.dart';

class BaseScreenView<T extends BaseBloc> extends StatelessWidget {
  final bool hasToolbar;
  final String title;
  final bool hasBackBtn;
  final Widget content;
  final ScreenViewState screenViewState;
  final bool canPop;
  final VoidCallback? onFloatingActionButtonTapped;

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
    this.onFloatingActionButtonTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _buildScreen();

  Widget _buildScreen() {
    final AppBar? appBar = hasToolbar ? _buildAppBar() : null;

    final Widget screenContent = _buildScreenContent();

    final Widget scaffold = Scaffold(
        appBar: appBar,
        floatingActionButton: _buildFloatingActionButton(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: screenContent,
            )
          ],
        ));

    return WillPopScope(onWillPop: () async => canPop, child: scaffold);
  }

  Widget _buildFloatingActionButton() => onFloatingActionButtonTapped != null
      ? FloatingActionButton(
          onPressed: () => onFloatingActionButtonTapped?.call(),
          child: const Icon(Icons.add),
        )
      : const SizedBox.shrink();

  Widget _buildScreenContent() => StreamBuilder<ScreenViewState>(
      initialData: screenViewState,
      stream: block.screenViewState,
      builder: (BuildContext context, AsyncSnapshot<ScreenViewState> snapshot) {
        Widget bodyContent = const SizedBox.shrink();

        switch (snapshot.data) {
          case ScreenViewState.ready:
            bodyContent = Stack(children: [content, _buildProgressView()]);
            break;
          case ScreenViewState.notReady:
            bodyContent = const BlockingView();
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
      builder:
          (BuildContext context, AsyncSnapshot<ProgressViewState> snapshot) =>
              snapshot.data == ProgressViewState.busy
                  ? const ProgressView()
                  : const SizedBox.shrink());

  AppBar _buildAppBar() => AppBar(title: Text(title));
}
