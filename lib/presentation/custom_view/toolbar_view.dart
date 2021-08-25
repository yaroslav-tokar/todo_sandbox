import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_sandbox/config/navigation/navigation.dart';
import 'package:todo_sandbox/config/theme/styles.dart';
import 'package:todo_sandbox/core/constants/colors.dart';
import 'package:todo_sandbox/data/models/toolbar_settings.dart';

const String defaultTitle = 'empty toolbar title';

class ToolbarView extends StatelessWidget {
  final VoidCallback? onBackButtonTapped;

  const ToolbarView({
    Key? key,
    required this.toolbarSettings,
    this.onBackButtonTapped,
  }) : super(key: key);

  final ToolbarSettings? toolbarSettings;

  @override
  Widget build(BuildContext context) {
    final String actualTitle = toolbarSettings?.title ?? defaultTitle;
    final double paddingTop = MediaQuery.of(context).padding.top;

    return Padding(
        padding: EdgeInsets.only(top: paddingTop),
        child: Container(
          height: 52,
          color: primaryColor,
          child: Row(
            children: [
              Expanded(flex: 2, child: _buildBackButton()),
              Expanded(flex: 10, child: _buildTitle(actualTitle)),
              Expanded(flex: 2, child: _buildBackButton()),
            ],
          ),
        ));
  }

  Widget _buildTitle(String title) => Container(
        color: Colors.yellow,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              SizedBox(
                  height: 52,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(title,
                          textAlign: TextAlign.center,
                          style: defaultToolbarTextStyle)
                    ],
                  )),
            ],
          ),
        ),
      );

  Widget _buildBackButton() => GestureDetector(
        onTap: () {
          onBackButtonTapped ?? Navigation.I.pop();
        },
        child: const Padding(
            padding: EdgeInsets.only(left: 14),
            child: Icon(
              Icons.arrow_back,
              size: 28,
              color: Colors.white,
            )),
      );
}
