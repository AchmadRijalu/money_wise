import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_wise/UI/views/add_expense_view.dart';
import 'package:money_wise/UI/views/detail_expense_view.dart';
import 'package:money_wise/UI/widgets/expense_by_category.dart';
import 'package:money_wise/UI/widgets/expense_by_date.dart';
import 'package:money_wise/UI/widgets/list_expense_item.dart';
import 'package:money_wise/logic/expense/expense_bloc.dart';
import 'package:money_wise/shared/shared_method.dart';
import 'package:money_wise/theme/theme.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/home';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ExpenseBloc _expenseBloc = ExpenseBloc();

  @override
  void initState() {
    super.initState();
    _expenseBloc.add(GetAllExpenses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: blueColor,
        onPressed: () async {
          await Navigator.pushNamed(context, AddExpenseView.routeName);
          _expenseBloc.add(GetAllExpenses());
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
        shape: CircleBorder(),
      ),
      body: BlocProvider(
        create: (context) => _expenseBloc..add(GetAllExpenses()),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        "Halo, Achmad!",
                        style: blackTextStyle.copyWith(
                            fontSize: 18, fontWeight: bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Jangan lupa catat keuanganmu setiap hari!",
                    style: greyTextStyle.copyWith(
                        fontSize: 14, fontWeight: regular),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      BlocBuilder<ExpenseBloc, ExpenseState>(
                        builder: (context, state) {
                          if (state is GetAllExpensesSuccess) {
                            return Expanded(
                              child: ExpenseByDate(
                                  color: blueColor,
                                  secondaryColor: tealColor,
                                  moneyCount: state.monthExpenses.toInt()),
                            );
                          } else if (state is ExpensesFailed) {
                            return Expanded(
                              child: Column(children: [
                                Text(state.error.toString()),
                              ]),
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Pengeluaran berdasarkan kategori",
                    style:
                        blackTextStyle.copyWith(fontSize: 14, fontWeight: bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  BlocBuilder<ExpenseBloc, ExpenseState>(
                    builder: (context, state) {
                      if (state is GetAllExpensesSuccess) {
                        return SizedBox(
                          height: 155,
                          child: ListView.builder(
                            itemCount: getCategories().length,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemBuilder: (context, index) {
                              final category = getCategories()[index];
                              final totalAmount =
                                  state.accumulatedExpenses[category.title] ??
                                      0.0;
                              return ExpenseByCategory(
                                categoryModel: category,
                                price: totalAmount.toInt(),
                              );
                            },
                          ),
                        );
                      } else if (state is ExpensesFailed) {
                        return const Center(
                          child: Text("Gagal memuat data"),
                        );
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  BlocBuilder<ExpenseBloc, ExpenseState>(
                    builder: (context, state) {
                      if (state is GetAllExpensesSuccess) {
                        if (state.expenses.isEmpty) {
                          return Column(
                            children: [
                              SvgPicture.asset(
                                "assets/images/image_empty.svg",
                                width: 204,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Belum ada pengeluaran",
                                style: blackTextStyle.copyWith(
                                    fontSize: 14, fontWeight: bold),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: state.expenses.entries.map((data) {
                              final date = data.key;
                              final expenses = data.value;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    date,
                                    style: blackTextStyle.copyWith(
                                        fontSize: 14, fontWeight: bold),
                                  ),
                                  const SizedBox(height: 12),
                                  ListView.builder(
                                    primary: false,
                                    itemCount: expenses.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final expenseModel = expenses[index];
                                      return ListExpenseItem(
                                          onPressed: () async {
                                            await Navigator.pushNamed(context,
                                                DetailExpenseView.routeName,
                                                arguments: expenseModel);
                                            _expenseBloc.add(GetAllExpenses());
                                          },
                                          expenseModel: expenseModel);
                                    },
                                  ),
                                  const SizedBox(height: 28),
                                ],
                              );
                            }).toList(),
                          );
                        }
                      } else if (state is ExpensesFailed) {
                        return const Center(
                          child: Text("Gagal memuat data"),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
