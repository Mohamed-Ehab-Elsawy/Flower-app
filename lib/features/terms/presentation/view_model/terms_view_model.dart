import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/terms/domain/entity/terms_entity.dart';
import 'package:flower_app/features/terms/domain/repository/terms_repo.dart';
import 'package:flower_app/features/terms/presentation/manager/terms_intent.dart';
import 'package:flower_app/features/terms/presentation/manager/terms_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TermsViewModel extends Cubit<TermsState> {
  final TermsRepo _termsRepository;

  TermsViewModel(this._termsRepository) : super(TermsState.init());

  void doIntent(TermsIntent intent) {
    switch (intent) {
      case FetchTermsIntent():
        _fetchTerms();
    }
  }

  Future<void> _fetchTerms() async {
    emit(state.copyWith(BaseState.loading()));
    final result = await _termsRepository.getTermsAndConditions();
    switch (result) {
      case Success<List<TermsEntity>>():
        emit(state.copyWith(BaseState.loaded(result.data)));
      case Failure<List<TermsEntity>>():
        emit(state.copyWith(BaseState.error(result.errorMessage)));
    }
  }
}
