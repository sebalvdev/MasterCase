import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:master_case/features/suppliers/domain/entities/supplier_item.dart';

List<SupplierItemModel> supplierItemModelListFromJson(String str) =>
    List<SupplierItemModel>.from(
      json.decode(str).map((x) => SupplierItemModel.fromJson(x)));

String supplierItemModelListToString(List<SupplierItemModel> suppliers) =>
    json.encode(List<dynamic>.from(suppliers.map((x) => x.toJson())));

class SupplierItemModel extends SupplierItem {
  const SupplierItemModel({
    required super.name, 
    required super.price, 
    required super.image, 
    // required super.products
  });

  factory SupplierItemModel.fromSnapshot(DocumentSnapshot snapshot) {
    return SupplierItemModel(
      name: snapshot['name'], 
      price: snapshot['price'], 
      image: snapshot['image'], 
      // products: snapshot['product_list']
    );
  }

  factory SupplierItemModel.fromJson(Map<String, dynamic> json) {
    return SupplierItemModel(
      name: json['name'], 
      price: json['price'], 
      image: json['image'], 
      // products: json['products']
    );

  }

  Map<String, dynamic> toJson() {
    return {
      "name": name, 
      "price": price, 
      "image": image, 
      // "products": products
    };
  } 

}