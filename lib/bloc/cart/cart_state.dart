import 'package:equatable/equatable.dart';
import 'package:zartek/model/cart_item_model.dart';

class CartState extends Equatable {
  final List<CartItemModel> cartItems;
  final int cartCount;
  final double totalCartPrice;

  const CartState(
      {required this.cartItems,
      required this.cartCount,
      required this.totalCartPrice});

  factory CartState.initial() =>
      const CartState(cartItems: [], cartCount: 0, totalCartPrice: 0);

  @override
  List<Object> get props => [cartItems, cartCount];
}
