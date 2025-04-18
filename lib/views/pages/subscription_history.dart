import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/model/subscription/huse_details.dart';
import 'package:mahal_app/views/widgets/common/app_bar.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';
import 'package:mahal_app/views/widgets/common/subscription_tile.dart';

class SubscriptionHistory extends StatelessWidget {
  final List<Subscription> subscriptionList;
  const SubscriptionHistory({super.key, required this.subscriptionList});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(
            80,
          ),
          child: CommonAppBar(
            backPress: () {
              context.pop();
            },
            title: 'Subscription History',
          )),
      body: subscriptionList.isNotEmpty
          ? ListView.separated(
              padding: const EdgeInsets.all(kSpace),
              itemBuilder: (context, index) {
                final data = subscriptionList[index];
                return SubscriptionTile(
                  subsData: data,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: kSpace,
                  ),
              itemCount: subscriptionList.length)
          : const Center(
              child: CustomText("No Subscription History"),
            ),
    ));
  }
}
