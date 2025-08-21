import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/size_constants.dart';
import '../../theme/theme_manager.dart';

class InputTextFieldRounded extends StatelessWidget {
  TextInputType? keyboardType;
  int? maxLines = 1;
  int? maxLength;
  String hintText;
  String? errorText;
  ValueChanged<String>? onChange;
  TextEditingController? controller;
  bool? obscureText;

  InputTextFieldRounded(this.keyboardType, this.maxLines, this.maxLength, this.hintText,
      this.obscureText, this.controller, this.errorText, this.onChange);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: context.textTheme.bodyLarge,
      onChanged: onChange,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.grey100,
        hintText: hintText,
        errorText: errorText != null ? '$errorText' : null,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 2.0, color: Colors.white),
        ),
        errorStyle: const TextStyle(color: Colors.red),
        counter: SizedBox(
          width: SizeConstants.size0,
          height: SizeConstants.size0,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 2.0, color: Colors.white),
        ),
      ),
    );
  }
}
