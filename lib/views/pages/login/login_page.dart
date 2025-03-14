import 'package:flutter/material.dart';
import 'package:mahal_app/core/color.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';
import 'package:mahal_app/views/widgets/common/custom_text_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            "Login",
            fontSize: 20,
            color: AppColors.black,
          ),
          SizedBox(
            height: kSpace,
          ),
          CustomText("Please sign in to continue.", color: AppColors.black54),
          SizedBox(
            height: kSpace * 3,
          ),
          // CustomTextField(textEditingController: , name: , isThisFieldRequired: )
        ],
      ),
    );
  }
}
