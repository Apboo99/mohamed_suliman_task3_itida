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
    return Scaffold(
        backgroundColor: Colors.grey,
        body: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  )) : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                    itemCount: cartList.length,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
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
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Price: ${cartList[index].price.toString()} \$',
                              style: const TextStyle(fontSize: 19, color: Colors.red),
                            ),
                          ],
                        ),
                      );
                    })));
  }
}
