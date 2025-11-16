import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/services/app_session.dart';
import '../../../../../generated/l10n.dart';
import 'backup_option_item.dart';

class CopyButton extends StatefulWidget {
  const CopyButton({super.key, this.bgColor});
  final Color? bgColor;

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  bool _isCopied = false;
  Timer? _resetTimer;

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  Future<void> _copyCode() async {
    if (_isCopied) return; // ignore repeated taps while active
    final code = AppSession.instance.pendingRecoveryCode;
    if (code == null) return;
    try {
      await Clipboard.setData(ClipboardData(text: code));
      if (!mounted) return;
      setState(() => _isCopied = true);
      _resetTimer?.cancel();
      _resetTimer = Timer(const Duration(seconds: 3), () {
        if (!mounted) return;
        setState(() => _isCopied = false);
      });
    } catch (e) {
      // optional: show failure feedback
      if (mounted) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackupOptionItem(
      title: _isCopied
          ? S.of(context).recovery_code_copied
          : S.of(context).recovery_code_copy_button,
      bgColor: widget.bgColor,
      icon: _isCopied ? Icons.check_circle_outline_outlined : Icons.copy,
      onPressed: _isCopied ? null : _copyCode,
    );
  }
}
