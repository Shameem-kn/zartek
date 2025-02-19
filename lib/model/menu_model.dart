import 'package:meta/meta.dart';
import 'dart:convert';

class MenuModel {
  final List<Category> categories;

  MenuModel({
    required this.categories,
  });

  factory MenuModel.fromRawJson(String str) =>
      MenuModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  final int id;
  final String name;
  final List<Dish> dishes;

  Category({
    required this.id,
    required this.name,
    required this.dishes,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        dishes: List<Dish>.from(json["dishes"].map((x) => Dish.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dishes": List<dynamic>.from(dishes.map((x) => x.toJson())),
      };
}

class Dish {
  final int id;
  final String name;
  final String price;
  final Currency currency;
  final int calories;
  final String description;
  final List<Addon> addons;
  final String imageUrl;
  final bool customizationsAvailable;

  Dish({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.calories,
    required this.description,
    required this.addons,
    required this.imageUrl,
    required this.customizationsAvailable,
  });

  factory Dish.fromRawJson(String str) => Dish.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        currency: currencyValues.map[json["currency"]]!,
        calories: json["calories"],
        description: json["description"],
        addons: List<Addon>.from(json["addons"].map((x) => Addon.fromJson(x))),
        imageUrl: json["image_url"],
        customizationsAvailable: json["customizations_available"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "currency": currencyValues.reverse[currency],
        "calories": calories,
        "description": description,
        "addons": List<dynamic>.from(addons.map((x) => x.toJson())),
        "image_url": imageUrl,
        "customizations_available": customizationsAvailable,
      };
}

class Addon {
  final int id;
  final String name;
  final String price;

  Addon({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Addon.fromRawJson(String str) => Addon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}

enum Currency { INR }

final currencyValues = EnumValues({"INR": Currency.INR});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
