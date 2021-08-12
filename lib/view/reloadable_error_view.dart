import 'package:flutter/material.dart';

class BlockingErrorView extends StatelessWidget {
  final Function onReloadBtnClicked;

  const BlockingErrorView({Key? key, required this.onReloadBtnClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Column(
              children: [
                Icon(Icons.refresh, size: 50),
                ElevatedButton(
                    onPressed: () => onReloadBtnClicked.call(),
                    child: Text('Reload'))
              ],
            ))
          ],
        ),
      );
}
