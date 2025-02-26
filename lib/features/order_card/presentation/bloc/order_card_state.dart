part of 'order_card_bloc.dart';

sealed class OrderCardState extends Equatable {
  const OrderCardState();
  
  @override
  List<Object> get props => [];
}

final class OrderCardInitial extends OrderCardState {}

final class OrderCardLoading extends OrderCardState {}

final class OrderCardLoaded extends OrderCardState {
  final OrderCardInfo orderCardInfo;

  const OrderCardLoaded({required this.orderCardInfo});

  @override
  List<Object> get props => [orderCardInfo];
}

final class OrderCardError extends OrderCardState {}
