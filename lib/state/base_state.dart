import 'package:flutter/material.dart';
import 'package:todo_sandbox/stateful_model/base_model.dart';
import 'package:todo_sandbox/stateful_model/base_stateful_model.dart';
import 'package:todo_sandbox/view/progress_view.dart';

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
  Widget build(BuildContext context) => _buildBody();

  Widget _buildBody() {
    final AppBar? appBar = hasToolbar ? _buildAppBar() : null;
    final Widget progressBar = _buildProgress();

    final body = Column(children: [Expanded(child: content)]);

    return Scaffold(appBar: appBar, body: Stack(children: [body, progressBar]));
  }

  Widget _buildProgress() => StreamBuilder<ViewState>(
      initialData: ViewState.idle,
      stream: model.loadState,
      builder: (context, snapshot) =>
          snapshot.data == ViewState.busy ? ProgressView() : SizedBox.shrink());

  AppBar _buildAppBar() => AppBar(title: Text(title));
}
