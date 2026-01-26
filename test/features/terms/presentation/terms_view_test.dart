import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flower_app/features/terms/domain/entity/terms_entity.dart';
import 'package:flower_app/features/terms/presentation/manager/terms_state.dart';
import 'package:flower_app/features/terms/presentation/terms_view.dart';
import 'package:flower_app/features/terms/presentation/terms_widgets_keys.dart';
import 'package:flower_app/features/terms/presentation/view_model/terms_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'terms_view_test.mocks.dart';

@GenerateMocks([TermsViewModel])
void main() {
  late TermsViewModel viewModel;

  setUp(() {
    viewModel = MockTermsViewModel();
  });

  Widget buildTestableWidget() => MaterialApp(
    theme: LightTheme().themeData,
    home: BlocProvider<TermsViewModel>(
      create: (context) => viewModel,
      child: const TermsView(),
    ),
  );

  testWidgets("TermsView Init...", (WidgetTester tester) async {
    when(viewModel.state).thenReturn(TermsState(BaseState.init()));
    when(
      viewModel.stream,
    ).thenAnswer((_) => Stream<TermsState>.value(TermsState(BaseState.init())));

    await tester.pumpWidget(buildTestableWidget());

    expect(find.byKey(const Key(TermsWidgetsKeys.appBar)), findsOneWidget);
    expect(find.byKey(const Key(TermsWidgetsKeys.center)), findsOneWidget);
    expect(
      find.byKey(const Key(TermsWidgetsKeys.loadingIndicator)),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key(TermsWidgetsKeys.termsListViewBuilder)),
      findsNothing,
    );
    expect(
      find.byKey(const Key(TermsWidgetsKeys.noTermsAvailableText)),
      findsNothing,
    );
    expect(find.byKey(const Key(TermsWidgetsKeys.errorWidget)), findsNothing);
  });

  testWidgets("TermsView Loading...", (WidgetTester tester) async {
    when(viewModel.state).thenReturn(TermsState(BaseState.loading()));
    when(viewModel.stream).thenAnswer(
      (_) => Stream<TermsState>.value(TermsState(BaseState.loading())),
    );

    await tester.pumpWidget(buildTestableWidget());

    expect(find.byKey(const Key(TermsWidgetsKeys.appBar)), findsOneWidget);
    expect(find.byKey(const Key(TermsWidgetsKeys.center)), findsOneWidget);
    expect(
      find.byKey(const Key(TermsWidgetsKeys.loadingIndicator)),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key(TermsWidgetsKeys.termsListViewBuilder)),
      findsNothing,
    );
    expect(
      find.byKey(const Key(TermsWidgetsKeys.noTermsAvailableText)),
      findsNothing,
    );
    expect(find.byKey(const Key(TermsWidgetsKeys.errorWidget)), findsNothing);
  });

  testWidgets("TermsView Loaded with data...", (WidgetTester tester) async {
    var entity = TermsEntity(
      section: 'section',
      contentAr: ['محتوى'],
      contentEn: ['content'],
      colorHex: '0xFFFFFFFF',
      fontSize: 12,
      fontWeight: 'bold',
    );
    List<TermsEntity> entities = [entity, entity, entity];
    when(viewModel.state).thenReturn(TermsState(BaseState.loaded(entities)));
    when(viewModel.stream).thenAnswer(
      (_) => Stream<TermsState>.value(TermsState(BaseState.loaded(entities))),
    );

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        child: buildTestableWidget(),
      ),
    );

    expect(find.byKey(const Key(TermsWidgetsKeys.appBar)), findsOneWidget);
    expect(
      find.byKey(const Key(TermsWidgetsKeys.termsListViewBuilder)),
      findsOneWidget,
    );
    expect(find.byKey(const Key(TermsWidgetsKeys.center)), findsNothing);
    expect(
      find.byKey(const Key(TermsWidgetsKeys.loadingIndicator)),
      findsNothing,
    );
    expect(
      find.byKey(const Key(TermsWidgetsKeys.noTermsAvailableText)),
      findsNothing,
    );
    expect(find.byKey(const Key(TermsWidgetsKeys.errorWidget)), findsNothing);
  });

  testWidgets("TermsView Loaded with empty list...", (
    WidgetTester tester,
  ) async {
    List<TermsEntity> entities = [];
    when(viewModel.state).thenReturn(TermsState(BaseState.loaded(entities)));
    when(viewModel.stream).thenAnswer(
      (_) => Stream<TermsState>.value(TermsState(BaseState.loaded(entities))),
    );

    await tester.pumpWidget(buildTestableWidget());

    expect(find.byKey(const Key(TermsWidgetsKeys.appBar)), findsOneWidget);
    expect(find.byKey(const Key(TermsWidgetsKeys.center)), findsOneWidget);
    expect(
      find.byKey(const Key(TermsWidgetsKeys.noTermsAvailableText)),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key(TermsWidgetsKeys.termsListViewBuilder)),
      findsNothing,
    );
    expect(
      find.byKey(const Key(TermsWidgetsKeys.loadingIndicator)),
      findsNothing,
    );
    expect(find.byKey(const Key(TermsWidgetsKeys.errorWidget)), findsNothing);
  });

  testWidgets("TermsView Failed with error msg...", (
    WidgetTester tester,
  ) async {
    var errorMsg = "errors.unknown";
    when(viewModel.state).thenReturn(TermsState(BaseState.error(errorMsg)));
    when(viewModel.stream).thenAnswer(
      (_) => Stream<TermsState>.value(TermsState(BaseState.error(errorMsg))),
    );

    await tester.pumpWidget(buildTestableWidget());

    expect(find.byKey(const Key(TermsWidgetsKeys.appBar)), findsOneWidget);
    expect(find.byKey(const Key(TermsWidgetsKeys.errorWidget)), findsOneWidget);
    expect(find.byKey(const Key(TermsWidgetsKeys.center)), findsNothing);
    expect(
      find.byKey(const Key(TermsWidgetsKeys.noTermsAvailableText)),
      findsNothing,
    );
    expect(
      find.byKey(const Key(TermsWidgetsKeys.termsListViewBuilder)),
      findsNothing,
    );
    expect(
      find.byKey(const Key(TermsWidgetsKeys.loadingIndicator)),
      findsNothing,
    );
  });
}
