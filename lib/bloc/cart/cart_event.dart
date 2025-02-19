import 'package:equatable/equatable.dart';
import 'package:zartek/model/cart_item_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

// Update quantity of a dish in the cart
class UpdateQuantity extends CartEvent {
  final CartItemModel cartItem;
  final int quantity;

  const UpdateQuantity({required this.cartItem, required this.quantity});

  @override
  List<Object> get props => [cartItem, quantity];
}
