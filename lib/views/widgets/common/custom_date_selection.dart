import 'package:flutter/material.dart';
import 'package:mahal_app/core/color.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/views/widgets/common/custom_image.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';

class CustomDateSelection extends StatelessWidget {
  const CustomDateSelection(
      {super.key, required this.onTap, required this.title});
  final Function onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(kSpace),
        decoration: BoxDecoration(
            color: AppColors.softPrimaryColor,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            CustomText(
              title,
              color: AppColors.black38,
            ),
            const SizedBox(
              width: kSpace,
            ),
            CustomSvgImage(
              imageName: 'calendar',
              color: AppColors.primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
