import 'package:equatable/equatable.dart';

class MenuItem extends Equatable{
  final String menuItemName;
  final List<String> menuItemIngredients;
  final String menuItemImagePath;

  const MenuItem({
    required this.menuItemName, 
    required this.menuItemIngredients, 
    required this.menuItemImagePath
  });
  
  @override
  List<Object?> get props => [menuItemName, menuItemIngredients, menuItemImagePath];
  
}