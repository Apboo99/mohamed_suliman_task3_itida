import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_suliman_task3_itida/constant/const_variables.dart';
import 'package:mohamed_suliman_task3_itida/core/firebase_cloud.dart';
import 'package:mohamed_suliman_task3_itida/utils/product_to_json.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    nameController.dispose();
    photoUrlController.dispose();
    priceController.dispose();
    super.dispose();
  }
  final Stream<QuerySnapshot> productStream =
      FirebaseFirestore.instance.collection("products").snapshots();
  TextEditingController nameController = TextEditingController();
  TextEditingController photoUrlController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final GlobalKey<FormState> fKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    CollectionReference product =
        FirebaseFirestore.instance.collection("products");
    // Future<void> addProduct() async {
    //   return product
    //       .add({"name": "Samsung", "image": Consts.image1, "price": "10000"})
    //       .then((value) => print("product Added"))
    //       .catchError((error) => print("Failed to add product: $error"));
    // }

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: StreamBuilder<QuerySnapshot>(
        stream: productStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong, ${snapshot.error.toString()} ');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemBuilder: (_, index) {
                  Map<String, dynamic> data = snapshot.data!.docs[index].data()!
                      as Map<String, dynamic>;
                  return Stack(
                    children: [
                      Container(
                        width: width / 2,
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.network(
                              data["image"],
                              width: 130,
                              height: 130,
                            ),
                            Text(data["name"]),
                            Text("price: ${data["price"]} \$"),
                          ],
                        ),
                      ),
                      Positioned(
                          right: 5,
                          bottom: 5,
                          child: InkWell(
                              onTap: () async {
                                await CloudStoreUtil.deleteProduct(
                                    snapshot.data!.docs[index].id);
                              },
                              child: Icon(
                                Icons.delete_outlined,
                                color: Colors.red,
                                size: 35,
                              )))
                    ],
                  );
                }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return Dialog(
                    child: Form(
                      key: fKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    labelText: "Name",
                                  ),
                                  validator: (value) {
                                    if (value!.isNotEmpty) {
                                      return null;
                                    } else {
                                      return "Invalid name";
                                    }
                                  },
                                )),
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: priceController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: "price",
                                  ),
                                  validator: (value) {
                                    if (value!.isNotEmpty) {
                                      return null;
                                    } else {
                                      return "Invalid number";
                                    }
                                  },
                                )),
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: photoUrlController,
                                  decoration: const InputDecoration(
                                    labelText: "image Link",
                                  ),
                                  validator: (value) {
                                    if (value!.isNotEmpty) {
                                      return null;
                                    } else {
                                      return "Invalid link";
                                    }
                                  },
                                )),
                            isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButton(
                                    child: const Text("Add Product"),
                                    onPressed: () async {
                                      if (fKey.currentState!.validate()) {
                                        isLoading = true;
                                        setState(() {});
                                        var product = AddProduct(
                                          name: nameController.text,
                                          image: photoUrlController.text,
                                          price: priceController.text,
                                        );
                                        bool result =
                                            await CloudStoreUtil.addNewProduct(product);
                                        if (result==true) {
                                          nameController.clear();
                                          photoUrlController.clear();
                                          priceController.clear();
                                          Navigator.pop(context);
                                          var snackBar = const SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text("Product is Added"),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else {
                                          var snackBar = const SnackBar(
                                            content: Text(
                                                "Opps there was an error!!"),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }
                                      isLoading = false;
                                      setState(() {});
                                    },
                                  )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
