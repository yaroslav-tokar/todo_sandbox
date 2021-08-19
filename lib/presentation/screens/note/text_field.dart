import 'package:flutter/material.dart';
import 'package:todo_sandbox/presentation/screens/note/style.dart';

class NoteEditTextField extends StatelessWidget {
  final String etName;
  final TextEditingController controller;
  final double? height;

  const NoteEditTextField({
    Key? key,
    required this.etName,
    required this.controller,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isTitle = etName.toLowerCase() == 'title';
    final String hintText = isTitle ? 'Title' : 'Content';

    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.grey,
        style: TextStyle(
            fontSize: isTitle ? noteTitleFontSize : noteContentFontSize,
            color: Colors.black),
        decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: isTitle ? noteTitleFontSize : noteContentFontSize,
              color: Colors.black38,
            ),
            enabledBorder: InputBorder.none),
        maxLines: isTitle ? 1 : 25,
      ),
    );
  }
}
