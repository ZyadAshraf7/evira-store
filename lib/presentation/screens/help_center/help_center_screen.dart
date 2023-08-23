import 'package:evira_store/presentation/screens/help_center/widgets/FAQ_body.dart';
import 'package:evira_store/presentation/screens/help_center/widgets/contact_us_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Change the length according to the number of tabs
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Help Center",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: AppTheme.primary500),
         ),
        bottom: TabBar(
            controller: _tabController,
            labelColor: AppTheme.primary500,
            labelStyle: AppTheme.bodyXLargeSemiBold,
            unselectedLabelColor: AppTheme.grey500,
            indicatorColor: AppTheme.primary500,
            indicatorWeight: 3,
            unselectedLabelStyle: AppTheme.bodyXLargeSemiBold,
            tabs: const [
          Tab(text: "FAQ"),
          Tab(text: "Contact us")
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FAQBody(),
          ContactUsBody()
        ],
      )
    );
  }
}
