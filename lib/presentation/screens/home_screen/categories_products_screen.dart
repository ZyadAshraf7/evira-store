import 'package:flutter/material.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(title),
      ) ,
    );
  }
}
