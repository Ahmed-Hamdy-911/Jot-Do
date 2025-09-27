import 'package:flutter/material.dart';

import 'components.dart';
import 'custom_material_button.dart';

Future<void> showMultiSelectBottomSheet(
  BuildContext context, {
  required String title,
  required List<String> options,
  required void Function(List<String> selected) onConfirm,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag Handle
                Divider(
                  thickness: 5,
                  color: Colors.grey.shade300,
                  indent: MediaQuery.of(context).size.width * 0.35,
                  endIndent: MediaQuery.of(context).size.width * 0.35,
                ),
                const SizedBox(height: 10),
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  height: 20,
                  color: Colors.grey[300],
                ),

                 AppComponents.smallVerticalSpace(),

                CustomMaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Confirm",
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
