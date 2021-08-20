import 'package:flutter/material.dart';
import 'package:todo_sandbox/config/theme/styles.dart';
import 'package:todo_sandbox/core/constants/colors.dart';
import 'package:todo_sandbox/core/util/hex_color.dart';
import 'package:todo_sandbox/data/models/toolbar_settings.dart';



class ToolbarView extends StatelessWidget {
  const ToolbarView({Key? key, required this.toolbarSettings})
      : super(key: key);

  final ToolbarSettings? toolbarSettings;

  @override
  Widget build(BuildContext context) {
    const String title = 'empty toolbar title';

    return Container(
        decoration: BoxDecoration(color: primaryColor, boxShadow: <BoxShadow>[
          BoxShadow(color: HexColor('#000000'), blurRadius: 6)
        ]),
        padding: const EdgeInsets.only(top: 22),
        child: Row(
          children: <Widget>[
            if (toolbarSettings!.hasBackButton)
              const Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: Colors.white,
                  )),
            Expanded(
                child: SizedBox(
                    height: 52,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(title,
                            textAlign: TextAlign.center,
                            style: defaultToolbarTextStyle)
                      ],
                    )))
          ],
        ));
  }
}
