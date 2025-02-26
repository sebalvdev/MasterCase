import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:master_case/core/usecases/usecase.dart';
import 'package:master_case/features/order_card/domain/entities/order_card_info.dart';
import 'package:master_case/features/order_card/domain/usecases/get_order_card_info.dart' as get_order_card_info;

part 'order_card_event.dart';
part 'order_card_state.dart';

class OrderCardBloc extends Bloc<OrderCardEvent, OrderCardState> {

  final get_order_card_info.GetOrderCardInfo getOrderCardInfo;

  OrderCardBloc({required this.getOrderCardInfo}) : super(OrderCardInitial()) {
    on<GetOrderCardInfoEvent>((event, emit) async {
      emit(OrderCardLoading());
      final failureOrOrderCardInfo = await getOrderCardInfo(NoParams());
      failureOrOrderCardInfo.fold(
        (failure) => emit(OrderCardError()),
        (orderCardInfo) => emit(OrderCardLoaded(orderCardInfo: orderCardInfo)),
      );
    });
  }
}
