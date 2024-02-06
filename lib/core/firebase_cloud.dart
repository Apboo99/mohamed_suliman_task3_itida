import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/product_to_json.dart';

class CloudStoreUtil {
  static var db = FirebaseFirestore.instance;

  static Future<bool> addNewProduct(AddProduct model) async {
    bool result = false;
    try {
      await db.collection("products").add(model.toJson());
      result = true;
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  static Future<bool> deleteProduct(String id) async {
    bool result = false;
    try {
      await db.collection("products").doc(id).delete();
      result = true;
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
}