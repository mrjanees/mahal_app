import 'package:flutter/material.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';

void customSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: CustomText(
      text,
    )),
  );
}
