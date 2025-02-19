// import 'package:flutter/material.dart';
// import 'package:zartek/model/menu_model.dart';
// import 'package:zartek/view/user_home_screen/widgets/counter_widget.dart';

// class DishCard extends StatefulWidget {
//   final Dish dish;
//   const DishCard({super.key, required this.dish});

//   @override
//   State<DishCard> createState() => _DishCardState();
// }

// class _DishCardState extends State<DishCard> {
//   @override
//   Widget build(BuildContext context) {
//     print(" iamge url is : ${widget.dish.imageUrl}");
//     double width = MediaQuery.of(context).size.width;
//     return Center(
//       child: Container(
//         padding: EdgeInsets.all(10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset(
//               "assets/icons/veg_icon.png",
//               color: widget.dish.isVeg ? Colors.green : Colors.red,
//               width: 27,
//               height: 27,
//             ),
//             SizedBox(
//               width: width * .65,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     child: Text(
//                       widget.dish.name,
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 5,
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Text(
//                         "INR ${widget.dish.price}",
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Spacer(),
//                       Text(
//                         "${widget.dish.calories} calories",
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   SizedBox(
//                     child: Text(
//                       widget.dish.description,
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 5,
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   CounterWidget(dish:widget.dish),
//                   SizedBox(height: 10),
//                   widget.dish.customizationsAvailable
//                       ? Text(
//                           "Customizations Available",
//                           style: TextStyle(color: Colors.red),
//                         )
//                       : SizedBox(),
//                 ],
//               ),
//             ),
//             Spacer(),
//             // Container wrapping the image with size and fit adjustments
//             Container(
//               width: 80,
//               height: 100,
//               decoration: BoxDecoration(
//                 borderRadius:
//                     BorderRadius.circular(8), // Optional: add rounded corners
//               ),
//               child: FittedBox(
//                 fit: BoxFit.fill,
//                 child: widget.dish.imageUrl.isNotEmpty
//                     ? Image.network(
//                         widget.dish.imageUrl,
//                         // "https://plus.unsplash.com/premium_photo-1701699258166-b14d782a4188?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//                         width: 80,
//                         height: 100,
//                         fit: BoxFit.cover,
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return const Center(
//                               child: CircularProgressIndicator());
//                         },
//                         errorBuilder: (context, error, stackTrace) =>
//                             Image.asset(
//                           "assets/images/placeholder.jpg", // Fallback image if URL fails
//                           fit: BoxFit.cover,
//                         ),
//                       )
//                     : Image.asset(
//                         "assets/images/placeholder.jpg",
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:zartek/model/cart_item_model.dart';
import 'package:zartek/model/menu_model.dart';
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
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/icons/veg_icon.png",
              color: widget.dish.isVeg ? Colors.green : Colors.red,
              width: 27,
              height: 27,
            ),
            SizedBox(
              width: width * .65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    child: Text(
                      widget.dish.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "INR ${widget.dish.price}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${widget.dish.calories} calories",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    child: Text(
                      widget.dish.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CounterWidget(
                    cartItem: CartItemModel(
                        id: widget.dish.id,
                        name: widget.dish.name,
                        price: widget.dish.price,
                        currency: widget.dish.currency.toString(),
                        calories: widget.dish.calories,
                        isVeg: widget.dish.isVeg,
                        quantity: 0),
                  ),
                  SizedBox(height: 10),
                  widget.dish.customizationsAvailable
                      ? Text(
                          "Customizations Available",
                          style: TextStyle(color: Colors.red),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            Spacer(),
            // Container wrapping the image with size and fit adjustments
            Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(8), // Optional: add rounded corners
              ),
              child: FittedBox(
                fit: BoxFit.fill,
                child: widget.dish.imageUrl.isNotEmpty
                    ? Image.network(
                        widget.dish.imageUrl,
                        // "https://plus.unsplash.com/premium_photo-1701699258166-b14d782a4188?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        width: 80,
                        height: 100,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          "assets/images/placeholder.jpg", // Fallback image if URL fails
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        "assets/images/placeholder.jpg",
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
