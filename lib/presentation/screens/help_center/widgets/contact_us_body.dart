import 'package:evira_store/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContactUsBody extends StatelessWidget {
  const ContactUsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ContactusCard(title: "Website",iconPath: "assets/icons/website.svg",onTap: (){}),
            ContactusCard(title: "WhatsApp",iconPath: "assets/icons/whatsapp.svg",onTap: (){}),
            ContactusCard(title: "Facebook",iconPath: "assets/icons/facebook.svg",onTap: (){}),
            ContactusCard(title: "Instagram",iconPath: "assets/icons/instagram.svg",onTap: (){}),
            ContactusCard(title: "Twitter",iconPath: "assets/icons/twitter.svg",onTap: (){}),
          ],
        ),
      ),
    );
  }
}

class ContactusCard extends StatelessWidget {
  const ContactusCard({
    super.key, required this.title, required this.iconPath, this.onTap,
  });
  final String title;
  final String iconPath;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom:24 ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        title: Text(title,style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.primary500)),
        leading: SvgPicture.asset(iconPath),
      )
    );
  }
}
