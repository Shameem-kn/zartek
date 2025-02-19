// // // import 'package:flutter/material.dart';
// // // import 'package:flutter/widgets.dart';

// // // class CounterWidget extends StatefulWidget {
// // //   final Color? color;
// // //   const CounterWidget({super.key, this.color});

// // //   @override
// // //   State<CounterWidget> createState() => _CounterWidgetState();
// // // }

// // // class _CounterWidgetState extends State<CounterWidget> {
// // //   int _count = 0;

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     Size size = MediaQuery.of(context).size;

// // //     print("build counter page");
// // //     return Container(
// // //       // width: size.width * .29,
// // //       width: 110,
// // //       height: 35,
// // //       padding: EdgeInsets.only(top: 5, bottom: 5), // Top and bottom padding
// // //       // Counter container with green background
// // //       decoration: BoxDecoration(
// // //         color: widget.color ?? Colors.green, // Green background for the counter
// // //         borderRadius: BorderRadius.circular(30), // Rounded corners
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black26, // Shadow color
// // //             offset: Offset(0, 4), // Shadow position
// // //             blurRadius: 8, // Shadow blur
// // //           ),
// // //         ],
// // //       ),
// // //       child: Row(
// // //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //         mainAxisSize: MainAxisSize.max,
// // //         children: [
// // //           IconButton(
// // //             padding: EdgeInsets.all(0),
// // //             onPressed: () {
// // //               setState(() {
// // //                 if (_count > 0) _count--; // Prevent negative values
// // //               });
// // //             },
// // //             icon: Icon(Icons.remove),
// // //             color: Colors.white, // White color for the icon
// // //           ),
// // //           Text(
// // //             '$_count',
// // //             style: TextStyle(
// // //               fontSize: 16,
// // //               fontWeight: FontWeight.bold,
// // //               color: Colors.white, // White color for the counter number
// // //             ),
// // //           ),
// // //           IconButton(
// // //             padding: EdgeInsets.all(0),
// // //             onPressed: () {
// // //               setState(() {
// // //                 _count++;
// // //               });
// // //             },
// // //             icon: Icon(Icons.add),
// // //             color: Colors.white, // White color for the icon
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek/bloc/cart/cart_bloc.dart';
import 'package:zartek/bloc/cart/cart_event.dart';
import 'package:zartek/bloc/cart/cart_state.dart';
import 'package:zartek/model/cart_item_model.dart';

class CounterWidget extends StatelessWidget {
  final CartItemModel cartItem;
  final Color? color;

  const CounterWidget({super.key, required this.cartItem, this.color});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        // Get the quantity directly from the Bloc state
        int count = state.cartItems.any((item) => item.id == cartItem.id)
            ? state.cartItems
                .firstWhere((item) => item.id == cartItem.id)
                .quantity
            : 0;

        return Container(
          width: 110,
          height: 35,
          decoration: BoxDecoration(
            color: color ?? Colors.green,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: count > 0
                    ? () {
                        context.read<CartBloc>().add(
                              UpdateQuantity(
                                  cartItem: cartItem, quantity: count - 1),
                            );
                      }
                    : null,
                icon: Icon(Icons.remove, color: Colors.white),
              ),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.read<CartBloc>().add(
                        UpdateQuantity(cartItem: cartItem, quantity: count + 1),
                      );
                },
                icon: Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
