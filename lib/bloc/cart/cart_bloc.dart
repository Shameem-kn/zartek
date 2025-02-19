import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek/bloc/cart/cart_event.dart';
import 'package:zartek/bloc/cart/cart_state.dart';
import 'package:zartek/model/cart_item_model.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<UpdateQuantity>(_onUpdateQuantity);
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    List<CartItemModel> updatedCart = List.from(state.cartItems);
    int index = updatedCart.indexWhere((item) => item.id == event.cartItem.id);

    if (event.quantity > 0) {
      if (index != -1) {
        // Update quantity
        updatedCart[index] = updatedCart[index].copyWith(quantity: event.quantity);
      } else {
        // Add new item to cart
        updatedCart.add(event.cartItem.copyWith(quantity: event.quantity));
      }
    } else if (index != -1) {
      // Remove item from cart if quantity is 0
      updatedCart.removeAt(index);
    }

    emit(CartState(cartItems: updatedCart));
  }
}
