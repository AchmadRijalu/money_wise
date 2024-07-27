part of 'expense_bloc.dart';

sealed class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

final class ExpenseInitial extends ExpenseState {}

final class GetAllExpensesSuccess extends ExpenseState {
  final Map<String, List<ExpenseModel>> expenses;
  final Map<String, double> accumulatedExpenses;
  final double todayExpenses;
  final double monthExpenses;

  GetAllExpensesSuccess(this.expenses, this.accumulatedExpenses, this.todayExpenses, this.monthExpenses);

  @override
  List<Object> get props => [expenses, accumulatedExpenses, todayExpenses, monthExpenses];
}

final class ExpensesFailed extends ExpenseState {
  final String error;

  ExpensesFailed(this.error);

  @override
  List<Object> get props => [error];
}

final class AddExpenseSuccess extends ExpenseState {
  final ExpenseModel expense;

  AddExpenseSuccess(this.expense);

  @override
  List<Object> get props => [expense];
}

final class DeleteExpenseSuccess extends ExpenseState {
  final int id;

  DeleteExpenseSuccess(this.id);

  @override
  List<Object> get props => [id];
}

final class UpdateExpenseSuccess extends ExpenseState {
  final ExpenseModel expense;

  UpdateExpenseSuccess(this.expense);

  @override
  List<Object> get props => [expense];
}


