import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:money_wise/logic/date/date_cubit.dart';
import 'package:money_wise/theme/theme.dart';

class CustomFormField extends StatefulWidget {
  final String? title;
  final TextEditingController? controller;
  final TextInputType? keyBoardType;
  final TextInputFormatter? formatter;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onChanged;
  const CustomFormField(
      {super.key,
      required this.title,
      this.controller,
      this.autovalidateMode,
      this.formatter,
      this.keyBoardType,
      this.onChanged});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onChanged: widget.onChanged,
          cursorColor: blackColor,
          autovalidateMode: widget.autovalidateMode,
          keyboardType: widget.keyBoardType,
          controller: widget.controller,
          inputFormatters:
              widget.formatter != null ? [widget.formatter!] : null,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: blackColor, width: 2.0),
              ),
              hintText: widget.title,
              contentPadding: const EdgeInsets.all(12),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
        )
      ],
    );
  }
}

class CustomFormFieldDate extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final void Function(String)? onChanged;

  CustomFormFieldDate({
    Key? key,
    this.controller,
    this.title,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateCubit, DateState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: onChanged,
          readOnly: true,
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate:
                  state is DateSelected ? state.selectedDate : DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2034),
            );
            if (pickedDate != null) {
              context.read<DateCubit>().setDate(pickedDate);
              final formattedDate =
                  DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(pickedDate);
              controller!.text = formattedDate;
            }
          },
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return value!.isEmpty ? "Tanggal tidak boleh kosong" : null;
          },
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: blackColor, width: 2.0),
              ),
              hintText: title,
              contentPadding: const EdgeInsets.all(12),
              suffixIcon: Icon(
                Icons.calendar_today,
                color: blackColor,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
        );
      },
    );
  }
}
