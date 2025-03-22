import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mahal_app/bloc/subscription/subscription_bloc.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/views/pages/todays_collection.dart';
import 'package:mahal_app/views/widgets/common/app_bar.dart';
import 'package:mahal_app/views/widgets/common/custom_botton.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';
import 'package:mahal_app/views/widgets/common/custom_text_form_field.dart';
import 'package:mahal_app/views/widgets/dash_board.dart/option_tile.dart';

class Subscription extends StatelessWidget {
  final TextEditingController houNoCtrl = TextEditingController();
  Subscription({super.key});
  final formGlobalKey = GlobalKey<FormState>();
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
            title: 'House Subscription',
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpace),
        child: Form(
          key: formGlobalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OptionTile(
                  icon: "calendar",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => DateWiseCollection()));
                  },
                  title: "Today's Collection"),
              const SizedBox(
                height: 50,
              ),
              const CustomText("House No"),
              const SizedBox(
                height: 8,
              ),
              CustomTextField(
                  textEditingController: houNoCtrl,
                  name: 'House number',
                  isThisFieldRequired: true),
              const SizedBox(height: kSpace * 3),
              BlocConsumer<SubscriptionBloc, SubscriptionState>(
                  builder: (context, state) {
                    return Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                          onTap: () {
                            if (formGlobalKey.currentState!.validate()) {
                              context.read<SubscriptionBloc>().add(
                                  GetHouseDetails(
                                      houseNo: houNoCtrl.text.trim()));
                              context.push("/houseDetails");
                            }
                          },
                          title: 'Get',
                          isLoading:
                              state is HouseDetialsLoading ? true : false,
                        ));
                  },
                  listener: (context, state) {}),
            ],
          ),
        ),
      ),
    ));
  }
}
