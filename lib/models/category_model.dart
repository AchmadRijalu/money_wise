import 'package:flutter/material.dart';

class CategoryModel {
  final int? id;
  final String title;
  Color color;
  String image;

  CategoryModel({
    this.id,
    required this.title,
    required this.color,
    required this.image,
  });
}
