import 'package:master_case/features/order_card/domain/entities/order_card_info.dart';

class OrderCardInfoModel extends OrderCardInfo {
  const OrderCardInfoModel({
    required super.recipeName, 
    required super.recipePrice, 
    required super.recipeImage, 
    required super.recipeQuantity
  });

  factory OrderCardInfoModel.fromJson(Map<String, dynamic> json) {
    return OrderCardInfoModel(
      recipeName: json['recipeName'],
      recipePrice: json['recipePrice'],
      recipeImage: json['recipeImage'],
      recipeQuantity: json['recipeQuantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipeName': recipeName,
      'recipePrice': recipePrice,
      'recipeImage': recipeImage,
      'recipeQuantity': recipeQuantity,
    };
  }
}