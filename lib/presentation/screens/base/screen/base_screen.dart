import 'package:flutter/material.dart';
import 'package:todo_sandbox/config/mixin/toolbar_config_mixin.dart';
import 'package:todo_sandbox/data/enums.dart';
import 'package:todo_sandbox/data/models/toolbar_settings.dart';
import 'package:todo_sandbox/presentation/block/base/base_block.dart';
import 'package:todo_sandbox/presentation/custom_view/blocking_view.dart';
import 'package:todo_sandbox/presentation/custom_view/progress_view.dart';
import 'package:todo_sandbox/presentation/custom_view/reloadable_error_view.dart';
import 'package:todo_sandbox/presentation/custom_view/toolbar_view.dart';

const TextStyle toolbarFontStyle =
    TextStyle(fontWeight: FontWeight.w800, fontSize: 20);

class BaseScreenView<T extends BaseBloc> extends StatelessWidget {
  final ToolbarSettings? toolbarSettings;
  final Widget content;
  final ScreenViewState screenViewState;
  final bool canPop;
  final VoidCallback? onFloatingActionButtonTapped;
  final VoidCallback? onBackBtnPressed;

  final T bloc;

  const BaseScreenView({
    Key? key,
    required this.bloc,
    required this.content,
    this.screenViewState = ScreenViewState.ready,
    this.canPop = true,
    this.onFloatingActionButtonTapped,
    this.onBackBtnPressed,
    this.toolbarSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _buildScreen(context);

  Widget _buildScreen(BuildContext context) {
    // final double paddingTop = MediaQuery.of(context).padding.top;
    final Widget toolBar =
        toolbarSettings != null ? _buildToolbar() : const SizedBox.shrink();

    final Widget screenContent = _buildScreenContent();

    final Widget scaffold = Scaffold(
        floatingActionButton: _buildFloatingActionButton(),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              toolBar,
              const SizedBox(height: 8),
              screenContent,
            ],
          ),
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
            bodyContent = Expanded(
                child: Stack(children: [content, _buildProgressView()]));
            break;
          case ScreenViewState.notReady:
            bodyContent = const BlockingView();
            break;
          case ScreenViewState.error:
            bodyContent = RetryView(
              onReloadBtnClicked: () => bloc.lastCallableFunction?.call(),
            );
            break;
          default:
            //stub
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

  Widget _buildToolbar() => StreamBuilder<ToolbarSettings>(
      initialData: toolbarSettings ?? defaultToolbarSettings,
      stream: bloc.toolbarSettingsStream,
      builder:
          (BuildContext context, AsyncSnapshot<ToolbarSettings> snapshot) =>
              ToolbarView(
                toolbarSettings: snapshot.data,
                onBackButtonPressed: () => bloc.onBackButtonPressed.call(),
              ));
}
