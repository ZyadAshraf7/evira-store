import 'package:evira_store/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../FAQ_questions.dart';

class FAQBody extends StatelessWidget {
  const FAQBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: FAQs.length,
        itemBuilder: (context,i){
      return Card(
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ExpansionTile(
          textColor: AppTheme.primary500,
          iconColor: AppTheme.primary500,
maintainState: true,
          title: Text(FAQs[i].question,style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.grey900)),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                FAQs[i].answer,
                style: AppTheme.bodyMediumMedium.copyWith(color: AppTheme.grey800),
              ),
            ),
          ],
        ),
      );
    }, separatorBuilder: (BuildContext context, int index) {return const SizedBox(height: 24); },);
  }
}
