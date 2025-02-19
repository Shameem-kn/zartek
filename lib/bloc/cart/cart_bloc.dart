// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:zartek/bloc/cart/cart_event.dart';
// // import 'package:zartek/bloc/cart/cart_state.dart';
// // import 'package:zartek/model/cart_item_model.dart';
// // import 'package:zartek/model/menu_model.dart';

// // class CartBloc extends Bloc<CartEvent, CartState> {
// //   CartBloc() : super(CartState.initial()) {
// //     on<UpdateQuantity>(_onUpdateQuantity);
// //   }

// //   void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
// //     List<CartItemModel> updatedCart = List.from(state.cartItems);

// //     // Check if item already exists in cart by ID
// //     int index = updatedCart.indexWhere((item) => item.id == event.cartItem.id);

// //     if (event.quantity > 0) {
// //       if (index != -1) {
// //         // Update quantity
// //         updatedCart[index] =
// //             updatedCart[index].copyWith(quantity: event.quantity);
// //         print("Updated: ${event.cartItem.name}, Quantity: ${event.quantity}");
// //       } else {
// //         // Add new item to cart
// //         updatedCart.add(
// //           CartItemModel(
// //             id: event.cartItem.id,
// //             name: event.cartItem.name,
// //             price: event.cartItem.price,
// //             currency: event.cartItem.currency,
// //             calories: event.cartItem.calories,
// //             quantity: event.quantity,
// //           ),
// //         );
// //         print("new item added");
// //       }
// //     } else if (index != -1) {
// //       // Remove item from cart if quantity is 0
// //       updatedCart.removeAt(index);
// //       print("item removed");
// //     }

// //     emit(CartState(cartItems: updatedCart));
// //   }
// // }
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:zartek/bloc/cart/cart_event.dart';
// import 'package:zartek/bloc/cart/cart_state.dart';
// import 'package:zartek/model/cart_item_model.dart';

// class CartBloc extends Bloc<CartEvent, CartState> {
//   CartBloc() : super(CartState.initial()) {
//     on<AddToCart>(_onAddToCart);
//     on<RemoveFromCart>(_onRemoveFromCart);
//   }

//   void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
//     List<CartItemModel> updatedCart = List.from(state.cartItems);
//     int index = updatedCart.indexWhere((item) => item.id == event.cartItem.id);
//     int newCartCount = state.cartCount;
//     double newTotalCartPrice = state.totalCartPrice;

//     if (index != -1) {
//       // Increase quantity
//       updatedCart[index] = updatedCart[index].copyWith(
//         quantity: updatedCart[index].quantity + 1,
//         totalDishPrice:
//             updatedCart[index].totalDishPrice + updatedCart[index].price,
//       );
//       newCartCount += 1; // Increase count
//     } else {
//       // Add new item with quantity 1
//       updatedCart.add(event.cartItem
//           .copyWith(quantity: 1, totalDishPrice: event.cartItem.price));
//       newCartCount += 1;
//       newTotalCartPrice = newTotalCartPrice + event.cartItem.price;
//     }

//     emit(CartState(
//         cartItems: updatedCart,
//         cartCount: newCartCount,
//         totalCartPrice: newTotalCartPrice));
//   }

//   void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
//     List<CartItemModel> updatedCart = List.from(state.cartItems);
//     int index = updatedCart.indexWhere((item) => item.id == event.cartItem.id);
//     int newCartCount = state.cartCount; // Keep track of the count
//     double newTotalCartPrice = state.totalCartPrice;

//     if (index != -1) {
//       if (updatedCart[index].quantity > 1) {
//         // Decrease quantity
//         updatedCart[index] = updatedCart[index].copyWith(
//           quantity: updatedCart[index].quantity - 1,
//           totalDishPrice:
//               updatedCart[index].totalDishPrice - updatedCart[index].price,
//         );
//         newCartCount -= 1; // Decrease count
//         newTotalCartPrice = newTotalCartPrice - event.cartItem.price;
//       } else {
//         // Remove item if quantity is 1
//         updatedCart.removeAt(index);
//         newCartCount -= 1; // Decrease count
//       }
//     }

//     emit(CartState(
//         cartItems: updatedCart,
//         cartCount: newCartCount,
//         totalCartPrice: newTotalCartPrice));
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek/bloc/cart/cart_event.dart';
import 'package:zartek/bloc/cart/cart_state.dart';
import 'package:zartek/model/cart_item_model.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
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
}
