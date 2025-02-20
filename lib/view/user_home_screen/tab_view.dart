import 'package:flutter/material.dart';
import 'package:zartek/model/menu_model.dart';
import 'package:zartek/view/user_home_screen/widgets/dish_card.dart';

class TabView extends StatefulWidget {
  final Category category;

  const TabView({super.key, required this.category});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        shrinkWrap: true, 
        itemCount: widget.category.dishes.length,
        itemBuilder: (context, index) {
          return DishCard(dish: widget.category.dishes[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.grey,
            thickness: 1,
          );
        },
      ),
    );
  }
}
