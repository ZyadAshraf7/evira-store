import 'package:evira_store/core/app_router/route_names.dart';
import 'package:evira_store/core/constants/promo_codes.dart';
import 'package:evira_store/data/models/Order.dart';
import 'package:evira_store/presentation/cubits/bottom_navbar_cubit/bottom_nav_bar_cubit.dart';
import 'package:evira_store/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:evira_store/presentation/cubits/get_user_info/get_user_info_cubit.dart';
import 'package:evira_store/presentation/cubits/orders_cubit/orders_cubit.dart';
import 'package:evira_store/presentation/screens/cart_screen/widgets/addressBox.dart';
import 'package:evira_store/presentation/screens/cart_screen/widgets/cart_product_card.dart';
import 'package:evira_store/presentation/screens/cart_screen/widgets/user_information_for_checkout.dart';
import 'package:evira_store/presentation/widgets/custom_alert_dialog.dart';
import 'package:evira_store/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/product.dart';
import '../../../data/models/user.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key, required this.objects}) : super(key: key);
  final List<Object> objects;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController promoController = TextEditingController();
  double discount = 0;
  bool? validPromoCode;
  late int selectedRadioTile;

  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    // UserModel user = widget.objects[1] as UserModel;
    List<Product> cartList = widget.objects[0] as List<Product>;
    double shippingFees = 25;
/*
    print(cartList.first.title);*/
    final UserModel user = BlocProvider.of<GetUserInfoCubit>(context).currentUser;
    print(user.email);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Checkout", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppTheme.primary500)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text("Shipping Address",style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 24),
              (user.address!=null&&user.address!.isNotEmpty)?
                  BlocBuilder<GetUserInfoCubit,GetUserInfoState>(builder: (context,state){
                    return AddressBox();
                  },):
              Center(child: TextButton(onPressed: (){}, child: Text("+ Add Address",style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppTheme.primary500)))),
              const SizedBox(height: 24),
              Text("Your Information",style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 24),
              UserInfoForCheckout(user: user),
              const SizedBox(height: 24),
              Text("Your Order",style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 24),
              ListView.builder(itemCount: cartList.length,itemBuilder: (context,i){
                return CartProductCard(product: cartList[i],isCheckout: true,checkoutQuantity: cartList[i].quantity);
              },physics: const NeverScrollableScrollPhysics(),shrinkWrap: true),
              const SizedBox(height: 24),
              Text("Promo Code",style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        onFieldSubmitted: (v){
                          setState(() {
                            bool valid = promoCodes.containsKey(promoController.text);
                            if(valid){
                              validPromoCode = true;
                              double? percent = promoCodes[promoController.text];
                              // final newPercent = 100 - percent!;
                              discount = BlocProvider.of<CartCubit>(context).totalPrice*(percent!/100);
                            }else{
                              validPromoCode = false;
                            }
                          });
                        },
                        controller: promoController,
                    decoration: const InputDecoration(
                      hintText: "Enter Promo Code"
                    ),
                  )),
                  ElevatedButton(onPressed: (){
                    setState(() {
                      bool valid = promoCodes.containsKey(promoController.text);
                      if(valid){
                        validPromoCode = true;
                        double? percent = promoCodes[promoController.text];
                        // final newPercent = 100 - percent!;
                        discount = BlocProvider.of<CartCubit>(context).totalPrice*(percent!/100);
                      }else{
                        validPromoCode = false;
                      }
                    });
                  }, style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), backgroundColor: AppTheme.primary500,
                    padding: const EdgeInsets.all(12.0),
                  ),
                    child:const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  )
                ],
              ),
              (validPromoCode == true)? Text("Hooray! Your promo code is valid!",style: AppTheme.bodyLargeSemiBold.copyWith(color: Colors.green)):(validPromoCode == false)
                  ? Text("Oops! The promo code you entered is invalid",style: AppTheme.bodyLargeSemiBold.copyWith(color: Colors.red)):const SizedBox(),
              const SizedBox(height: 18),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Amount",style: AppTheme.bodyMediumMedium.copyWith(color: AppTheme.grey700)),
                          Text("\$${BlocProvider.of<CartCubit>(context).totalPrice.toStringAsFixed(2)}",style: AppTheme.bodyLargeSemiBold.copyWith(color: AppTheme.grey800))
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Shipping",style: AppTheme.bodyMediumMedium.copyWith(color: AppTheme.grey700)),
                          Text("\$${shippingFees.toStringAsFixed(2)}",style: AppTheme.bodyLargeSemiBold.copyWith(color: AppTheme.grey800))
                        ],
                      ),
                      const SizedBox(height: 20),
                      validPromoCode==true?Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Promo Code",style: AppTheme.bodyMediumMedium.copyWith(color: Colors.green)),
                          Text("\$-${discount.toStringAsFixed(2)}",style: AppTheme.bodyLargeBold.copyWith(color: Colors.green))
                        ],
                      ):const SizedBox(),
                      validPromoCode==true?const SizedBox(height: 20):const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total",style: AppTheme.bodyMediumMedium.copyWith(color: AppTheme.grey700)),
                          Text("\$${(BlocProvider.of<CartCubit>(context).totalPrice + shippingFees - discount).toStringAsFixed(2)}",style: AppTheme.bodyLargeSemiBold.copyWith(color: AppTheme.grey800))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: CustomButton(onTap: ()async{
                    // Navigator.of(context).pushNamed(RouteNames.paymentScreen);
                    final subTotal = BlocProvider.of<CartCubit>(context).totalPrice;
                    final total = BlocProvider.of<CartCubit>(context).totalPrice + shippingFees - discount;
                    OrderModel order = OrderModel(orderProducts: cartList, userName: user.name, userEmail:
                    user.email, userPhoneNumber: user.phoneNumber, subTotal: subTotal, shipping: shippingFees, discount: discount, total: total);
                    await BlocProvider.of<OrdersCubit>(context).addOrder(order);
                    showDialog(context: context, builder: (context)=>
                        customAlertDialog(context: context, title: "Order Successful!",
                          description: "You have successfully made order", imagePath: "assets/images/cart_icon.png",hasLoading: false,
                          body: Row(
                            children: [
                              Expanded(child: CustomButton(onTap: ()async{

                               /* Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                context.read<BottomNavBarCubit>().navigateScreens(2);*/
                              }, title: "View Order"))
                            ],
                          )
                        ));
                  }, title: "Place an Order")),
                ],
              ),
              const SizedBox(height: 12)
            ],
          ),
        ),
      ),
    );
  }
}

