import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mallmap_store/model/product.dart';
import 'package:mallmap_store/repository/product_repository.dart';
import 'package:mallmap_store/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  String query = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: MainLayout(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Welcome Back",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/profile'),
                      child: const Icon(Icons.person),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: "Search products",
                      hintStyle: const TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "ALL PRODUCTS",
                      style: TextStyle(color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, '/create-product'),
                      child: const Text(
                        "CREATE PRODUCT",
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                    stream: ProductRepository.products
                        .where('storeId',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.size != 0) {
                          List<Product> products = snapshot.data!.docs
                              .map((e) => Product(
                                  productId: e.id,
                                  storeId: e.get('storeId'),
                                  pictureUrl: e.get('pictureUrl'),
                                  name: e.get('name'),
                                  description: e.get('description'),
                                  price: e.get('price')))
                              .where((element) => element.name.contains(query))
                              .toList();

                          return GridView.builder(
                              itemCount: products.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.8, crossAxisCount: 2),
                              itemBuilder: (context, index) => ItemCard(
                                  itemDoc: products[index].productId!,
                                  itemPic: products[index].pictureUrl,
                                  itemName: products[index].name,
                                  itemPrice: products[index].price));
                        } else {
                          return const Text(
                            "No Product Yet",
                            textAlign: TextAlign.center,
                          );
                        }
                      }

                      return const Center(child: CircularProgressIndicator());
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
