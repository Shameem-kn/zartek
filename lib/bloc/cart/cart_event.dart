// import 'package:equatable/equatable.dart';
// import 'package:zartek/model/menu_model.dart';

// abstract class CartEvent extends Equatable {
//   const CartEvent();

//   @override
//   List<Object?> get props => [];
// }

// class UpdateQuantity extends CartEvent {
//   final Dish dish;
//   final int quantity;

//   const UpdateQuantity({required this.dish, required this.quantity});

//   @override
//   List<Object?> get props => [dish, quantity];
// }
import 'package:equatable/equatable.dart';
import 'package:zartek/model/cart_item_model.dart';
import 'package:zartek/model/menu_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class UpdateQuantity extends CartEvent {
  final CartItemModel cartItem;
  final int quantity;

  const UpdateQuantity({required this.cartItem, required this.quantity});

  @override
  List<Object?> get props => [cartItem, quantity];
}
