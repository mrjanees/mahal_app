import 'package:flutter/material.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/views/widgets/common/custom_image.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  Function backPress;
  final PreferredSizeWidget? bottom;
  CommonAppBar(
      {super.key, required this.backPress, required this.title, this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 80,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: CustomText(title),
      shadowColor: Colors.transparent,
      leading: InkWell(
        onTap: () => backPress(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: CustomSvgImage(
            imageName: 'back_button_icon',
            width: 20,
            height: 20,
          ),
        ),
      ),
      bottom: bottom,
    );
  }
}
