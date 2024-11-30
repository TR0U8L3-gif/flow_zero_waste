part of 'orders_cubit.dart';

sealed class OrdersState extends BaseLogicState with EquatableMixin {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState with BuildableLogicState {}

final class OrdersLoading extends OrdersState with BuildableLogicState {}

final class OrdersIdle extends OrdersState with BuildableLogicState {
  const OrdersIdle({
    required this.orders,
  });

  final List<Orders>? orders;

  @override
  List<Object> get props => [orders!];
} 

final class OrdersError extends OrdersState with ListenableLogicState {
  const OrdersError({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object> get props => [failure];
}

