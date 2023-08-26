import 'package:evira_store/presentation/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:evira_store/presentation/cubits/get_user_info/get_user_info_cubit.dart';
import 'package:evira_store/presentation/widgets/custom_button.dart';
import 'package:evira_store/presentation/widgets/custom_text_field.dart';
import 'package:evira_store/presentation/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/user.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EditProfileCubit>(context);
    cubit.nameController.text = user.name!;
    cubit.passwordController.text = user.password!;
    cubit.phoneNumberController.text = user.phoneNumber!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Edit Profile",
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: AppTheme.grey900)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocListener<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileDone) {

          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12),
            child: Form(
              key: cubit.editProfileFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: cubit.nameController,
                    hintText: "Name",
                    iconPath: "assets/icons/Profile_unselected.svg",
                    obsecure: false,
                    validator: (_) =>
                        cubit.validateName(cubit.nameController.text),
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                      controller: TextEditingController(),
                      readOnly: true,
                      hintText: user.email!,
                      iconPath: "assets/icons/Message_outlined.svg",
                      obsecure: false),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: cubit.passwordController,
                    hintText: "Password",
                    iconPath: "assets/icons/Lock_stroke.svg",
                    obsecure: true,
                    isPasswordField: true,
                    validator: (_) =>
                        cubit.validatePassword(cubit.passwordController.text),
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: cubit.passwordConfirmController,
                    hintText: "Confirm Password",
                    iconPath: "assets/icons/Lock_stroke.svg",
                    obsecure: true,
                    isPasswordField: true,
                    validator: (_) =>
                        cubit.validateConfirmPassword(
                            cubit.passwordController.text,
                            cubit.passwordConfirmController.text),
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: cubit.phoneNumberController,
                    hintText: "Phone Number",
                    iconPath: "assets/icons/Call_stroke.svg",
                    obsecure: false,
                    validator: (_) =>
                        cubit.validatePhoneNumber(
                            cubit.phoneNumberController.text),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      BlocBuilder<EditProfileCubit, EditProfileState>(
                        builder: (context, state) {
                          if (state is EditProfileLoading) {
                            return loadingSpinner();
                          }
                          return Expanded(
                              child: CustomButton(
                                  onTap: () {
                                    if (cubit.editProfileFormKey.currentState!.validate()) {
                                      cubit.editProfile().then((value){
                                        context.read<GetUserInfoCubit>().getUserInfo();
                                      }).then((value){
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(
                                            "Profile Updated Successfully"
                                        )));
                                      });
                                    }
                                  },
                                  title: "Update"),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
