import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:zartek/core/color/color.dart';

import 'package:zartek/model/cart_item_model.dart';
import 'package:zartek/model/menu_model.dart';
import 'package:zartek/utils/screen_size_finder.dart';
import 'package:zartek/view/user_home_screen/widgets/counter_widget.dart';

class DishCard extends StatefulWidget {
  final Dish dish;
  const DishCard({super.key, required this.dish});

  @override
  State<DishCard> createState() => _DishCardState();
}

class _DishCardState extends State<DishCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/icons/veg_icon.png",
              color: widget.dish.isVeg ? AppColors.primaryColor : AppColors.red,
              width: 27,
              height: 27,
            ),
            SizedBox(
              width: screenWidth * .65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.dish.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "INR ${widget.dish.price}",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${widget.dish.calories} calories",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.dish.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CounterWidget(
                    cartItem: CartItemModel(
                      id: widget.dish.id,
                      name: widget.dish.name,
                      price: double.tryParse(widget.dish.price) ?? 0,
                      currency: widget.dish.currency.toString(),
                      calories: widget.dish.calories,
                      isVeg: widget.dish.isVeg,
                      quantity: 0,
                      totalDishPrice: 0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (widget.dish.customizationsAvailable)
                    const Text(
                      "Customizations Available",
                      style: TextStyle(color: AppColors.red),
                    ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.dish.imageUrl,
                width: 80,
                height: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/placeholder.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
