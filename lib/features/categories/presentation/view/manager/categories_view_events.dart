import 'package:equatable/equatable.dart';

sealed class CategoriesViewUIEvents {}

final class CategoriesViewShowErrorEvent extends CategoriesViewUIEvents
    with EquatableMixin {
  final String errorMessage;

  CategoriesViewShowErrorEvent(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
