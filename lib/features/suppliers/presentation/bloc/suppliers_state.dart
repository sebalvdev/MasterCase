part of 'suppliers_bloc.dart';

sealed class SuppliersState extends Equatable {
  const SuppliersState();
  
  @override
  List<Object> get props => [];
}

final class SuppliersInitial extends SuppliersState {}

final class SuppliersLoading extends SuppliersState {}

final class SuppliersLoaded extends SuppliersState {
  final List<SupplierItem> supplierItems;

  const SuppliersLoaded({required this.supplierItems});

  @override
  List<Object> get props => [supplierItems];
}

final class SuppliersError extends SuppliersState {}
