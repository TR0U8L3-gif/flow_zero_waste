import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/src/onboarding/domain/usecases/load_onboarding_seen_from_local_storage.dart';
import 'package:flow_zero_waste/src/onboarding/domain/usecases/save_onboarding_seen_to_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// Onboarding provider
@singleton
class OnboardingProvider extends ChangeNotifier {
  /// Default constructor
  OnboardingProvider({
    required LoadOnboardingSeenFromLocalStorage
        loadOnboardingSeenFromLocalStorage,
    required SaveOnboardingSeenToLocalStorage saveOnboardingSeenToLocalStorage,
  })  : _loadOnboardingSeenFromLocalStorage =
            loadOnboardingSeenFromLocalStorage,
        _saveOnboardingSeenToLocalStorage = saveOnboardingSeenToLocalStorage;

  final LoadOnboardingSeenFromLocalStorage _loadOnboardingSeenFromLocalStorage;
  final SaveOnboardingSeenToLocalStorage _saveOnboardingSeenToLocalStorage;

  bool _isOnboardingSeen = false;

  /// Getter for isOnboardingSeen
  bool get isOnboardingSeen => _isOnboardingSeen;

  /// Set onboarding seen
  void setOnboardingSeen() {
    if (_isOnboardingSeen) return;

    _isOnboardingSeen = true;
    notifyListeners();
    _saveOnboardingSeen(_isOnboardingSeen);
  }

  void _saveOnboardingSeen(bool isOnboardingSeen) {
    _saveOnboardingSeenToLocalStorage.call(
      SaveOnboardingSeenToLocalStorageParams(status: isOnboardingSeen),
    );
  }

  /// Load onboarding seen
  Future<void> loadOnboardingSeen() async {
    final result =
        await _loadOnboardingSeenFromLocalStorage.call(const NoParams());

    result.fold(
      (failure) {
        _isOnboardingSeen = true;
      },
      (isOnboardingSeen) {
        if (isOnboardingSeen != null) {
          _isOnboardingSeen = isOnboardingSeen;
        } else {
          _isOnboardingSeen = false;
        }
      },
    );

    notifyListeners();
  }
}
