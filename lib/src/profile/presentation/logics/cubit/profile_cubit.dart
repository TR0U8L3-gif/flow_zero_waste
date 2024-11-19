import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/domain/use_case.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/src/profile/domain/entities/profile_stats.dart';
import 'package:flow_zero_waste/src/profile/domain/usecases/get_profile_stats.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

const _maxRetryCount = 3;

/// Profile cubit
@injectable
class ProfileCubit extends Cubit<ProfileState> {
  /// Default constructor
  ProfileCubit({
    required GetProfileStats getProfileStats,
  })  : _getProfileStats = getProfileStats,
        super(ProfileInitial());

  final GetProfileStats _getProfileStats;
  ProfileIdle? _lastIdleState;

  int _retryRequestCount = 0;

  /// Load profile stats
  Future<void> loadProfileStats() async {
    emit(
      ProfileLoading(
        profileStats: _lastIdleState?.profileStats ?? ProfileStats.empty(),
      ),
    );
    final result = await _getProfileStats.call(const NoParams());
    result.fold(
      (failure) {
        emit(ProfileError(failure: failure));
        if(_retryRequestCount < _maxRetryCount) {
          _retryRequestCount++;
          loadProfileStats();
          return;
        } {
          _retryRequestCount = 0;
        }
      },
      emitIdle,
    );
  }

  /// Emit idle state
  void emitIdle(ProfileStats? stats) {
    if(isClosed) return;
    
    if (stats == null) {
      final state = _lastIdleState ??
          ProfileIdle(
            profileStats: ProfileStats.empty(),
          );
      emit(state);
    } else {
      final state = ProfileIdle(profileStats: stats);
      _lastIdleState = state;
      emit(state);
    }
  }
}
