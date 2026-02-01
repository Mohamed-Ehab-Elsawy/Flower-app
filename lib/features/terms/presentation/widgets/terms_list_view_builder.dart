import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/features/terms/domain/entity/terms_entity.dart';
import 'package:flower_app/features/terms/presentation/widgets/terms_item_widget.dart';
import 'package:flutter/material.dart';

class TermsListViewBuilder extends StatelessWidget {
  final List<TermsEntity> entities;

  const TermsListViewBuilder({super.key, required this.entities});

  @override
  Widget build(BuildContext context) {
    var isArabic = context.locale.languageCode == 'ar';
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: entities.length,
      itemBuilder: (context, index) =>
          TermsItemWidget(entity: entities[index], isArabic: isArabic),
    );
  }
}
