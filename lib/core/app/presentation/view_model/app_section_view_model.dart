import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSectionViewModel extends Cubit<int> with EquatableMixin {
  AppSectionViewModel() : super(0);

  void onTap(int currentTab) {
    emit(currentTab);
  }

  @override
  List<Object?> get props => [state];
}
