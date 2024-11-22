part of 'discover_cubit.dart';

sealed class DiscoverState extends BaseLogicState with EquatableMixin {
  const DiscoverState();
}

final class DiscoverInitial extends DiscoverState with BuildableLogicState {
  const DiscoverInitial();
  @override
  List<Object?> get props => [];
}

final class DiscoverLoading extends DiscoverState with BuildableLogicState {
  const DiscoverLoading();
  
  
 
  @override
  List<Object?> get props => [];
}
