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
  List<Product> cartList = [];

  Future<void> getData() async {
    cartList = await Api.getProductsData();
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
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                :
                // GridView.builder(
                //
                //     physics: BouncingScrollPhysics(),
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //
                //       crossAxisCount: 2,
                //       mainAxisSpacing: 9,
                //       crossAxisSpacing: 9,
                //     ),
                //     itemCount:cartList.length ,
                //     itemBuilder: (_, index) {
                //
                //       return Container(
                //         decoration: BoxDecoration(
                //             color: Colors.white, borderRadius: BorderRadius.circular(25)),
                //         width: width / 2,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             Container(
                //               width: width / 3,
                //               height: 80,
                //               child:Image.network(cartList[index].thumbnail),
                //             ),
                //             Text(cartList[index].title,style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                //             Text('${cartList[index].price.toString()} \$',style: TextStyle(fontSize: 17,color: Colors.red),),
                //
                //           ],
                //         ),
                //       );
                //
                //     }),
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                    itemCount: cartList.length,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 15),
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                            color: Colors.lightGreenAccent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(250),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          cartList[index].thumbnail),
                                      fit: BoxFit.cover)),
                            ),
                            Text(
                              cartList[index].title,
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Price: ${cartList[index].price.toString()} \$',
                              style: TextStyle(fontSize: 19, color: Colors.red),
                            ),
                          ],
                        ),
                      );
                    })));
  }
}
