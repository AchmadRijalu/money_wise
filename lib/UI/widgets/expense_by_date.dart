import 'package:flutter/material.dart';
import 'package:money_wise/theme/theme.dart';

class ExpenseByDate extends StatelessWidget {
  final Color? color;
  final Color? secondaryColor;
  final int? moneyCount;
  const ExpenseByDate(
      {super.key, this.color, this.secondaryColor, this.moneyCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color!,
              secondaryColor!,
            ],
          )),
      padding: const EdgeInsets.only(left: 16, right: 46, top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pengeluaranmu Bulan Ini",
            style: whiteTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            "Rp. $moneyCount",
            style: whiteTextStyle.copyWith(fontWeight: bold, fontSize: 16),
          )
        ],
      ),
    );
  }
}
