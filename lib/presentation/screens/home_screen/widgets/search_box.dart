import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pushNamed(RouteNames.searchScreen);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: AppTheme.grey200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/icons/Search.svg"),
                const SizedBox(width: 12),
                Text("Search",
                    style: AppTheme.bodyMediumRegular
                        .copyWith(color: AppTheme.grey500))
              ],
            ),
            SvgPicture.asset("assets/icons/Filter.svg"),
          ],
        ),
      ),
    );
  }
}
