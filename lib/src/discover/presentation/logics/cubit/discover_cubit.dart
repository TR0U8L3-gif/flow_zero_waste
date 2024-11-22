import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit() : super(DiscoverInitial());
}
