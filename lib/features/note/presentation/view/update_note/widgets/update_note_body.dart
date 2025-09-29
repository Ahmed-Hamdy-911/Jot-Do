import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../data/models/note_model.dart';
import 'update_note_form.dart';

class UpdateNoteBody extends StatelessWidget {
  const UpdateNoteBody({
    super.key,
    required this.noteModel,
  });
  final NoteModel noteModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).edit),
        ),
        body: AbsorbPointer(
          absorbing: false,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: UpdateNoteForm(
                noteModel: noteModel,
              ),
            ),
          ),
        ));
  }
}
