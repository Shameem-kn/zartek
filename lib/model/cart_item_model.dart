// import 'package:equatable/equatable.dart';

// class CartItemModel extends Equatable {
//   final int id;
//   final String name;
//   final String price;
//   final String currency;
//   final int calories;
//   final int quantity;
//   final bool isVeg;

//   const CartItemModel({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.currency,
//     required this.calories,
//     required this.quantity,
//     required this.isVeg,
//   });

//   CartItemModel copyWith({int? quantity, bool? isVeg}) {
//     return CartItemModel(
//       id: id,
//       name: name,
//       price: price,
//       currency: currency,
//       calories: calories,
//       quantity: quantity ?? this.quantity,
//       isVeg: isVeg ?? this.isVeg,
//     );
//   }

//   @override
//   List<Object> get props =>
//       [id, name, price, currency, calories, quantity, isVeg];
// }
import 'package:equatable/equatable.dart';

class CartItemModel extends Equatable {
  final int id;
  final String name;
  final double price;
  final String currency;
  final int calories;
  final int quantity;
  final bool isVeg;
  final double totalDishPrice;

  const CartItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.calories,
    required this.quantity,
    required this.isVeg,
    required this.totalDishPrice,
  });

  CartItemModel copyWith({
    int? quantity,
    bool? isVeg,
    double? totalDishPrice,
  }) {
    return CartItemModel(
      id: id,
      name: name,
      price: price,
      currency: currency,
      calories: calories,
      quantity: quantity ?? this.quantity,
      isVeg: isVeg ?? this.isVeg,
      totalDishPrice: totalDishPrice ?? this.totalDishPrice,
    );
  }

  @override
  List<Object> get props =>
      [id, name, price, currency, calories, quantity, isVeg, totalDishPrice];
}
