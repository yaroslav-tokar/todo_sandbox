import 'package:flutter/material.dart';
import 'package:todo_sandbox/core/constants/colors.dart';
import 'package:todo_sandbox/data/models/note_model.dart';

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
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(3)),
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
            ),
        child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            child: InkWell(
              splashColor: primaryColor,
              onTap: () => onClicked.call(),
              child: Column(
                children: <Widget>[
                  if (model.hasFilledTitle)
                    ListTile(
                        title: Text(model.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ))),
                  if (model.hasFilledContent)
                    ListTile(
                      title: Text(model.content,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          )),
                    )
                ],
              ),
            )),
      );
}
