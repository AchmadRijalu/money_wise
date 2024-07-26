
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_wise/models/category_model.dart';
import 'package:money_wise/theme/theme.dart';

class ExpenseByCategory extends StatelessWidget {
  final CategoryModel? categoryModel;
  final int? price;
  const ExpenseByCategory({super.key, this.categoryModel, this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: double.infinity,
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 15,
            offset: Offset(2, 5),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: categoryModel!.color,
              borderRadius: BorderRadius.circular(50),
            ),
            child: SvgPicture.asset(categoryModel!.image),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            categoryModel!.title,
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 11),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Rp. $price",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
