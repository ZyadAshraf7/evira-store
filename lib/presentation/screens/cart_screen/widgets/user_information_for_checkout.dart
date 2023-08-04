import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/user.dart';

class UserInfoForCheckout extends StatelessWidget {
  const UserInfoForCheckout({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
        child: Row(
          children: [
            SvgPicture.asset("assets/icons/Profile_custom.svg"),
            const SizedBox(width: 18),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name??"",style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(user.phoneNumber??"",style: AppTheme.bodyMediumMedium.copyWith(color: AppTheme.grey700))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
