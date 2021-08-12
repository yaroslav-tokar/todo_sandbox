import 'package:flutter/material.dart';
import 'package:todo_sandbox/core/enums.dart';
import 'package:todo_sandbox/stateful_model/base_model.dart';
import 'package:todo_sandbox/view/blocking_view.dart';
import 'package:todo_sandbox/view/progress_view.dart';
import 'package:todo_sandbox/view/reloadable_error_view.dart';

class BaseScreenView<T extends BaseModel> extends StatelessWidget {
  final bool hasToolbar;
  final String title;
  final bool hasBackBtn;
  final Widget content;

  final T model;

  const BaseScreenView({
    Key? key,
    required this.hasBackBtn,
    required this.model,
    required this.hasToolbar,
    required this.title,
    required this.content,
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
      initialData: ScreenViewState.ready,
      stream: model.screenViewState,
      builder: (context, snapshot) {
        Widget bodyContent = SizedBox.shrink();
        switch (snapshot.data) {
          case ScreenViewState.ready:
            bodyContent = Stack(
              children: [content, _buildProgressView()],
            );
            break;
          case ScreenViewState.not_ready:
            bodyContent = BlockingView();
            break;
          case ScreenViewState.error:
            bodyContent = BlockingErrorView(onReloadBtnClicked: () => null);
            break;
        }

        return bodyContent;
      });

  Widget _buildProgressView() => StreamBuilder<ProgressViewState>(
      initialData: ProgressViewState.idle,
      stream: model.progressViewState,
      builder: (context, snapshot) => snapshot.data == ProgressViewState.busy
          ? ProgressView()
          : SizedBox.shrink());

  AppBar _buildAppBar() => AppBar(title: Text(title));
}
