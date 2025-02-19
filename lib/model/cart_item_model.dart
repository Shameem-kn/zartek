// import 'package:equatable/equatable.dart';

// class CartItemModel extends Equatable {
//   final int id;
//   final String name;
//   final String price;
//   final String currency;
//   final int calories;
//   final int quantity;

//   const CartItemModel({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.currency,
//     required this.calories,
//     required this.quantity,
//   });

//   CartItemModel copyWith({int? quantity}) {
//     return CartItemModel(
//       id: id,
//       name: name,
//       price: price,
//       currency: currency,
//       calories: calories,
//       quantity: quantity ?? this.quantity,
//     );
//   }

//   @override
//   List<Object> get props => [id, name, price, currency, calories, quantity];
// }
import 'package:equatable/equatable.dart';

class CartItemModel extends Equatable {
  final int id;
  final String name;
  final String price;
  final String currency;
  final int calories;
  final int quantity;
  final bool isVeg;

  const CartItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.calories,
    required this.quantity,
    required this.isVeg,
  });

  CartItemModel copyWith({int? quantity, bool? isVeg}) {
    return CartItemModel(
      id: id,
      name: name,
      price: price,
      currency: currency,
      calories: calories,
      quantity: quantity ?? this.quantity,
      isVeg: isVeg ?? this.isVeg,
    );
  }

  @override
  List<Object> get props =>
      [id, name, price, currency, calories, quantity, isVeg];
}
