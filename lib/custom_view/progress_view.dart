import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.grey.withOpacity(0.5),
        child: Center(
          child: Container(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
              strokeWidth: 4,
            ),
          ),
        ),
      );
}
