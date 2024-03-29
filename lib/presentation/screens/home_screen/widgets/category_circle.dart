import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

class CategoryCircle extends StatelessWidget {
  const CategoryCircle({
    super.key, required this.iconPath, required this.title,
  });
  final String iconPath;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            Navigator.of(context).pushNamed(RouteNames.categoryProductsScreen,arguments: title.toLowerCase());
          },
          child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.grey200,
              ),
              child:SvgPicture.asset(iconPath)
          ),
        ),
        const SizedBox(height: 12),
        Text(title,style: AppTheme.bodyLargeBold,)
      ],
    );
  }
}
