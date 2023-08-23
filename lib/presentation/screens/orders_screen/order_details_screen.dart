import 'package:easy_stepper/easy_stepper.dart';
import 'package:evira_store/presentation/cubits/orders_cubit/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/Order.dart';
import '../../cubits/cart_cubit/cart_cubit.dart';
import '../cart_screen/widgets/cart_product_card.dart';
import '../cart_screen/widgets/user_information_for_checkout.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SvgPicture.asset("assets/icons/logo_black.svg"),
            const SizedBox(width: 16),
            Text("Order Details",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: AppTheme.primary500)),
          ],
        ),
        actions: [
          TextButton(onPressed: (){
            showDialog(context: context, builder: (context)=>AlertDialog(
              title: Text("Cancel Order"),
              content: Text("Are you sure you want to cancel this order ?"),
              actions: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: const Text("No",style: TextStyle(color: AppTheme.grey700))),
                TextButton(onPressed: (){
                  context.read<OrdersCubit>().deleteOrder(order.orderId??"");
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }, child: const Text("Yes",style: TextStyle(color: AppTheme.error))),
              ],
            ));
          }, child: Text("Cancel Order",style: AppTheme.bodySmallBold.copyWith(color: AppTheme.error)))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0,right: 16,left: 16,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("ORDER ID - ${order.orderId}",style: AppTheme.bodyXLargeBold),
                    const SizedBox(height: 5),
                    Text("Placed on ${order.orderDate?.toDate().toString().substring(0,10)}",style: AppTheme.bodyMediumSemiBold.copyWith(color: AppTheme.primary200)),
                    const Divider(thickness: 2),
                    const SizedBox(height: 8),
                  ],
                ),
                Text("Shipping Address",style: AppTheme.bodyLargeBold.copyWith(color: AppTheme.grey700)),
                const SizedBox(height: 10),
                ListTile(
                  leading: SvgPicture.asset("assets/icons/Location.svg"),
                  title: Text(order.address??"",style: AppTheme.bodySmallSemiBold),
                ),
                const Divider(thickness: 2),
                const SizedBox(height: 10),
                Text("Personal Information",style: AppTheme.bodyLargeBold.copyWith(color: AppTheme.grey700)),
                const SizedBox(height: 10),
                UserInfoForCheckout(name: order.userName??"",phoneNumber: order.userPhoneNumber??""),
                const SizedBox(height: 10),
                const Divider(thickness: 2),
                const SizedBox(height: 10),
                Text("Track Your Order",style: AppTheme.bodyLargeBold.copyWith(color: AppTheme.grey700)),
                EasyStepper(direction: Axis.horizontal,
                    enableStepTapping: false,
                    disableScroll: true,
                    showTitle: true,
                    activeLineColor: AppTheme.primary400,
                    // borderThickness: 1,
                    defaultLineColor: AppTheme.grey500,

                    finishedStepBackgroundColor: Colors.transparent,
                    activeStep: 5, steps: [
                        EasyStep(
                          customStep: SvgPicture.asset("assets/icons/packed.svg"),
                          customTitle: const Center(child: Text("Processing",style: AppTheme.bodyMediumBold,)),
                        ),
                        EasyStep(
                            customStep: SvgPicture.asset("assets/icons/shipping.svg",color: (order.status=="shipped"||order.status=="delivered")?AppTheme.primary500:AppTheme.primary200,),
                          customTitle: Center(child: Text("Shipped",textAlign: TextAlign.center,style: AppTheme.bodyMediumBold.copyWith(color: (order.status=="shipped"||order.status=="delivered")?AppTheme.primary500:AppTheme.primary200),)),
                        ),
                        EasyStep(
                            customStep: SvgPicture.asset("assets/icons/delivered.svg",color:order.status=="delivered"?AppTheme.primary500:AppTheme.primary200),
                          customTitle: Center(child: Text("Delivered",textAlign: TextAlign.center,style: AppTheme.bodyMediumBold.copyWith(color: order.status=="delivered"?AppTheme.primary500:AppTheme.primary200),)),
                        ),
                  ]),
                // const SizedBox(height: 10),
                const Divider(thickness: 2),
                const SizedBox(height: 10),
                Text("Order Products",style: AppTheme.bodyLargeBold.copyWith(color: AppTheme.grey700)),
                ListView.builder(itemCount: order.orderProducts?.length,itemBuilder: (context,i){
                  return CartProductCard(product: order.orderProducts?[i],isCheckout: true,checkoutQuantity: order.orderProducts?[i].quantity);
                },physics: const NeverScrollableScrollPhysics(),shrinkWrap: true),
                const SizedBox(height: 10),
                const Divider(thickness: 2),
                const SizedBox(height: 10),
                Text("Order Summary",style: AppTheme.bodyLargeBold.copyWith(color: AppTheme.grey700)),
                const SizedBox(height: 5),
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
                            Text("\$${order.subTotal?.toStringAsFixed(2)}",style: AppTheme.bodyLargeSemiBold.copyWith(color: AppTheme.grey800))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Shipping",style: AppTheme.bodyMediumMedium.copyWith(color: AppTheme.grey700)),
                            Text("\$${order.shipping?.toStringAsFixed(2)}",style: AppTheme.bodyLargeSemiBold.copyWith(color: AppTheme.grey800))
                          ],
                        ),
                        const SizedBox(height: 20),
                        order.discount!=0?Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Promo Code",style: AppTheme.bodyMediumMedium.copyWith(color: Colors.green)),
                            Text("\$-${order.discount?.toStringAsFixed(2)}",style: AppTheme.bodyLargeBold.copyWith(color: Colors.green))
                          ],
                        ):const SizedBox(),
                        order.discount!=0?const SizedBox(height: 20):const SizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total",style: AppTheme.bodyMediumMedium.copyWith(color: AppTheme.grey700)),
                            Text("\$${(order.total)?.toStringAsFixed(2)}",style: AppTheme.bodyLargeSemiBold.copyWith(color: AppTheme.grey800))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
