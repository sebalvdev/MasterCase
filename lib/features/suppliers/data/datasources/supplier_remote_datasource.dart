import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/cache_constants.dart';
import '../models/supplier_item_model.dart';

abstract class SupplierRemoteDatasource {
  Future<List<SupplierItemModel>> getSupplierItems();
}

class SupplierRemoteDatasourceImpl implements SupplierRemoteDatasource {
  final FirebaseFirestore firestore;
  final SharedPreferences prefs;

  SupplierRemoteDatasourceImpl({
    required this.firestore, 
    required this.prefs
  });

  @override
  Future<List<SupplierItemModel>> getSupplierItems() async {
    final cacheSuppliers = prefs.getString(cacheSuppliersList);
    if (cacheSuppliers == null) {
      final firestoreCacheSuppliers = await firestore
        .collection('games')
        .doc('emXYuSuveWscid36xb65')
        .collection('ingredient_suppliers')
        .doc('b3dPiCpY1GFcUK36aujT')
        .collection('suppliers')
        .get();
      
      List<SupplierItemModel> supplierItems = [];
      
      for (final supplier in firestoreCacheSuppliers.docs) {
        SupplierItemModel supplierItemModel = SupplierItemModel.fromSnapshot(supplier);
        supplierItems.add(supplierItemModel);
      }

      final cacheSuppliers = supplierItemModelListToString(supplierItems);
      prefs.setString(cacheSuppliersList, cacheSuppliers);

      return supplierItems;
    } else {
      final supplierList = supplierItemModelListFromJson(cacheSuppliers);
      return supplierList;
    }
  }
}