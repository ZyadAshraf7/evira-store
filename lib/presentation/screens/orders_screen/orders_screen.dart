import 'package:evira_store/core/theme/app_theme.dart';
import 'package:evira_store/data/models/Order.dart';
import 'package:evira_store/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/orders_cubit/orders_cubit.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            final ordersCubit = context.read<OrdersCubit>();
            List<OrderModel> userOrders = ordersCubit.userOrders;
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder:(context,i){
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      height: 200,
                      color: AppTheme.grey200,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              print("pressed");
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Order ${userOrders[i].orderId}",style: AppTheme.bodyMediumBold),
                                    const SizedBox(height: 3),
                                    Text("Placed on ${userOrders[i].orderDate?.toDate().toString().substring(0,10)}",style: AppTheme.bodyMediumSemiBold.copyWith(color: AppTheme.primary200)),
                                  ],
                                ),
                                const Text("View Details >",style: AppTheme.bodySmallBold,)
                              ],
                            ),
                          ),
                          const Divider(thickness: 2),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 100,
                            child: ListView.separated(
                              shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: userOrders[i].orderProducts!.length,
                                itemBuilder: (context,j){
                                  var orderProducts = userOrders[i].orderProducts;
                                  return Row(
                                    children: [
                                      SizedBox(child: Image.network(orderProducts?[j].image??"")),
                                      const SizedBox(width: 10),
                                      SizedBox(width: 150,child: Text(orderProducts?[j].title??"",maxLines: 2,overflow: TextOverflow.ellipsis)),
                                    ],
                                  );
                            }, separatorBuilder: (BuildContext context,_) {return const SizedBox(width: 10); },),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: ordersCubit.userOrders.length,
                  separatorBuilder: (context,_)=>const SizedBox(height: 12),
                ),
              ),
            );
          },
        )
    );
  }
}
