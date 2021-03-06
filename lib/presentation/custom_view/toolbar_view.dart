import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_sandbox/config/theme/styles.dart';
import 'package:todo_sandbox/core/constants/colors.dart';
import 'package:todo_sandbox/core/util/logger.dart';
import 'package:todo_sandbox/data/models/toolbar_settings.dart';

const String defaultTitle = '';

class ToolbarView extends StatefulWidget {
  final VoidCallback? onBackButtonPressed;
  final ToolbarSettings? toolbarSettings;

  const ToolbarView({
    this.toolbarSettings,
    this.onBackButtonPressed,
  });

  @override
  ToolbarViewState createState() => ToolbarViewState();
}

class ToolbarViewState extends State<ToolbarView> {
  @override
  Widget build(BuildContext context) {
    final String actualTitle = widget.toolbarSettings?.title ?? defaultTitle;
    final double paddingTop = MediaQuery.of(context).padding.top;

    return Padding(
        padding: EdgeInsets.only(top: paddingTop),
        child: Container(
          height: 52,
          color: primaryColor,
          child: Row(
            children: <Widget>[
              _buildLeftSection(),
              _buildCentralSection(actualTitle),
              buildRightSection(),
            ],
          ),
        ));
  }

  Future<void> hideBackButtonAndShowCloseButton() async {
    setState(() {});
    logInfo('Start to change state');
  }

  Expanded buildRightSection() =>
      const Expanded(flex: 2, child: SizedBox.shrink());

  Expanded _buildCentralSection(String actualTitle) =>
      Expanded(flex: 10, child: _buildTitle(actualTitle));

  Expanded _buildLeftSection() => Expanded(
      flex: 2,
      child: widget.toolbarSettings!.hasBackButton
          ? _buildBackButton()
          : const SizedBox.shrink());

  Widget _buildTitle(String title) => GestureDetector(
        child: Stack(
          children: <Widget>[
            Align(
              child: SizedBox(
                  height: 52,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(title,
                          textAlign: TextAlign.center,
                          style: defaultToolbarTextStyle)
                    ],
                  )),
            ),
          ],
        ),
      );

  Widget _buildCloseButton() => Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
            splashColor: Colors.white,
            onTap: widget.onBackButtonPressed,
            child: const Icon(
              Icons.close,
              size: 28,
              color: Colors.white,
            )),
      );

  Widget _buildBackButton() => Material(
        key: GlobalKey(),
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.white,
          onTap: _onBackButtonPressed,
          child: const Icon(
            Icons.arrow_back,
            size: 28,
            color: Colors.white,
          ),
        ),
      );

  Future<void> _onBackButtonPressed() async {
    widget.onBackButtonPressed?.call();
  }
}
