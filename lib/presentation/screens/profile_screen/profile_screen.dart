import 'package:evira_store/core/app_router/route_names.dart';
import 'package:evira_store/core/constants/app_strings.dart';
import 'package:evira_store/core/theme/app_theme.dart';
import 'package:evira_store/presentation/cubits/get_user_info/get_user_info_cubit.dart';
import 'package:evira_store/presentation/cubits/register_user_cubit/register_user_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/shared_preference/user_preference.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<GetUserInfoCubit>(context);
    final user = cubit.currentUser;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: SvgPicture.asset("assets/icons/logo_black.svg",
              fit: BoxFit.scaleDown),
          title: Text("Profile", style: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(color: AppTheme.grey900)),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      foregroundImage: NetworkImage(user.imageUrl??DEFAULT_USER_IMAGE),
                      radius: 55,
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<RegisterUserCubit>(context)
                            .uploadProfilePicture();
                        //TODO: Update User Profile
                      },
                      child: SvgPicture.asset(
                        "assets/icons/Edit.svg",
                        fit: BoxFit.scaleDown,
                        width: 30,
                        height: 30,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Text(user.name ?? "",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppTheme.grey900)
                ),
                const SizedBox(height: 40),
                ListTile(
                  onTap: () {
                    // context.push(context.namedLocation(RouteNames.editProfileScreen),extra: user);
                  },
                  leading: SvgPicture.asset(
                    "assets/icons/Profile_unselected.svg",
                    colorFilter: const ColorFilter.mode(
                        AppTheme.grey900, BlendMode.srcIn),
                  ),
                  title: const Text("Edit Profile",
                      style: AppTheme.bodyXLargeSemiBold),
                  trailing: SvgPicture.asset("assets/icons/Arrow_Right.svg"),
                ),
                ListTile(
                  onTap: () {},
                  leading: SvgPicture.asset(
                    "assets/icons/Heart.svg",
                    colorFilter: const ColorFilter.mode(
                        AppTheme.grey900, BlendMode.srcIn),
                  ),
                  title:
                      const Text("Wishlist", style: AppTheme.bodyXLargeSemiBold),
                  trailing: SvgPicture.asset("assets/icons/Arrow_Right.svg"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteNames.privacyPolicy);
                  },
                  leading: SvgPicture.asset(
                    "assets/icons/Lock_stroke.svg",
                    colorFilter: const ColorFilter.mode(
                        AppTheme.grey900, BlendMode.srcIn),
                  ),
                  title: const Text("Privacy Policy",
                      style: AppTheme.bodyXLargeSemiBold),
                  trailing: SvgPicture.asset("assets/icons/Arrow_Right.svg"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteNames.helpCenterScreen);
                  },
                  leading: SvgPicture.asset(
                    "assets/icons/Info_Square.svg",
                    colorFilter: const ColorFilter.mode(
                        AppTheme.grey900, BlendMode.srcIn),
                  ),
                  title: const Text("Help Center",
                      style: AppTheme.bodyXLargeSemiBold),
                  trailing: SvgPicture.asset("assets/icons/Arrow_Right.svg"),
                ),
                ListTile(
                  onTap: () {
                    Share.share("Check out evira store");
                  },
                  leading: SvgPicture.asset(
                    "assets/icons/3_User.svg",
                    colorFilter: const ColorFilter.mode(
                        AppTheme.grey900, BlendMode.srcIn),
                  ),
                  title: const Text("Invite Friends",
                      style: AppTheme.bodyXLargeSemiBold),
                  trailing: SvgPicture.asset("assets/icons/Arrow_Right.svg"),
                ),
                ListTile(
                  onTap: ()async {
                    print("press");
                    await FirebaseAuth.instance.signOut();
                    await UserPreferences.setUserToken("");
                    Navigator.of(context)
                        .pushReplacementNamed(RouteNames.loginScreen);
                  },
                  leading: SvgPicture.asset(
                    "assets/icons/Logout.svg",
                  ),
                  title: Text("Logout",
                      style: AppTheme.bodyXLargeSemiBold.copyWith(color:AppTheme.error )),
                ),
              ],
            ),
          ),
        ));
  }
}
