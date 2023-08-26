import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class SpecialOffersBox extends StatelessWidget {
  const SpecialOffersBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 32,right: 12),
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppTheme.grey300,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("30%",style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppTheme.primary500)),
                  const SizedBox(height: 8),
                  Text("Today's Special!",style:Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  SizedBox(width: 150,child: const Text("Get discount for every order, only valid for today",style: AppTheme.bodySmallMedium))
                ],
              ),
            ),
          ),
          Flexible(flex:2,child: FittedBox(child: Image.asset("assets/images/offer2.png")))
        ],
      ),
    );
  }
}
