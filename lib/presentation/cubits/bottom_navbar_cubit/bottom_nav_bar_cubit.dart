import 'package:bloc/bloc.dart';
import 'package:evira_store/presentation/screens/cart_screen/cart_screen.dart';
import 'package:evira_store/presentation/screens/orders_screen/orders_screen.dart';
import 'package:evira_store/presentation/screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../screens/home_screen/home_screen.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInitial());

  int currentPage = 0;
  List <Widget> screens = [
    const HomeScreen(),
    const CartScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  navigateScreens(int index){
    currentPage = index;
    emit(BottomNavBarScreenChange());
    if(index == 1){
      emit(CartIndexScreen());
    }
    else if(index == 2){
      emit(OrdersIndexScreen());
    }

  }
}
