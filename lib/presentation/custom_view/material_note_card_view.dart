import 'package:flutter/material.dart';
import 'package:todo_sandbox/core/util/logger.dart';
import 'package:todo_sandbox/data/models/note_model.dart';

class MaterialCardNoteView extends StatelessWidget {
  final NoteModel noteModel;
  final Function onClicked;

  const MaterialCardNoteView({
    Key? key,
    required this.noteModel,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onClicked.call(),

        child: Card(
          margin: const EdgeInsets.all(10),
          color: Colors.white,
          shadowColor: Colors.blueGrey,
          elevation: 3,
          child: Column(
            children: <Widget>[
              if (noteModel.hasFilledTitle)
                ListTile(
                    title: Text(noteModel.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ))),
              if (noteModel.hasFilledContent)
                ListTile(
                  title: Text(noteModel.content,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      )),
                )
            ],
          ),
        ),
      );
}
