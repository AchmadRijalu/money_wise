import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'date_state.dart';

class DateCubit extends Cubit<DateState> {
  DateCubit(DateTime initialDate) : super(DateInitial(initialDate));

  void setDate(DateTime newDate) =>
      emit(DateSelected(newDate));
}