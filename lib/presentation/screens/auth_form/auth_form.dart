import 'package:evira_store/core/theme/app_theme.dart';
import 'package:evira_store/presentation/widgets/custom_button.dart';
import 'package:evira_store/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthForm extends StatelessWidget {
  const AuthForm(
      {Key? key,
      required this.screenTitle,
      required this.buttonTitle,
      required this.onTap,
      required this.textButtonTitle,
      required this.emailController,
      required this.passwordController,
      required this.navigateOnTap,
      required this.userHasAccount, this.emailValidator, this.passwordValidator,required this.obsecure, })
      : super(key: key);

  final String screenTitle;
  final String buttonTitle;
  final String textButtonTitle;
  final String userHasAccount;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onTap;
  final VoidCallback navigateOnTap;
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? passwordValidator;
  final bool obsecure;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              screenTitle,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: AppTheme.grey900),
            ),
            const SizedBox(height: 50),
            CustomTextField(
              controller: emailController,
              hintText: "Email",
              iconPath: "assets/icons/Message.svg",
              obsecure: false,
              validator: emailValidator,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: passwordController,
              isPasswordField: true,
              obsecure: true,
              hintText: "Password",
              iconPath: "assets/icons/Lock.svg",
              validator: passwordValidator,
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(child: CustomButton(onTap: onTap, title: buttonTitle)),
              ],
            ),
            const SizedBox(height: 40),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 1,
                    width: 100,
                    color: AppTheme.grey200,
                  ),
                  Text(
                    "or continue with",
                    style: AppTheme.bodyXLargeSemiBold
                        .copyWith(color: AppTheme.grey700),
                  ),
                  Container(
                    height: 1,
                    width: 100,
                    color: AppTheme.grey200,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.grey200,
                    ),
                    borderRadius: BorderRadius.circular(16)),
                child: SvgPicture.asset("assets/icons/google.svg"),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userHasAccount,
                  style: AppTheme.bodyMediumRegular
                      .copyWith(color: AppTheme.grey500),
                ),
                TextButton(
                  onPressed: navigateOnTap,
                  child: Text(
                    textButtonTitle,
                    style: AppTheme.bodyMediumSemiBold.copyWith(color: AppTheme.primary500),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
