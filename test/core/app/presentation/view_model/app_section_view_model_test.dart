import 'package:flower_app/core/app/presentation/view_model/app_section_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test appSection when clickes in tabs ', () {
    test('initial state should be  0', () {
      expect(AppSectionViewModel().state, 0);
    });
    blocTest<AppSectionViewModel, int>(
      'emits [0] when click on tab in Index 0',
      build: () => AppSectionViewModel(),
      act: (bloc) => bloc.onTap(0),
      expect: () => const <int>[0],
    );
    blocTest<AppSectionViewModel, int>(
      'emits [1] when click on tab in Index 1',
      build: () => AppSectionViewModel(),
      act: (bloc) => bloc.onTap(1),
      expect: () => const <int>[1],
    );

    blocTest<AppSectionViewModel, int>(
      'emits [2] when click on tab in Index 2',
      build: () => AppSectionViewModel(),
      act: (bloc) => bloc.onTap(2),
      expect: () => const <int>[2],
    );

    blocTest<AppSectionViewModel, int>(
      'emits [3] when click on tab in Index 3',
      build: () => AppSectionViewModel(),
      act: (bloc) => bloc.onTap(3),
      expect: () => const <int>[3],
    );
  });
}
