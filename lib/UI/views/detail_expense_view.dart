import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_wise/UI/widgets/button.dart';
import 'package:money_wise/UI/widgets/forms.dart';
import 'package:money_wise/logic/expense/expense_bloc.dart';
import 'package:money_wise/models/category_model.dart';
import 'package:money_wise/models/expense_model.dart';
import 'package:money_wise/shared/shared_method.dart';
import 'package:money_wise/theme/theme.dart';

class DetailExpenseView extends StatefulWidget {
  static const routeName = '/detail-expense';
  final ExpenseModel? expenseModel;
  const DetailExpenseView({super.key, this.expenseModel});

  @override
  State<DetailExpenseView> createState() => _DetailExpenseViewState();
}

class _DetailExpenseViewState extends State<DetailExpenseView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  CategoryModel? _selectedCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.expenseModel!.name;
    _categoryController.text = widget.expenseModel!.category;
    _dateController.text = widget.expenseModel!.date;
    _amountController.text = widget.expenseModel!.amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: categoryYellowColor,
        title: Text('Detail Pengeluaran',
            style: blackTextStyle.copyWith(fontWeight: bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 38),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomFormField(
              title: "Nama Pengeluaran",
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            TextFormField(
              readOnly: true,
              onTap: () {
                showFlexibleBottomSheet(
                  minHeight: 0,
                  initHeight: 0.5,
                  maxHeight: 0.5,
                  context: context,
                  builder: _buildBottomSheet,
                );
              },
              cursorColor: blackColor,
              controller: _categoryController,
              decoration: InputDecoration(
                prefixIcon: _selectedCategory != null
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          _selectedCategory!.image,
                          color: _selectedCategory!.color,
                        ),
                      )
                    : null,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: blackColor, width: 2.0),
                ),
                hintText: "Category",
                contentPadding: const EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffix: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: lightGreyColor,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: blackColor,
                    size: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomFormFieldDate(
              controller: _dateController,
              title: "Tanggal Pengeluaran",
            ),
            const SizedBox(height: 20),
            CustomFormField(
              title: "Nominal",
              formatter: FilteringTextInputFormatter.digitsOnly,
              controller: _amountController,
              keyBoardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            CustomFilledButton(
                title: "Ubah Pengeluaran",
                color: greenColor,
                onPressed: () async {}),
            const SizedBox(height: 20),
            CustomFilledButton(
                title: "Hapus Pengeluaran",
                color: redColor,
                onPressed: () async {}),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    List<CategoryModel> categories = getCategories();

    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pilih Kategori",
                    style: blackTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 14)),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(
              height: 27,
            ),
            Expanded(
              child: GridView.builder(
                controller: scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 20,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                        _categoryController.text = category.title;
                      });
                      Navigator.pop(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: category.color,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: SvgPicture.asset(
                            category.image,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.title,
                          style: blackTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
