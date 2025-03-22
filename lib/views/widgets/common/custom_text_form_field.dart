import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mahal_app/core/color.dart';

class CustomTextField extends StatelessWidget {
  bool isThisFieldRequired;
  int? maxLength;
  TextEditingController textEditingController;
  String name;
  TextAlign textAlign;
  TextInputType? keyboardType;
  void Function(String value)? onChanged;
  List<TextInputFormatter> textInputFormatter;
  String? Function(String value)? validator;
  double hintTextSize;
  double textSize;
  double strokeWidth;
  bool absorbingField;
  bool disableErrorText;
  bool textCenter;
  CustomTextField(
      {required this.textEditingController,
      required this.name,
      required this.isThisFieldRequired,
      this.disableErrorText = false,
      this.strokeWidth = 1,
      this.onChanged,
      this.hintTextSize = 15,
      this.textSize = 15,
      this.keyboardType,
      this.textAlign = TextAlign.start,
      this.textInputFormatter = const [],
      this.validator,
      this.absorbingField = false,
      this.maxLength,
      this.textCenter = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorbingField,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: textEditingController,
        textAlign: textAlign,
        validator: (value) {
          if (isThisFieldRequired) {
            if (validator != null) {
              return validator!(value!);
            } else if (value!.isEmpty) {
              return 'Enter the $name';
            } else {
              return null;
            }
          } else {
            return null;
          }
        },
        maxLength: maxLength,
        keyboardType: keyboardType,
        inputFormatters: textInputFormatter,
        onChanged: (value) => onChanged?.call(value),
        style: TextStyle(fontSize: textSize),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15)),
          fillColor: const Color.fromARGB(255, 225, 245, 252),
          filled: true,
          errorStyle: disableErrorText
              ? const TextStyle(height: 0.01, color: Colors.transparent)
              : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 13),
          counterText: '',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none, // Removes visible border when focused
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none, // Removes default border
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none
              // Show red border on error
              ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none
              // Show red border on focus error
              ),
          hintText: name,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: hintTextSize,
          ),
        ),
      ),
    );
  }
}
