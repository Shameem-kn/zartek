import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek/bloc/cart/cart_event.dart';
import 'package:zartek/bloc/cart/cart_state.dart';
import 'package:zartek/model/cart_item_model.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    List<CartItemModel> updatedCart = List.from(state.cartItems);
    int index = updatedCart.indexWhere((item) => item.id == event.cartItem.id);
    int newCartCount = state.cartCount;
    double newTotalCartPrice = state.totalCartPrice;

    if (index != -1) {
      // Increase quantity and update totalDishPrice
      updatedCart[index] = updatedCart[index].copyWith(
        quantity: updatedCart[index].quantity + 1,
        totalDishPrice:
            updatedCart[index].price * (updatedCart[index].quantity + 1),
      );
      newCartCount += 1;
      newTotalCartPrice += updatedCart[index].price; // Update cart total
    } else {
      // Add new item with quantity 1
      updatedCart.add(event.cartItem.copyWith(
        quantity: 1,
        totalDishPrice: event.cartItem.price,
      ));
      newCartCount += 1;
      newTotalCartPrice += event.cartItem.price;
    }

    emit(CartState(
      cartItems: updatedCart,
      cartCount: newCartCount,
      totalCartPrice: newTotalCartPrice,
    ));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    List<CartItemModel> updatedCart = List.from(state.cartItems);
    int index = updatedCart.indexWhere((item) => item.id == event.cartItem.id);
    int newCartCount = state.cartCount;
    double newTotalCartPrice = state.totalCartPrice;

    if (index != -1) {
      if (updatedCart[index].quantity > 1) {
        // Decrease quantity and update totalDishPrice
        updatedCart[index] = updatedCart[index].copyWith(
          quantity: updatedCart[index].quantity - 1,
          totalDishPrice:
              updatedCart[index].price * (updatedCart[index].quantity - 1),
        );
        newCartCount -= 1;
        newTotalCartPrice -= updatedCart[index].price;
      } else {
        // Remove item from cart if quantity is 1
        newTotalCartPrice -=
            updatedCart[index].totalDishPrice; // Fix for total price
        updatedCart.removeAt(index);
        newCartCount -= 1;
      }
    }

    emit(CartState(
      cartItems: updatedCart,
      cartCount: newCartCount,
      totalCartPrice: newTotalCartPrice,
    ));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(CartState(
      cartItems: [],
      cartCount: 0,
      totalCartPrice: 0.0,
    ));
  }
}
