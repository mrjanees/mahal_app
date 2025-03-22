import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mahal_app/core/color.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/model/subscription/huse_details.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';

class SubscriptionTile extends StatelessWidget {
  const SubscriptionTile(
      {super.key,
      required this.subsData,
      this.collectionDate = '',
      this.familyHead = '',
      this.familyName = '',
      this.houseNo = ''});
  final Subscription subsData;
  final String collectionDate;
  final String familyHead;
  final String familyName;
  final String houseNo;
  @override
  Widget build(BuildContext context) {
    List<String> monthList = subsData.month
        .toString()
        .replaceAll("[", "") // Remove opening bracket
        .replaceAll("]", "") // Remove closing bracket
        .split(", ") // Split by comma and space
        .where((e) =>
            e.isNotEmpty) // Remove empty elements (in case of empty input)
        .map((e) => e.trim()) // Trim spaces if any
        .toList();

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(kSpace),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(0.1), // Shadow color with opacity
                spreadRadius: 1, // How much the shadow spreads
                blurRadius: 8, // Blur effect
                offset: const Offset(0, 3), // Shadow position (x, y)
              ),
            ],
          ),
          child: Column(
            children: [
              houseNo.isNotEmpty
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          "House No ",
                          color: AppColors.black38,
                        ),
                        CustomText(": $houseNo", color: AppColors.black),
                      ],
                    )
                  : const SizedBox(),
              familyName.isNotEmpty
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          "Fmaily Name ",
                          color: AppColors.black38,
                        ),
                        CustomText(": $familyName", color: AppColors.black),
                      ],
                    )
                  : const SizedBox(),
              familyHead.isNotEmpty
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          "Family Head ",
                          color: AppColors.black38,
                        ),
                        CustomText(": $familyHead", color: AppColors.black),
                      ],
                    )
                  : const SizedBox(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    "Type ",
                    color: AppColors.black38,
                  ),
                  CustomText(": ${subsData.type}", color: AppColors.black),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              subsData.date!.isNotEmpty
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          "Date ",
                          color: AppColors.black38,
                        ),
                        CustomText(": ${subsData.date}",
                            color: AppColors.black),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    "Month ",
                    color: AppColors.black38,
                  ),
                  Flexible(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      direction: Axis.horizontal,
                      children: monthList
                          .map(
                            (e) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kSpace),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.primaryColor),
                                child:
                                    CustomText(e, color: AppColors.whiteColor)),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    "Year ",
                    color: AppColors.black38,
                  ),
                  CustomText(": ${subsData.year}", color: AppColors.black),
                ],
              ),
              collectionDate.isNotEmpty
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          "Collected Date ",
                          color: AppColors.black38,
                        ),
                        CustomText(": $collectionDate", color: AppColors.black),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: kSpace),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.zero,
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  color: AppColors.primaryColor.withOpacity(0.7)),
              child: CustomText("₹ ${subsData.amount}",
                  fontSize: 25, color: AppColors.whiteColor)),
        )
      ],
    );
  }
}
