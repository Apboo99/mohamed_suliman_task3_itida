import 'package:dio/dio.dart';
import 'package:mohamed_suliman_task3_itida/utils/product_model.dart';
// class Api{
//   static Dio dio = Dio();
//   static Future<List<ProductElement>> getData(String link)async{
//     final res =await dio.get(link);
//     var response = res.data;
//     Product product = Product.fromJson(response);
//     return product.products;
//   }
//
// }

class Api {
  static final dio = Dio();
  static Future<List<ProductElement>> getProductsData() async {
    final response = await dio.get("https://dummyjson.com/products");
    var data = response.data;
    Product product = Product.fromJson(data);
    return product.products ?? [];
  }
}