import 'package:flower_app/core/app/presentation/view_model/app_section_contracts.dart';
import 'package:flower_app/core/app/presentation/view_model/app_section_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';

void main() {
  late AppSectionViewModel viewModel;

  setUp(() {
    viewModel = AppSectionViewModel();
  });

  tearDown(() {
    viewModel.close();
  });

  group('AppSectionViewModel', () {
    test('initial state is correct', () {
      expect(viewModel.state, const AppSectionState());
    });

    blocTest<AppSectionViewModel, AppSectionState>(
      'emits home state when ViewHomeIntent is added',
      build: () => viewModel,
      act: (bloc) => bloc.doIntent(ViewHomeIntent()),
      expect: () => [
        const AppSectionState(currentTab: 0, selectedCategoryIndex: null),
      ],
    );

    blocTest<AppSectionViewModel, AppSectionState>(
      'emits category state with index when ViewCategoryIntent is added',
      build: () => viewModel,
      act: (bloc) => bloc.doIntent(ViewCategoryIntent(2)),
      expect: () => [
        const AppSectionState(currentTab: 1, selectedCategoryIndex: 2),
      ],
    );

    blocTest<AppSectionViewModel, AppSectionState>(
      'emits cart state when ViewCartIntent is added',
      build: () => viewModel,
      act: (bloc) => bloc.doIntent(ViewCartIntent()),
      expect: () => [const AppSectionState(currentTab: 2)],
    );

    blocTest<AppSectionViewModel, AppSectionState>(
      'emits profile state when ViewProfileIntent is added',
      build: () => viewModel,
      act: (bloc) => bloc.doIntent(ViewProfileIntent()),
      expect: () => [const AppSectionState(currentTab: 3)],
    );

    blocTest<AppSectionViewModel, AppSectionState>(
      'switching from category to home clears selectedCategoryIndex',
      build: () => viewModel,
      act: (bloc) {
        bloc.doIntent(ViewCategoryIntent(1));
        bloc.doIntent(ViewHomeIntent());
      },
      expect: () => [
        const AppSectionState(currentTab: 1, selectedCategoryIndex: 1),
        const AppSectionState(currentTab: 0, selectedCategoryIndex: null),
      ],
    );
  });
}
