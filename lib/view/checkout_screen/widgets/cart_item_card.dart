import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zartek/model/cart_item_model.dart';
import 'package:zartek/view/user_home_screen/widgets/dish_card.dart';

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
    double width = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SvgPicture.asset(
            //   "assets/icons/veg.svg", // Ensure this file exists
            //   height: screenHeight * 0.2, // 20% of screen height
            // ),
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
                  width: width * .3,
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
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 71, 71, 71),
                  ),
                ),
                Text(
                  "${widget.cartItem.calories} calories",
                  style: TextStyle(
                    fontSize: 13,
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
            Text(widget.cartItem.price),

            // Container wrapping the image with size and fit adjustments
          ],
        ),
      ),
    );
  }
}
