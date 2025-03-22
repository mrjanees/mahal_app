import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mahal_app/bloc/login/login_bloc.dart';
import 'package:mahal_app/core/color.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/utils/snack_bar.dart';
import 'package:mahal_app/views/widgets/common/custom_botton.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';
import 'package:mahal_app/views/widgets/common/custom_text_form_field.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController userNameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kSpace),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              customSnackBar(context, state.message);
              context.go("/home");
            } else if (state is LoginFailure) {
              customSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            return Form(
              key: formGlobalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    "Login",
                    fontSize: 30,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomText("Please sign in to continue.",
                      color: AppColors.black54),
                  const SizedBox(
                    height: kSpace * 3,
                  ),
                  const CustomText(
                    "User name",
                    color: AppColors.black,
                  ),
                  CustomTextField(
                      textEditingController: userNameCtrl,
                      name: 'user name',
                      isThisFieldRequired: true),
                  const SizedBox(
                    height: kSpace,
                  ),
                  const CustomText(
                    "Password",
                    color: AppColors.black,
                  ),
                  CustomTextField(
                      textEditingController: passwordCtrl,
                      name: 'password',
                      isThisFieldRequired: true),
                  const SizedBox(
                    height: kSpace * 2,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      onTap: () {
                        if (formGlobalKey.currentState!.validate()) {
                          loginBloc.add(LoginRequested(userNameCtrl.text.trim(),
                              passwordCtrl.text.trim()));
                        }
                      },
                      title: "Login",
                      isLoading: state is LoginLoading ? true : false,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
