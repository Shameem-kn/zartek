import 'package:flutter/material.dart';
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
    print(" iamge url is : ${widget.dish.imageUrl}");
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
              color: Colors.red,
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
                  CounterWidget(cartItem: null,),
                  SizedBox(height: 10),
                  widget.dish.addons.isNotEmpty
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
