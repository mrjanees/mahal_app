import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          errorStyle: disableErrorText
              ? const TextStyle(height: 0.01, color: Colors.transparent)
              : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 23, horizontal: 13),
          counterText: '',
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.red, width: strokeWidth)),
          errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.red, width: strokeWidth)),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey, width: strokeWidth)),
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey, width: strokeWidth)),
          hintText: name,
          hintStyle: TextStyle(color: Colors.grey, fontSize: hintTextSize),
        ),
      ),
    );
  }
}