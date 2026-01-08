import 'package:equatable/equatable.dart';
import 'package:flower_app/core/app/domain/entities/products_entity.dart';

sealed class CategoriesViewUIEvents {}

final class CategoriesViewShowErrorEvent extends CategoriesViewUIEvents
    with EquatableMixin {
  final String errorMessage;

  CategoriesViewShowErrorEvent(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

