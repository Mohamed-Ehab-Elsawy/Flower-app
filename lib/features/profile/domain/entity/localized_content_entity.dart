import 'package:equatable/equatable.dart';

class LocalizedContent extends Equatable {
  final dynamic en;
  final dynamic ar;

  const LocalizedContent({required this.en, required this.ar});

  List<String> getByLanguage(String languageCode) {
    final raw = languageCode == 'ar' ? ar : en;

    if (raw == null) {
      return const [];
    }

    if (raw is String) {
      return [raw.trim()];
    }

    if (raw is List) {
      return raw
          .map((e) => (e as String?)?.trim() ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
    }

    return const [];
  }

  @override
  List<Object?> get props => [en, ar];
}
