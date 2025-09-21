import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../generated/l10n.dart';
import '../constants/app_colors.dart';
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

  static void showToastification(
    context, {
    String? message,
    ToastificationType? type,
    List<InlineSpan>? children,
  }) {
    toastification.show(
      context: context,
      alignment: Alignment.bottomCenter,
      // backgroundColor: _returnCustomBGToastification(type!),
      applyBlurEffect: true,
      title: Text(
        _returnTitle(type, context),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _returnCustomBGToastification(type!),
        ),
      ),
      showProgressBar: true,
      description: RichText(
        text: TextSpan(children: [
          if (message != null)
            TextSpan(
              text: message,
              style: const TextStyle(fontSize: 13, color: Colors.black),
            ),
          ...(children ?? []),
        ]),
      ),
      type: type,
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _returnCustomBGToastification(type),
          ),
        ),
        child: Icon(
          _returnCustomIconToastification(type),
        ),
      ),
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
    );
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

  static IconData _returnCustomIconToastification(ToastificationType type) {
    IconData? iconData;
    switch (type) {
      case ToastificationType.success:
        iconData = Icons.done;
        break;
      case ToastificationType.error:
        iconData = Icons.close;
        break;
      case ToastificationType.warning:
        iconData = Icons.warning_amber_rounded;
        break;
      default:
        iconData = Icons.info;
    }
    return iconData;
  }

  static Color _returnCustomBGToastification(ToastificationType type) {
    Color? color;
    switch (type) {
      case ToastificationType.success:
        color = AppColor.greenColor;
        break;
      case ToastificationType.error:
        color = AppColor.redColor;
        break;
      case ToastificationType.warning:
        color = AppColor.amberDarkColor;
        break;
      default:
        color = AppColor.blueColor;
    }
    return color;
  }

  static String _returnTitle(type, BuildContext context) {
    switch (type) {
      case ToastificationType.success || MessageType.success:
        return S.of(context).success;
      case ToastificationType.info || MessageType.info:
        return S.of(context).info;
      case ToastificationType.warning || MessageType.warning:
        return S.of(context).warning;
      default:
        return S.of(context).error;
    }
  }
}
