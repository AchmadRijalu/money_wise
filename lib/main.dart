import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:money_wise/UI/views/add_expense_view.dart';
import 'package:money_wise/UI/views/detail_expense_view.dart';
import 'package:money_wise/UI/views/home_view.dart';
import 'package:money_wise/logic/date/date_cubit.dart';
import 'package:money_wise/logic/expense/expense_bloc.dart';
import 'package:money_wise/models/expense_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DateCubit(DateTime.now()),
          ),
          BlocProvider(
            create: (context) => ExpenseBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dot Spend',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: HomeView.routeName,
          routes: {
            HomeView.routeName: (context) => const HomeView(),
            AddExpenseView.routeName: (context) => const AddExpenseView(),
            DetailExpenseView.routeName: (context) => DetailExpenseView(
                  expenseModel: ModalRoute.of(context)!.settings.arguments
                      as ExpenseModel,
                ),
          },
        ));
  }
}
