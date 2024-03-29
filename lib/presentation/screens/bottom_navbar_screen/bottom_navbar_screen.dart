import 'package:evira_store/core/theme/app_theme.dart';
import 'package:evira_store/presentation/cubits/bottom_navbar_cubit/bottom_nav_bar_cubit.dart';
import 'package:evira_store/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:evira_store/presentation/cubits/favourite_products_cubit/favourite_products_cubit.dart';
import 'package:evira_store/presentation/cubits/orders_cubit/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
/*  @override
  void initState() {
      super.initState();
      BlocProvider.of<FavouriteProductsCubit>(context).fetchUserFavouriteProducts();

  }*/
  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    await BlocProvider.of<FavouriteProductsCubit>(context).fetchUserFavouriteProducts();
  }
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<BottomNavBarCubit>(context);
    return WillPopScope(
      onWillPop: (){
        return _onWillPop(context);
      },
      child: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
          if(state is CartIndexScreen){
            BlocProvider.of<CartCubit>(context).fetchUserCart();
          }
          if(state is OrdersIndexScreen){
            BlocProvider.of<OrdersCubit>(context).fetchUserOrders();
          }
          return Scaffold(
            body: cubit.screens[cubit.currentPage],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              unselectedLabelStyle:
                  AppTheme.bodyXSmallMedium,
              selectedLabelStyle:
                  AppTheme.bodyXSmallBold,
              currentIndex: cubit.currentPage,
              showSelectedLabels: true,
              showUnselectedLabels: true,

              selectedItemColor: AppTheme.grey900,
              unselectedItemColor: AppTheme.grey500,
              type: BottomNavigationBarType.shifting,
              onTap: cubit.navigateScreens,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/icons/Home_unselected.svg"),
                    activeIcon:
                        SvgPicture.asset("assets/icons/Home_selected.svg"),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/icons/Bag_unselected.svg"),
                    activeIcon: SvgPicture.asset("assets/icons/Bag_selected.svg"),
                    label: "Cart"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/icons/Buy_unselected.svg"),
                    activeIcon: SvgPicture.asset("assets/icons/Buy_selected.svg"),
                    label: "Orders"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/icons/Profile_unselected.svg"),
                    activeIcon: SvgPicture.asset("assets/icons/Profile.svg"),
                    label: "Profile"),
              ],
            ),
          );
        },
      ),
    );
  }
}
Future<bool> _onWillPop(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirm Exit'),
      content: const Text('Are you sure you want to exit?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No',style: TextStyle(color: AppTheme.grey700)),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes',style: TextStyle(color: AppTheme.error)),
        ),
      ],
    ),
  );
}