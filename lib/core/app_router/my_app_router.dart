import 'package:evira_store/core/app_router/route_names.dart';
import 'package:evira_store/data/models/product.dart';
import 'package:evira_store/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:evira_store/presentation/cubits/favourite_products_cubit/favourite_products_cubit.dart';
import 'package:evira_store/presentation/cubits/get_user_info/get_user_info_cubit.dart';
import 'package:evira_store/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:evira_store/presentation/cubits/onboarding_screens/onboarding_cubit.dart';
import 'package:evira_store/presentation/cubits/search_product_cubit/search_product_cubit.dart';
import 'package:evira_store/presentation/screens/auth_form/login_screen.dart';
import 'package:evira_store/presentation/screens/auth_form/register_screen.dart';
import 'package:evira_store/presentation/screens/bottom_navbar_screen/bottom_navbar_screen.dart';
import 'package:evira_store/presentation/screens/cart_screen/cart_screen.dart';
import 'package:evira_store/presentation/screens/cart_screen/checkout_screen.dart';
import 'package:evira_store/presentation/screens/details_screen/details_screen.dart';
import 'package:evira_store/presentation/screens/favourite_products_screen/favourite_products_screen.dart';
import 'package:evira_store/presentation/screens/home_screen/home_screen.dart';
import 'package:evira_store/presentation/screens/onboarding_screen/onboarding_screen.dart';
import 'package:evira_store/presentation/screens/profile_screen/privacy_and_policy.dart';
import 'package:evira_store/presentation/screens/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/screens/payment_screen/payment_screen.dart';

class AppRouter {
  Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.bottomNavBarScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => GetUserInfoCubit()..getUserInfo()),
              // BlocProvider(create: (_)=>GetAllProductsWithLimitsCubit()..fetchAllProductsWithLimit()),
            ],
            child: const BottomNavBarScreen(),
          ),
        );
      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteNames.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case RouteNames.onboardingScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => OnboardingCubit(),
                  child: const OnboardingScreen(),
                ));
      case RouteNames.detailsScreen:
        return MaterialPageRoute(builder: (_) => DetailsScreen(product: settings.arguments as Product),settings: settings);
      case RouteNames.favouriteProductsScreen:
        return MaterialPageRoute(builder: (_) =>  MultiBlocProvider(
          providers:[
            BlocProvider.value(value:  BlocProvider.of<HomeCubit>(_)),
          ],
        child: const FavouriteProductsScreen(),
      ));
      case RouteNames.searchScreen:
        return MaterialPageRoute(builder: (_) =>  MultiBlocProvider(
          providers: [
            BlocProvider.value(value: BlocProvider.of<HomeCubit>(_)),
            BlocProvider(create: (_)=>SearchProductCubit())
          ],
          child: const SearchScreen(),
        ));
      case RouteNames.privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyAndPolicy());
      case RouteNames.cartScreen:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case RouteNames.checkoutScreen:
        return MaterialPageRoute(builder: (_) => CheckoutScreen(objects: settings.arguments as List<Object>),settings: settings);
      case RouteNames.paymentScreen:
        return MaterialPageRoute(builder: (_) => PaymentScreen());
    }
    return null;
  }
}
