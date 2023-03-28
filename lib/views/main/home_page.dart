import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mallmap_store/database/item_crud.dart';
import 'package:mallmap_store/model/item.dart';
import 'package:mallmap_store/views/auth/profile_page.dart';
import 'package:mallmap_store/views/main/create_item_page.dart';
import 'package:mallmap_store/widgets/item_card.dart';
import 'package:mallmap_store/widgets/layout/main_layout.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainLayout(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome Back",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage())),
                    child: Icon(Icons.person),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    isDense: true,
                    hintText: "Search item",
                    hintStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ALL ITEMS",
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateItemPage())),
                    child: Text(
                      "CREATE ITEM",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: ItemCRUD.items
                      .where('storeId',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.size != 0) {
                        return _buildItems(snapshot);
                      } else {
                        return Center(child: Text("No Items Yet"));
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  GridView _buildItems(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      childAspectRatio: 0.7,
      children: snapshot.data!.docs
          .map((e) => ItemCard(
              itemDoc: e.id,
              itemPic: e.get('itemPicture'),
              itemName: e.get('itemName'),
              itemPrice: e.get('itemPrice')))
          .toList(),
    );
  }
}
