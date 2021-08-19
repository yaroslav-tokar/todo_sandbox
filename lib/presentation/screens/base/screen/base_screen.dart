import 'package:flutter/material.dart';
import 'package:todo_sandbox/config/theme/styles.dart';
import 'package:todo_sandbox/core/constants/colors.dart';
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

  final T bloc;

  const BaseScreenView({
    Key? key,
    required this.hasBackBtn,
    required this.bloc,
    required this.hasToolbar,
    required this.title,
    required this.content,
    this.screenViewState = ScreenViewState.ready,
    this.canPop = true,
    this.onFloatingActionButtonTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _buildScreen(context);

  Widget _buildScreen(BuildContext context) {
    final double paddingTop = MediaQuery.of(context).padding.top;

    final Widget toolBar =
        hasToolbar ? _buildAppBar(paddingTop) : const SizedBox.shrink();

    final Widget screenContent = _buildScreenContent();

    final Widget scaffold = Scaffold(
        floatingActionButton: _buildFloatingActionButton(),
        body: Column(
          children: <Widget>[
            toolBar,
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
      stream: bloc.screenViewState,
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

  Widget _buildAppBar(double paddingTop) => StreamBuilder<String>(
        initialData: title,
        stream: bloc.toolbarTitleStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
            Padding(
                padding: EdgeInsets.only(top: paddingTop),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            color: primaryColor,
                            height: 48,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(snapshot.data ?? 'empty toolbar title',
                                    textAlign: TextAlign.center,
                                    style: defaultToolbarTextStyle)
                              ],
                            )))
                  ],
                )),
      );
}
