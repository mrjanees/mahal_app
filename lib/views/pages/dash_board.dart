import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mahal_app/core/apis.dart';
import 'package:mahal_app/core/color.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/model/subscription/subscription_add.dart';
import 'package:mahal_app/views/pages/prinitng.dart';
import 'package:mahal_app/views/widgets/common/custom_image.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';
import 'package:mahal_app/views/widgets/dash_board.dart/option_tile.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double
                    .infinity, // Ensures the parent container takes full width
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SizedBox(
                        width: double
                            .infinity, // Forces the SVG to take full width
                        child: CustomSvgImage(
                          imageName: 'dashboard_vector',
                        )),
                    const Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        CustomPngImage(
                          imageName: 'icon_image',
                          height: 100,
                          width: 100,
                        ),
                        CustomText(
                          mahalName,
                          textAlign: TextAlign.center,
                          color: AppColors.primaryColor,
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpace * 3),
                child: OptionTile(
                  icon: 'payment',
                  onTap: () {
                    context.push("/subscription");
                  },
                  title: 'Monthly House Subscription',
                ),
              ),
              const SizedBox(
                height: kSpace,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
