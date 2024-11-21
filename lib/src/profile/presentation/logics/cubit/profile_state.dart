part of 'profile_cubit.dart';

/// Profile state
sealed class ProfileState extends BaseLogicState with EquatableMixin {
  const ProfileState();
}

/// Profile stats state
abstract class ProfileStatsState extends  ProfileState{
  /// Default constructor
  const ProfileStatsState({
    required this.profileStats,
  });

  /// Profile stats
  final ProfileStats profileStats;
}

/// Profile initial
final class ProfileInitial extends ProfileState
    with BuildableLogicState, ListenableLogicState {
  @override
  List<Object?> get props => [];
}

/// Profile idle
///
/// if value is null it means value loaded with error
/// if value is not null it means value loaded successfully
final class ProfileIdle extends ProfileStatsState with BuildableLogicState {
  /// Default constructor
  ProfileIdle({
    required super.profileStats,
  });

  @override
  List<Object?> get props => [profileStats];
}

/// Profile loading
///
/// if value is null it means value is loading
/// if value is not null it means value is preloaded
final class ProfileLoading extends ProfileStatsState with BuildableLogicState{
  /// Default constructor
  ProfileLoading({
    required super.profileStats,
  });

  @override
  List<Object?> get props => [profileStats];
}


/// Profile error
final class ProfileError extends ProfileState with ListenableLogicState {
  /// Default constructor
  const ProfileError({
    required this.failure,
  });
  /// Failure
  final Failure failure;  
  @override
  List<Object?> get props => [failure];
}
