import 'package:flutter/material.dart';
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
        child: SizedBox(
          child: Card(
            margin: const EdgeInsets.all(10),
            color: Colors.green[100],
            shadowColor: Colors.blueGrey,
            elevation: 3,
            child: Column(
              children: <Widget>[
                ListTile(title: Text(noteModel.title)),
                ListTile(title: Text(noteModel.content))
              ],
            ),
          ),
        ),
      );
}
