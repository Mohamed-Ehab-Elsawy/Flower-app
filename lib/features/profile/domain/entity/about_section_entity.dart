import 'package:equatable/equatable.dart';
import 'package:flower_app/features/profile/domain/entity/localized_content_entity.dart';

class AboutSectionEntity extends Equatable {
  final String sectionName;
  final LocalizedContent content;
  final Map<String, dynamic> style;
  final LocalizedContent? title;

  const AboutSectionEntity({
    required this.sectionName,
    required this.content,
    required this.style,
    this.title,
  });

  @override
  List<Object?> get props => [sectionName, content, style, title];
}
