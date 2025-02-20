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
          width: 115,
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
                              RemoveFromCart(
                                cartItem: cartItem,
                              ),
                            );
                      }
                    : null,
                icon: Icon(Icons.remove, color: Colors.white),
              ),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.read<CartBloc>().add(
                        AddToCart(
                          cartItem: cartItem,
                        ),
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
