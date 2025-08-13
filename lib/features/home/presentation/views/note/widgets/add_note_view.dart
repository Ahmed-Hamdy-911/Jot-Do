import 'package:flutter/material.dart';
import 'package:jot_do/generated/l10n.dart';

class AddNoteView extends StatelessWidget {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).add_note),
      ),
      body: Center(
        child: Text(S.of(context).add_note),
      ),
    );
  }
}
