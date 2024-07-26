part of 'date_cubit.dart';

sealed class DateState extends Equatable {
  const DateState();

  @override
  List<Object> get props => [];
}

class DateInitial extends DateState {
  final DateTime initialDate;

  DateInitial(this.initialDate);

  @override
  List<Object> get props => [initialDate];
}

class DateSelected extends DateState {
  final DateTime selectedDate;

  DateSelected(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}
