import 'package:evira_store/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsBody extends StatelessWidget {
  const ContactUsBody({Key? key}) : super(key: key);

  _launchSocialMedia(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong",style: TextStyle(color: Colors.white),),backgroundColor: AppTheme.error));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ContactusCard(title: "Website",iconPath: "assets/icons/website.svg",onTap: (){
              _launchSocialMedia("https://github.com/ZyadAshraf7/evira-store");
            }),
            ContactusCard(title: "WhatsApp",iconPath: "assets/icons/whatsapp.svg",onTap: (){}),
            ContactusCard(title: "Facebook",iconPath: "assets/icons/facebook.svg",onTap: (){
              _launchSocialMedia("https://www.facebook.com/ashraf.harfosh.5");
            }),
            ContactusCard(title: "Instagram",iconPath: "assets/icons/instagram.svg",onTap: (){
              _launchSocialMedia("https://www.instagram.com/___ziadashraf___/");
            }),
            ContactusCard(title: "Twitter",iconPath: "assets/icons/twitter.svg",onTap: (){
              _launchSocialMedia("https://twitter.com/PRO_Xiad");
            }),
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
