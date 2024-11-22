import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/src/profile/domain/entities/profile_stats.dart';
import 'package:flow_zero_waste/src/profile/domain/usecases/get_profile_stats.dart';
import 'package:injectable/injectable.dart';

part 'profile_stats_state.dart';

/// Profile cubit
@injectable
class ProfileStatsCubit extends Cubit<ProfileStatsState> {
  /// Default constructor
  ProfileStatsCubit({
    required GetProfileStats getProfileStats,
  })  : _getProfileStats = getProfileStats,
        super(ProfileInitial());

  final GetProfileStats _getProfileStats;
  ProfileStatsIdle? _lastIdleState;

  /// Load profile stats
  Future<void> loadProfileStats() async {
    emit(
      ProfileStatsLoading(
        profileStats: _lastIdleState?.profileStats ?? ProfileStats.empty(),
      ),
    );
    final result = await _getProfileStats.call(const NoParams());
    result.fold(
      (failure) {
        emit(ProfileStatsError(failure: failure));
      },
      emitIdle,
    );
  }

  /// Emit idle state
  void emitIdle(ProfileStats? stats) {
    if (isClosed) return;

    if (stats == null) {
      final state = _lastIdleState ??
          ProfileStatsIdle(
            profileStats: ProfileStats.empty(),
          );
      emit(state);
    } else {
      final state = ProfileStatsIdle(profileStats: stats);
      _lastIdleState = state;
      emit(state);
    }
  }
}
