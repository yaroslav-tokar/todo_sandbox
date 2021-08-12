import 'package:flutter/material.dart';
import 'package:todo_sandbox/constants/colors.dart';
import 'package:todo_sandbox/core/model/note_model.dart';

class NoteView extends StatelessWidget {
  final NoteModel model;
  final Function onClicked;

  const NoteView({
    Key? key,
    required this.model,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(width: 2)),
        child: Material(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: InkWell(
              splashColor: primaryColor,
              onTap: () => onClicked.call(),
              child: Container(
                child: Column(
                  children: [
                    Text('${model.title}'),
                    Text('${model.content}'),
                  ],
                ),
              ),
            )),
      );
}
