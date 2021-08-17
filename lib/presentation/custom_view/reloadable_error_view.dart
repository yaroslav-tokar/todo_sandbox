import 'package:flutter/material.dart';

class RetryView extends StatelessWidget {
  final Function onReloadBtnClicked;

  const RetryView({Key? key, required this.onReloadBtnClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Column(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
            child: Center(
                child: OutlinedButton.icon(
                    style: ButtonStyle(),
                    onPressed: () => onReloadBtnClicked.call(),
                    label: Text('Reload'),
                    icon: Icon(Icons.refresh, size: 25))))
      ]);
}
