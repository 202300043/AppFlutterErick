import 'package:flutter/cupertino.dart';

import '../theme.dart';

class CampoTexto extends StatelessWidget {
  const CampoTexto({
    super.key,
    required this.controller,
    required this.placeholder,
    this.focusNode,
    this.keyboardType,
    this.obscureText = false,
    this.textColor,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String placeholder;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? textColor;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      placeholder: placeholder,
      placeholderStyle: const TextStyle(color: AppColors.textSecondary),
      style: TextStyle(color: textColor ?? AppColors.textPrimary),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
