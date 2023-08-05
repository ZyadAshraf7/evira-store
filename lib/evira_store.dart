import 'package:evira_store/core/app_router/route_names.dart';
import 'package:evira_store/presentation/cubits/bottom_navbar_cubit/bottom_nav_bar_cubit.dart';
import 'package:evira_store/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:evira_store/presentation/cubits/favourite_products_cubit/favourite_products_cubit.dart';
import 'package:evira_store/presentation/cubits/get_user_info/get_user_info_cubit.dart';
import 'package:evira_store/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:evira_store/presentation/cubits/login_user_cubit/login_user_cubit.dart';
import 'package:evira_store/presentation/cubits/register_user_cubit/register_user_cubit.dart';
import 'package:evira_store/presentation/screens/bottom_navbar_screen/bottom_navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/app_router/my_app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/shared_preference/user_preference.dart';

class EviraStore extends StatelessWidget {
  const EviraStore({Key? key,this.appRouter,this.initialRoute}) : super(key: key);
  final AppRouter? appRouter;
  final String? initialRoute;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterUserCubit(),
        ),
        BlocProvider(
          create: (context) => LoginUserCubit(),
        ),
        BlocProvider(
          create: (context) => BottomNavBarCubit(),
          child: const BottomNavBarScreen(),
        ),
        BlocProvider(create: (_) => HomeCubit()..fetchAllProductsWithLimit()),
        BlocProvider(create: (context) => FavouriteProductsCubit()..fetchUserFavouriteProducts()),
        BlocProvider(create: (_)=>CartCubit()),
        BlocProvider(create: (_) => GetUserInfoCubit()..getUserInfo()),

      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme,
          themeMode: ThemeMode.light,
          onGenerateRoute: appRouter!.onGenerateRoutes,
          initialRoute: UserPreferences.getUserToken() != ''
                ? RouteNames.bottomNavBarScreen
                : RouteNames.loginScreen,
            // initialRoute:RouteNames.bottomNavBarScreen,
        ),
      ),
    );
  }
}
