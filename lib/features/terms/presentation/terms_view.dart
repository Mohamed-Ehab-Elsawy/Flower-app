import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/terms/presentation/manager/terms_intent.dart';
import 'package:flower_app/features/terms/presentation/manager/terms_state.dart';
import 'package:flower_app/features/terms/presentation/terms_widgets_keys.dart';
import 'package:flower_app/features/terms/presentation/widgets/terms_error_widget.dart';
import 'package:flower_app/features/terms/presentation/widgets/terms_list_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'view_model/terms_view_model.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      key: const Key(TermsWidgetsKeys.appBar),
      scrolledUnderElevation: 0,
    ),
    body: BlocBuilder<TermsViewModel, TermsState>(
      builder: (context, termsState) {
        final baseState = termsState.state;

        switch (baseState.requestState) {
          case RequestState.init:
          case RequestState.loading:
            return Center(
              key: const Key(TermsWidgetsKeys.center),
              child: LoadingIndicator(
                key: const Key(TermsWidgetsKeys.loadingIndicator),
                indicatorType: Indicator.lineScale,
                colors: context.appTheme.kDefaultRainbowColors,
                strokeWidth: 1,
                backgroundColor: context.appTheme.backgroundColor,
                pathBackgroundColor: Colors.black,
              ),
            );

          case RequestState.loaded:
            var entities = baseState.data ?? [];
            if (entities.isNotEmpty) {
              return TermsListViewBuilder(
                key: const Key(TermsWidgetsKeys.termsListViewBuilder),
                entities: entities,
              );
            } else {
              return Center(
                key: const Key(TermsWidgetsKeys.center),
                child: Text(
                  key: const Key(TermsWidgetsKeys.noTermsAvailableText),
                  "no_terms_available".tr(),
                ),
              );
            }

          case RequestState.error:
            return TermsErrorWidget(
              key: const Key(TermsWidgetsKeys.errorWidget),
              message: baseState.errorMessage ?? "errors.unknown".tr(),
              onRetry: () =>
                  context.read<TermsViewModel>().doIntent(FetchTermsIntent()),
            );
        }
      },
    ),
  );
}
