part of 'profile_stats_cubit.dart';

/// Profile state
sealed class ProfileStatsState extends BaseLogicState with EquatableMixin {
  const ProfileStatsState();
}

/// Profile stats state
abstract class ProfileStatisticsState extends ProfileStatsState {
  /// Default constructor
  const ProfileStatisticsState({
    required this.profileStats,
  });

  /// Profile stats
  final ProfileStats profileStats;
}

/// Profile initial
final class ProfileInitial extends ProfileStatsState with BuildableLogicState {
  @override
  List<Object?> get props => [];
}

/// Profile idle
///
/// if value is null it means value loaded with error
/// if value is not null it means value loaded successfully
final class ProfileStatsIdle extends ProfileStatisticsState
    with BuildableLogicState {
  /// Default constructor
  ProfileStatsIdle({
    required super.profileStats,
  });

  @override
  List<Object?> get props => [profileStats];
}

/// Profile loading
///
/// if value is null it means value is loading
/// if value is not null it means value is preloaded
final class ProfileStatsLoading extends ProfileStatisticsState
    with BuildableLogicState {
  /// Default constructor
  ProfileStatsLoading({
    required super.profileStats,
  });

  @override
  List<Object?> get props => [profileStats];
}

/// Profile error
final class ProfileStatsError extends ProfileStatsState
    with ListenableLogicState {
  /// Default constructor
  const ProfileStatsError({
    required this.failure,
  });

  /// Failure
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}
