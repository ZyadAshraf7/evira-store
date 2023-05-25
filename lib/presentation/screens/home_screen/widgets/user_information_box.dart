import 'package:evira_store/core/app_router/route_names.dart';
import 'package:evira_store/core/constants/app_strings.dart';
import 'package:evira_store/core/theme/app_theme.dart';
import 'package:evira_store/presentation/cubits/bottom_navbar_cubit/bottom_nav_bar_cubit.dart';
import 'package:evira_store/presentation/cubits/get_user_info/get_user_info_cubit.dart';
import 'package:evira_store/presentation/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserInformationBox extends StatelessWidget {
  const UserInformationBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<GetUserInfoCubit>(context);
    // cubit.getUserInfo();
    final user = cubit.currentUser;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 22),
      child: BlocBuilder<GetUserInfoCubit, GetUserInfoState>(
        builder: (context, state) {
          if(state is GetUserInfoLoading){
            return loadingSpinner();
          }
          if(state is GetUserInfoDone) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      BlocProvider.of<BottomNavBarCubit>(context).navigateScreens(3);
                    },
                    child: Row(
                      children: [
                        // image,
                        CircleAvatar(
                          radius: 30,
                          foregroundImage: NetworkImage(user.imageUrl??DEFAULT_USER_IMAGE),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Good Morning 👋 ",style: AppTheme.bodyLargeMedium.copyWith(color: AppTheme.grey600)),
                            const SizedBox(height: 6),
                            Text("${user.name}",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppTheme.grey900)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(onTap: (){
                  Navigator.of(context).pushNamed(RouteNames.favouriteProductsScreen);
                },child: SvgPicture.asset("assets/icons/Heart.svg")),
              ],
            );
          }
          if(state is GetUserInfoFailed){
            return const Text("SOMETHING WENT WRONG");
          }
          else{
            return SizedBox();
          }
        },
      ),
    );
  }
}
