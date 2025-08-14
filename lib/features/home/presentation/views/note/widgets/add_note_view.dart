import 'package:flutter/material.dart';
import 'package:jot_do/core/constants/constant.dart';
import 'package:jot_do/generated/l10n.dart';
import 'note_form.dart';

class AddNoteView extends StatelessWidget {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).add_note),
          backgroundColor: AppConstants.addNoteBGColor,
          surfaceTintColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: NoteForm(),
          ),
        ));
  }
}
