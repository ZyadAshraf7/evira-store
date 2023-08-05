import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira_store/core/app_router/route_names.dart';
import 'package:evira_store/data/models/user.dart';
import 'package:evira_store/presentation/cubits/register_user_cubit/register_user_cubit.dart';
import 'package:evira_store/presentation/widgets/custom_alert_dialog.dart';
import 'package:evira_store/presentation/widgets/custom_button.dart';
import 'package:evira_store/presentation/widgets/custom_text_field.dart';
import 'package:evira_store/presentation/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompleteUserRegister extends StatelessWidget {
  const CompleteUserRegister(
      {Key? key, required this.email, required this.password})
      : super(key: key);

  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<RegisterUserCubit>(context);
    print(email);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Center(
            child: Form(
          key: cubit.completeProfileFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  BlocBuilder<RegisterUserCubit, RegisterUserState>(
                    builder: (context, state) {
                      if (state is UploadPhotoLoading) {
                        return loadingSpinner();
                      }
                      return CircleAvatar(
                        radius: 60,
                        foregroundImage: NetworkImage(cubit.userImageUrl),
                      );
                    },
                  ),
                  GestureDetector(
                      onTap: () {
                        cubit.uploadProfilePicture();
                      },
                      child: SvgPicture.asset(
                        "assets/icons/Edit.svg",
                        fit: BoxFit.scaleDown,
                        width: 30,
                        height: 30,
                      ))
                ],
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: cubit.nameController,
                hintText: "Full Name",
                iconPath: "assets/icons/Profile.svg",
                obsecure: false,
                validator: (_) => cubit.validateName(cubit.nameController.text),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: cubit.phoneNumberController,
                hintText: "Phone Number",
                iconPath: "assets/icons/Call.svg",
                obsecure: false,
                validator: (_) => cubit.validatePhoneNumber(cubit.phoneNumberController.text),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: cubit.emailController,
                hintText: email,
                iconPath: "assets/icons/Message.svg",
                obsecure: false,
                readOnly: true,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: cubit.passwordController,
                hintText: password,
                iconPath: "assets/icons/Lock.svg",
                obsecure: false,
                readOnly: true,
              ),
              const SizedBox(height: 50),
              BlocBuilder<RegisterUserCubit, RegisterUserState>(
                builder: (context, state) {
                  if (state is CreateUserLoading) {
                    return loadingSpinner();
                  }
                  return Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                            onTap: () {
                              if (cubit.completeProfileFormKey.currentState!.validate()) {
                                print("email $email");
                                print("password $password");
                                print("name ${cubit.nameController.text}");
                                print("phone ${cubit.phoneNumberController.text}");
                                print("url ${cubit.userImageUrl}");
                                UserModel user = UserModel(
                                  name: cubit.nameController.text,
                                  email: email,
                                  password: password,
                                  phoneNumber: cubit.phoneNumberController.text,
                                  imageUrl: cubit.userImageUrl,
                                  cartProducts: [],
                                  favouriteProducts: []
                                );
                                cubit.createNewUser(user).then(
                                  (value) async {
                                    showDialog(
                                      context: context,
                                      builder: (context) => customAlertDialog(
                                        hasLoading: true,
                                          context: context,
                                          title: "Congratulations!",
                                          description:
                                              "Your account is ready to use. You will be redirected to the Home page in a few seconds..",
                                          imagePath:
                                              "assets/images/Group1.png"),
                                    );
                                    await Future.delayed(const Duration(seconds: 4));
                                    // Navigator.of(context).pop();
                                    Navigator.pushReplacementNamed(context, RouteNames.bottomNavBarScreen);
                                  },
                                );
                              }
                            },
                            title: "Continue"),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}
