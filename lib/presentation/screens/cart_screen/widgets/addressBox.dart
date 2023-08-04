import 'package:evira_store/core/app_router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_theme.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({Key? key, required this.address}) : super(key: key);
  final String address;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 4,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushNamed(RouteNames.selectLocationScreen);
        },
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/location_address.svg"),
                  const SizedBox(width: 18),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Home",style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text(address,style: AppTheme.bodyMediumMedium.copyWith(color: AppTheme.grey700))
                    ],
                  ),
                ],
              ),
              InkWell(onTap: (){

              },child: SvgPicture.asset("assets/icons/Edit_outline.svg")),
            ],
          ),
        ),
      ),
    );
  }
}
