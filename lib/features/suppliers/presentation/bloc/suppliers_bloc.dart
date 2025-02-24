import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/supplier_item.dart';
import '../../domain/usecases/get_supplier_items.dart' as get_supplier_items;

part 'suppliers_event.dart';
part 'suppliers_state.dart';

class SuppliersBloc extends Bloc<SuppliersEvent, SuppliersState> {

  final get_supplier_items.GetSupplierItems getSupplierItems;

  SuppliersBloc({
    required this.getSupplierItems
  }) : super(SuppliersInitial()) {

    on<GetSuppliersEvent>((event, emit) async {
      emit(SuppliersLoading());
      final result = await getSupplierItems.call(NoParams());
      result.fold(
        (failure) => emit(SuppliersError()), 
        (supplierItems) => emit(SuppliersLoaded(supplierItems: supplierItems))
      );
    });
  }
}
