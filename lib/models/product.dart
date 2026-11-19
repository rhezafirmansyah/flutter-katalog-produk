import 'package:flutter/material.dart';

class Product {
  final String name;
  final String category;
  final int price;
  final double rating;
  final IconData icon;
  final Color color;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.icon,
    required this.color,
    required this.imageUrl,
    this.isFavorite = false,
  });
}
