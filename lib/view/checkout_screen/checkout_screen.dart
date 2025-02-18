import 'package:flutter/material.dart';
import 'package:zartek/view/checkout_screen/widgets/cart_item_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final List<String> items = List.generate(2, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3.0, // Add elevation here
        backgroundColor: Colors.white,
        shadowColor: Colors.black, // You can change shadow color here
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: const Color.fromARGB(
                  255, 146, 145, 145)), // Grey color for the icon
          onPressed: () {
            Navigator.pop(context); // Goes back to the previous screen
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "Order Summary",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(
                    255, 146, 145, 145) // Grey color for the title
                ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Container with border radius and shadow
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    // Shadow for bottom and right side (stronger shadow)
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(3, 3), // Shadow on bottom and right
                    ),
                    // Slight shadow for top and left side (weakened)
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(-3, -3), // Shadow on top and left
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    // Inner container with green background and text
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 25, 96, 26),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "2 dishes - 2 items",
                          style: TextStyle(
                            color: Colors.white, // White text color
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 20), // Add spacing between the two children
                    // ListView.builder as the second child inside the container
                    ListView.separated(
                      shrinkWrap: true, // Prevents infinite height error
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling within the ListView
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return CartItemCard();
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: Colors.grey,
                          thickness: 1,
                        );
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "INR 65.00",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.green),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 70),
              SizedBox(
                width: double.infinity, // Full width
                height: 50, // Fixed height
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 25, 96, 26), // Dark Green Color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // Handle Place Order action
                  },
                  child: Text(
                    "Place Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
