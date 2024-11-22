part of 'profile_edit_cubit.dart';

/// Profile edit state
sealed class ProfileEditState extends BaseLogicState with EquatableMixin {
  const ProfileEditState();
}

/// Profile edit initial
final class ProfileEditIdle extends ProfileEditState with BuildableLogicState {
  /// Default constructor
  const ProfileEditIdle();

  @override
  List<Object?> get props => [];
}

/// Profile edit loading
final class ProfileEditLoading extends ProfileEditState
    with BuildableLogicState {
  /// Default constructor
  const ProfileEditLoading({
    required this.isDataChanged,
    required this.isPasswordChanged,
  });

  /// Is data changed
  final bool isDataChanged;

  /// Is password changed
  final bool isPasswordChanged;

  @override
  List<Object?> get props => [
        isDataChanged,
        isPasswordChanged,
      ];
}

/// Profile edit error
final class ProfileEditFailure extends ProfileEditState
    with ListenableLogicState {
  /// Default constructor
  const ProfileEditFailure({required this.failure});

  /// Failure
  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}

/// Profile edit error
final class ProfileEditSuccess extends ProfileEditState
    with ListenableLogicState {
  /// Default constructor
  const ProfileEditSuccess({required this.success});

  /// Failure
  final Success success;

  @override
  List<Object?> get props => [
        success,
      ];
}
