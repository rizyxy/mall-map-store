import 'package:flutter/material.dart';
import 'package:mallmap_store/views/main/edit_item_page.dart';

class ItemCard extends StatelessWidget {
  ItemCard(
      {super.key,
      required this.itemDoc,
      required this.itemPic,
      required this.itemName,
      required this.itemPrice});

  String itemDoc;
  String itemPic;
  String itemName;
  int itemPrice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditItemPage(
                    itemDoc: itemDoc,
                  ))),
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 150,
              width: 150,
              child: Image.network(itemPic),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12, 12, 12, 5),
              child: Text(
                itemName,
                style: TextStyle(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Rp ${itemPrice.toString()}",
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
