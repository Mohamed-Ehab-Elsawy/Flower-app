import 'package:equatable/equatable.dart';
import 'package:flower_app/features/profile/domain/entity/about_section_entity.dart';

class AboutUsEntity extends Equatable {
  final List<AboutSectionEntity> sections;

  const AboutUsEntity({required this.sections});

  @override
  List<Object?> get props => [sections];
}
