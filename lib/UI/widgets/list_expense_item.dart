import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_wise/models/expense_model.dart';
import 'package:money_wise/theme/theme.dart';

class ListExpenseItem extends StatelessWidget {
  final ExpenseModel? expenseModel;
  final Function()? onPressed;
  const ListExpenseItem({super.key, this.expenseModel, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: double.infinity,
        height: 67,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 22),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: greyColor.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 15,
              offset: Offset(2, 5),
            ),
          ],
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  SvgPicture.asset(
                    "${expenseModel?.imageCategory}",
                    color: Color(expenseModel?.colorCategory ?? 0),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Text(
                    "${expenseModel?.name}",
                    style: blackTextStyle.copyWith(
                        fontSize: 14, fontWeight: regular),
                  ),
                ],
              ),
            ),
            Text("Rp. ${expenseModel?.amount}",
                style:
                    blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold))
          ],
        ),
      ),
    );
  }
}
