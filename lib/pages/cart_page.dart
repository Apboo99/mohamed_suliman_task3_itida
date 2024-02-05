import 'package:flutter/material.dart';
import 'package:mohamed_suliman_task3_itida/services/api.dart';

import '../utils/product_model.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}
class _ProductsPageState extends State<ProductsPage> {
  bool isLoading = true;
  List<ProductElement> productList = [];

  Future<void> getData() async {
    productList = await Api.getProductsData();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(

      backgroundColor: Colors.grey,
        body: Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
      child: isLoading?const Center(child: CircularProgressIndicator(color: Colors.white,)): GridView.builder(
          itemCount: productList.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisCount: 2,
            mainAxisSpacing: 9,
            crossAxisSpacing: 9,
          ),
          itemBuilder: (_, index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              width: width / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width / 3,
                    height: 80,
                    child:Image.network(productList[index].thumbnail),
                  ),
                  Text(productList[index].title,style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                  Text('${productList[index].price.toString()} \$',style: TextStyle(fontSize: 17,color: Colors.red),),

                ],
              ),
            );
          }),
    ));
  }
}
