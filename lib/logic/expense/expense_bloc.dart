import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:money_wise/db/expense_db.dart';
import 'package:money_wise/models/expense_model.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseInitial()) {
    on<ExpenseEvent>((event, emit) async {
      if (event is GetAllExpenses) {
        try {
          final expenses = await ExpenseDb().getAllExpenses();
          final groupedExpenses = _expensesByDate(expenses);
          final accumulatedExpenses = _accumulateExpensesByCategory(expenses);
          final todayExpenses = _accumulateExpensesByDate(expenses, 'Hari Ini');
          final monthExpenses =
              _accumulateExpensesByDate(expenses, 'Bulan Ini');
          emit(GetAllExpensesSuccess(groupedExpenses, accumulatedExpenses,
              todayExpenses, monthExpenses));
        } catch (e) {
          emit(ExpensesFailed(e.toString()));
        }
      }

      if (event is AddExpense) {
        try {
          await ExpenseDb().insertExpense(event.expense);
          emit(AddExpenseSuccess(event.expense));
        } catch (e) {
          emit(ExpensesFailed(e.toString()));
        }
      }

      if (event is DeleteExpense) {
        try {
          await ExpenseDb().deleteExpense(event.id);
          add(GetAllExpenses());
        } catch (e) {
          emit(ExpensesFailed(e.toString()));
        }
      }

      if (event is UpdateExpense) {
        try {
          await ExpenseDb().updateExpense(event.expense);
          add(GetAllExpenses());
        } catch (e) {
          emit(ExpensesFailed(e.toString()));
        }
      }
    });
  }

  Map<String, List<ExpenseModel>> _expensesByDate(List<ExpenseModel> expenses) {
    final Map<String, List<ExpenseModel>> groupedExpenses = {};
    final DateFormat fullDateFormat = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime yesterday = today.subtract(const Duration(days: 1));

    for (var expense in expenses) {
      DateTime expenseDate = fullDateFormat.parse(expense.date);
      String dateLabel;

      if (expenseDate == today) {
        dateLabel = "Hari Ini";
      } else if (expenseDate == yesterday) {
        dateLabel = "Kemarin";
      } else {
        dateLabel = DateFormat('dd MMM yyyy').format(expenseDate);
      }

      if (!groupedExpenses.containsKey(dateLabel)) {
        groupedExpenses[dateLabel] = [];
      }
      groupedExpenses[dateLabel]!.add(expense);
    }
    return groupedExpenses;
  }

  double _accumulateExpensesByDate(
      List<ExpenseModel> expenses, String dateType) {
    double total = 0.0;
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime startOfMonth = DateTime(now.year, now.month, 1);
    final DateFormat fullDateFormat = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');

    for (var expense in expenses) {
      try {
        DateTime expenseDate = fullDateFormat.parse(expense.date);

        if (dateType == 'Hari Ini' && expenseDate == today) {
          total += double.parse(expense.amount);
        } else if (dateType == 'Bulan Ini' &&
            expenseDate.isAfter(startOfMonth.subtract(Duration(days: 1))) &&
            expenseDate.isBefore(now.add(Duration(days: 1)))) {
          total += double.parse(expense.amount);
        }
      } catch (e) {
        print("Date parsing error: $e");
      }
    }
    return total;
  }

  Map<String, double> _accumulateExpensesByCategory(
      List<ExpenseModel> expenses) {
    final Map<String, double> accumulatedExpenses = {};
    for (var expense in expenses) {
      if (!accumulatedExpenses.containsKey(expense.category)) {
        accumulatedExpenses[expense.category] = 0.0;
      }
      accumulatedExpenses[expense.category] =
          accumulatedExpenses[expense.category]! + double.parse(expense.amount);
    }
    return accumulatedExpenses;
  }
}
