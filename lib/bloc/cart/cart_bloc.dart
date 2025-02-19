import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek/bloc/cart/cart_event.dart';
import 'package:zartek/bloc/cart/cart_state.dart';
import 'package:zartek/model/cart_item_model.dart';
import 'package:zartek/model/menu_model.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<UpdateQuantity>(_onUpdateQuantity);
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    List<CartItemModel> updatedCart = List.from(state.cartItems);

    // Check if item already exists in cart by ID
    int index = updatedCart.indexWhere((item) => item.id == event.cartItem.id);

    if (event.quantity > 0) {
      if (index != -1) {
        // Update quantity
        updatedCart[index] =
            updatedCart[index].copyWith(quantity: event.quantity);
        print("Updated: ${event.cartItem.name}, Quantity: ${event.quantity}");
      } else {
        // Add new item to cart
        updatedCart.add(
          CartItemModel(
            id: event.cartItem.id,
            name: event.cartItem.name,
            price: event.cartItem.price,
            currency: event.cartItem.currency,
            calories: event.cartItem.calories,
            quantity: event.quantity,
          ),
        );
        print("new item added");
      }
    } else if (index != -1) {
      // Remove item from cart if quantity is 0
      updatedCart.removeAt(index);
      print("item removed");
    }

    emit(CartState(cartItems: updatedCart));
  }
}
