import 'package:flutter/material.dart';
import 'package:mahal_app/core/color.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Function onTap;
  final double? fontSize;
  bool? isLoading;
  CustomButton(
      {super.key,
      required this.onTap,
      required this.title,
      this.fontSize,
      this.titleColor,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: kSpace, vertical: 8),
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: isLoading == null
              ? CustomText(
                  title,
                  color: titleColor ?? AppColors.whiteColor,
                  fontSize: fontSize,
                )
              : isLoading!
                  ? const SizedBox(
                      height: 30,
                      child: CircularProgressIndicator(
                        color: AppColors.whiteColor,
                      ))
                  : CustomText(
                      title,
                      color: titleColor ?? AppColors.whiteColor,
                    )),
    );
  }
}
