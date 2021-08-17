import 'package:flutter/material.dart';

class BlockingView extends StatelessWidget {
  const BlockingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [Expanded(child: Center(child: Text('Loading...')))],
      );
}
