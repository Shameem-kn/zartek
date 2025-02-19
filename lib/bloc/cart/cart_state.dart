import 'package:equatable/equatable.dart';
import 'package:zartek/model/cart_item_model.dart';

class CartState extends Equatable {
  final List<CartItemModel> cartItems;

  const CartState({required this.cartItems});

  factory CartState.initial() => const CartState(cartItems: []);

  @override
  List<Object> get props => [cartItems];
}
