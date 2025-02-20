import 'package:equatable/equatable.dart';
import 'package:zartek/model/cart_item_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final CartItemModel cartItem;

  const AddToCart({required this.cartItem});

  @override
  List<Object?> get props => [cartItem];
}

class RemoveFromCart extends CartEvent {
  final CartItemModel cartItem;

  const RemoveFromCart({required this.cartItem});

  @override
  List<Object?> get props => [cartItem];
}

class ClearCart extends CartEvent {}
