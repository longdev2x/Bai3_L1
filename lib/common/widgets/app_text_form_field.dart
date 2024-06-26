import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String? hintText;
  final bool? isPass;
  final bool? autofocus;
  final String? initialValue;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onSaved;
  final Function(String? value)? onChanged;
  final TextEditingController? controller;
  const AppTextFormField({
    super.key,
    this.hintText = "",
    this.isPass = false,
    this.validator,
    this.onChanged,
    this.initialValue,
    this.autofocus = false,
    this.controller,
    this.onSaved
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      onSaved: onSaved,
      obscureText: isPass!,
      initialValue: initialValue,
      autofocus: autofocus ?? false,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: _customOutline(borderColor: Colors.blue),
        focusedBorder: _customOutline(),
        errorBorder: _customOutline(borderColor: Colors.red),
        focusedErrorBorder: _customOutline(borderColor: Colors.red),
        disabledBorder: _customOutline(),
      ),
    );
  }

  OutlineInputBorder _customOutline({Color borderColor = Colors.black}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: borderColor,
      ),
    );
  }
}


class AppTextFieldNoborder extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final double? fontSize;
  final FontWeight? fontWeight;
  const AppTextFieldNoborder({super.key, this.controller, this.hintText, this.fontSize, this.fontWeight});
  @override
  Widget build(context) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      decoration: InputDecoration(
        hintText: hintText,
        border: _outlineInputBorder(),
        errorBorder: _outlineInputBorder(),
        enabledBorder: _outlineInputBorder(),
        focusedBorder: _outlineInputBorder(),
        focusedErrorBorder: _outlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide.none
    );
  }
}
