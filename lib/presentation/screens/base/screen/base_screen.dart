import 'package:flutter/material.dart';
import 'package:todo_sandbox/config/theme/styles.dart';
import 'package:todo_sandbox/core/constants/colors.dart';
import 'package:todo_sandbox/core/util/hex_color.dart';
import 'package:todo_sandbox/core/util/logger.dart';
import 'package:todo_sandbox/data/enums.dart';
import 'package:todo_sandbox/presentation/block/base/base_block.dart';
import 'package:todo_sandbox/presentation/custom_view/blocking_view.dart';
import 'package:todo_sandbox/presentation/custom_view/progress_view.dart';
import 'package:todo_sandbox/presentation/custom_view/reloadable_error_view.dart';

class BaseScreenView<T extends BaseBloc> extends StatelessWidget {
  final bool hasToolbar;
  final String? title;
  final Widget content;
  final ScreenViewState screenViewState;
  final bool canPop;
  final VoidCallback? onFloatingActionButtonTapped;
  final VoidCallback? onBackBtnPressed;

  final T bloc;

  const BaseScreenView({
    Key? key,
    required this.bloc,
    required this.hasToolbar,
    this.title = '',
    required this.content,
    this.screenViewState = ScreenViewState.ready,
    this.canPop = true,
    this.onFloatingActionButtonTapped,
    this.onBackBtnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _buildScreen(context);

  Widget _buildScreen(BuildContext context) {
    // final double paddingTop = MediaQuery.of(context).padding.top;
    final AppBar? toolBar = hasToolbar ? _buildToolbar() : null;

    final Widget screenContent = _buildScreenContent();

    final Widget scaffold = Scaffold(
        floatingActionButton: _buildFloatingActionButton(),
        appBar: toolBar,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            screenContent,
          ],
        ));

    return WillPopScope(
        onWillPop: () async {
          bloc.onBackButtonPressed.call();
          return canPop;
        },
        child: scaffold);
  }

  Widget _buildFloatingActionButton() => onFloatingActionButtonTapped != null
      ? FloatingActionButton(
          onPressed: () => onFloatingActionButtonTapped?.call(),
          child: const Icon(Icons.add),
        )
      : const SizedBox.shrink();

  Widget _buildScreenContent() => StreamBuilder<ScreenViewState>(
      initialData: screenViewState,
      stream: bloc.screenViewState,
      builder: (BuildContext context, AsyncSnapshot<ScreenViewState> snapshot) {
        Widget bodyContent = const SizedBox.shrink();

        switch (snapshot.data) {
          case ScreenViewState.ready:
            bodyContent = Expanded(child: Stack(children: [content, _buildProgressView()]));
            break;
          case ScreenViewState.notReady:
            bodyContent = const BlockingView();
            break;
          case ScreenViewState.error:
            bodyContent = RetryView(
              onReloadBtnClicked: () => bloc.lastCallableFunction?.call(),
            );
            break;
        }

        return bodyContent;
      });

  Widget _buildProgressView() => StreamBuilder<ProgressViewState>(
      initialData: ProgressViewState.idle,
      stream: bloc.progressViewState,
      builder:
          (BuildContext context, AsyncSnapshot<ProgressViewState> snapshot) =>
              snapshot.data == ProgressViewState.busy
                  ? const ProgressView()
                  : const SizedBox.shrink());

  AppBar _buildToolbar() => AppBar(
        title: StreamBuilder<String>(
          initialData: title,
          stream: bloc.toolbarTitleStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
              Text(snapshot.data ?? ''),
        ),
      );
}
