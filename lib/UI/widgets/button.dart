
import 'package:flutter/material.dart';
import 'package:money_wise/theme/theme.dart';

class CustomFilledButton extends StatelessWidget {
  final String? title;
  final double? width;
  final double? height;
  final Color? color;
  final bool? isDisable;

  final VoidCallback? onPressed;
  const CustomFilledButton(
      {super.key,
      this.title,
      this.width,
      this.height,
      this.color,
      this.isDisable,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text(
          title!,
          style: whiteTextStyle.copyWith(fontWeight: bold, fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          backgroundColor: color,
          elevation: 0,
        ),
        onPressed: onPressed);
  }
}
