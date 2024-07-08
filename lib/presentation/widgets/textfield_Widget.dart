import 'package:flutter/material.dart';
import 'package:student_management_provider/core/constants.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    this.inputType,
    this.hintText,
    this.labelText,
    this.prefixicon,
    this.maxLength,
    this.validator,
    this.onChanged,
  });

  final TextEditingController controller;
  final TextInputType? inputType;
  final String? hintText;
  final String? labelText;
  final IconData? prefixicon;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        maxLength: maxLength,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Constants().appColor, width: 2)),
            hintText: hintText,
            labelText: labelText,
            prefixIcon: Icon(prefixicon)),
        controller: controller,
        keyboardType: inputType,
      ),
    );
  }
}
