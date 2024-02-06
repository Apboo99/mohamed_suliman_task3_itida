import 'package:flutter/cupertino.dart';

class AddProduct{
  final String image;
  final String name;
  final String price;
  AddProduct({required this.image, required this.name, required this.price});

  Map<String, dynamic> toJson() => {
    "image": image,
    "name": name,
    "price": price,

  };
}