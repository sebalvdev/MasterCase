import 'package:equatable/equatable.dart';

class SupplierItem extends Equatable {
  final String name;
  final int price;
  final String image;
  // final List<String> products;

  const SupplierItem({
    required this.name, 
    required this.price, 
    required this.image, 
    // required this.products
  });
  
  @override
  List<Object?> get props => [name, price, image];
}