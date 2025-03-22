import 'package:flutter/material.dart';
import 'package:mahal_app/core/color.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/views/widgets/common/custom_image.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';

class OptionTile extends StatelessWidget {
  final String title;
  final String icon;
  Function onTap;
  OptionTile(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: kSpace, vertical: 8),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSvgImage(
              imageName: icon,
              height: 30,
              width: 30,
            ),
            const SizedBox(
              width: kSpace,
            ),
            CustomText(
              title,
              color: AppColors.whiteColor,
            )
          ],
        ),
      ),
    );
  }
}
