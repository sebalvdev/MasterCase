part of 'order_card_bloc.dart';

sealed class OrderCardEvent extends Equatable {
  const OrderCardEvent();

  @override
  List<Object> get props => [];
}

class GetOrderCardInfoEvent extends OrderCardEvent {
  const GetOrderCardInfoEvent();
}
