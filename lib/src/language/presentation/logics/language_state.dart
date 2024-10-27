part of 'language_cubit.dart';

/// Language state
class LanguageState extends BaseLogicState
    with BuildableLogicState, EquatableMixin {
  /// Default constructor
  const LanguageState({
    required this.currentLanguage,
  });

  /// Current language
  final Locale currentLanguage;

  @override
  List<Object?> get props => [
        currentLanguage,
      ];
}
