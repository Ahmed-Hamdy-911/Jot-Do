import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../models/message_type.dart';

class CustomSnackBar {
  static ContentType _mapToContentType(MessageType type) {
    switch (type) {
      case MessageType.success:
        return ContentType.success;
      case MessageType.info:
        return ContentType.help;
      case MessageType.warning:
        return ContentType.warning;
      case MessageType.error:
        return ContentType.failure;
      default:
        return ContentType.help;
    }
  }

  static void showSnackBar(
      String message, BuildContext context, MessageType messageType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        content: AwesomeSnackbarContent(
          title: _returnTitle(messageType, context),
          message: message,
          contentType: _mapToContentType(messageType),
        ),
      ),
    );
  }

  static String _returnTitle(MessageType type, BuildContext context) {
    switch (type) {
      case MessageType.success:
        return S.of(context).success;
      case MessageType.info:
        return S.of(context).info;
      case MessageType.warning:
        return S.of(context).warning;
      default:
        return S.of(context).error;
    }
  }
}
