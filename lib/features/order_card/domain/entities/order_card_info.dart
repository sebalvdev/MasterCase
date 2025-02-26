import 'package:equatable/equatable.dart';

class OrderCardInfo extends Equatable {
  final String recipeName;
  final int recipePrice;
  final String recipeImage;
  final int recipeQuantity;

  const OrderCardInfo({
    required this.recipeName, 
    required this.recipePrice, 
    required this.recipeImage, 
    required this.recipeQuantity
  });
  
  @override
  List<Object?> get props => [recipeName, recipePrice, recipeImage, recipeQuantity];
}