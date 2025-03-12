import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';

class DetailScreen extends StatelessWidget {
  final int itemIndex;

  const DetailScreen({super.key, required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    final item = itemProvider.items[itemIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.name,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(
                item.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: item.isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                itemProvider.toggleFavorite(itemIndex);
              },
            ),
          ],
        ),
      ),
    );
  }
}