import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/config/l10n/l10n.dart';
import 'package:flow_zero_waste/core/utils/logic_state.dart';
import 'package:flow_zero_waste/core/utils/use_case.dart';
import 'package:flow_zero_waste/src/language/domain/usecases/get_language_from_local_storage.dart';
import 'package:flow_zero_waste/src/language/domain/usecases/save_language_to_local_storage.dart';
import 'package:injectable/injectable.dart';

part 'language_state.dart';

@injectable
/// Language cubit
class LanguageCubit extends Cubit<LanguageState> {
  /// Default constructor
  LanguageCubit({
    required GetLanguageFromLocalStorage getLanguageFromStorage,
    required SaveLanguageToLocalStorage saveLanguageToStorage,
  })  : _getLanguageFromStorage = getLanguageFromStorage,
        _saveLanguageToStorage = saveLanguageToStorage,
        super(const LanguageState(currentLanguage: Locale('en')));

  final GetLanguageFromLocalStorage _getLanguageFromStorage;
  final SaveLanguageToLocalStorage _saveLanguageToStorage;

  /// Change the language
  void changeLanguage(String languageCode) {
    final oldLanguage = state.currentLanguage;
    final newLanguage = L10n.isSupportedLanguageCode(languageCode);
    if (newLanguage != null && oldLanguage != newLanguage) {
      emit(LanguageState(currentLanguage: newLanguage));
      _saveLanguage(newLanguage);
    }
  }

  /// Save the selected language to the local storage
  void _saveLanguage(Locale locale) {
    _saveLanguageToStorage
        .call(SaveLanguageToStorageParams(languageCode: locale.languageCode));
  }

  /// Load the language from the local storage
  Future<void> loadLanguage() async {
    final previousLanguage = state.currentLanguage;
    final result = await _getLanguageFromStorage.call(const NoParams());
    result.fold(
      (failure) {
        emit(LanguageState(currentLanguage: previousLanguage));
      },
      (languageCode) {
        final newLanguage = L10n.isSupportedLanguageCode(languageCode);
        if (newLanguage != null) {
          emit(LanguageState(currentLanguage: newLanguage));
        } else {
          emit(LanguageState(currentLanguage: previousLanguage));
        }
      },
    );
  }
}
