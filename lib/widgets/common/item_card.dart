import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key,
      required this.itemDoc,
      required this.itemPic,
      required this.itemName,
      required this.itemPrice});

  final String itemDoc;
  final String itemPic;
  final String itemName;
  final int itemPrice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/edit-product',
          arguments: {'itemDoc': itemDoc}),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 150,
            width: 150,
            child: Image.network(itemPic),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 5),
            child: Text(
              itemName,
              style: const TextStyle(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Rp ${itemPrice.toString()}",
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
