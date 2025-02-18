import 'package:flutter/material.dart';
import 'package:zartek/view/user_home_screen/widgets/counter_widget.dart';

class DishCard extends StatefulWidget {
  const DishCard({super.key});

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
                      "Traditional New England Seafood Chowder",
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
                        "INR 175",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "15 calories",
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
                      "hi all, its max gonna be a 2 line always. No matter how long it is",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CounterWidget(),
                  SizedBox(height: 10),
                  Text(
                    "Customizations Available",
                    style: TextStyle(color: Colors.red),
                  )
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.asset(
                  "assets/images/salad.jpg",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
