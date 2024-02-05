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
  static Future<List<Product>> getProductsData() async {
    final response = await dio.get("https://dummyjson.com/cart/1");
    var data = response.data;
    Cart cart = Cart.fromJson(data);
    return cart.products ?? [];
  }
}