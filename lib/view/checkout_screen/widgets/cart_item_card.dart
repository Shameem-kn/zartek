import 'package:flutter/material.dart';

import 'package:zartek/model/cart_item_model.dart';
import 'package:zartek/utils/screen_size_finder.dart';

import '../../user_home_screen/widgets/counter_widget.dart';

class CartItemCard extends StatefulWidget {
  final CartItemModel cartItem;
  const CartItemCard({super.key, required this.cartItem});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/icons/veg_icon.png",
              color: widget.cartItem.isVeg ? Colors.green : Colors.red,
              width: 27,
              height: 27,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: screenWidth * .3,
                  child: Text(
                    widget.cartItem.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 71, 71, 71),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 5,
                ),
                Text(
                  ("INR ${widget.cartItem.price}"),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 71, 71, 71),
                  ),
                ),
                Text(
                  "${widget.cartItem.calories} calories",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 71, 71, 71),
                  ),
                )
              ],
            ),
            CounterWidget(
              color: const Color.fromARGB(255, 25, 96, 26),
              cartItem: widget.cartItem,
            ),
            Text(
              "INR ${widget.cartItem.totalDishPrice.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 71, 71, 71),
              ),
            ),

            // Container wrapping the image with size and fit adjustments
          ],
        ),
      ),
    );
  }
}
