import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/features/profile/presentation/cubit/about_us/about_us_intents.dart';
import 'package:flower_app/features/profile/presentation/cubit/about_us/about_us_state.dart';
import 'package:flower_app/features/profile/presentation/cubit/about_us/about_us_view_model.dart';
import 'package:flower_app/features/profile/presentation/widgets/about_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  @override
  void initState() {
    super.initState();
    context.read<AboutUsViewModel>().uiEvents.listen((event) {
      switch (event) {
        case GetAboutUsIntent():
          if (!mounted) return;
          context.read<AboutUsViewModel>().doIntent(event);
        case BackToProfileIntent():
          if (!mounted) return;
          Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('about_us'.tr()),
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () =>
              context.read<AboutUsViewModel>().doIntent(BackToProfileIntent()),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: BlocBuilder<AboutUsViewModel, AboutUsState>(
        bloc: context.read<AboutUsViewModel>()..doIntent(GetAboutUsIntent()),
        builder: (context, state) {
          if (state.aboutStates.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.aboutStates.isError) {
            return Center(
              child: Text(
                state.aboutStates.errorMessage ??
                    'errors'.tr(args: ["error404"]),
              ),
            );
          }

          final aboutUsEntity = state.aboutStates.data;

          if (state.aboutStates.isLoaded && aboutUsEntity != null) {
            context.read<AboutUsViewModel>().doIntent(GetAboutUsIntent());
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: aboutUsEntity.sections.length,
              itemBuilder: (context, index) {
                final section = aboutUsEntity.sections[index];
                return AboutSectionWidget(section: section);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
