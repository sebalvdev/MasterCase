import 'package:equatable/equatable.dart';

class RecipeItem extends Equatable{

  final String mealName;
  final String mealImage;
  final Map<String, dynamic> frecuencies;

  const RecipeItem({
    required this.mealName, 
    required this.mealImage, 
    required this.frecuencies
  });

  @override
  List<Object?> get props => [mealName, mealImage, frecuencies];
}