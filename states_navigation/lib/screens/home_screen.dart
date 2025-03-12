import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/details_screen.dart';
import '../screens/add_item_screen.dart'; // Add this

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: itemProvider.items.length,
        itemBuilder: (context, index) {
          final item = itemProvider.items[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 2,
            child: ListTile(
              title: Text(item.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      item.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: item.isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      itemProvider.toggleFavorite(index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final shouldDelete = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Delete Item'),
                          content: Text('Are you sure you want to delete this item?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      );

                      if (shouldDelete == true) {
                        itemProvider.deleteItem(index);
                      }
                    },
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(itemIndex: index),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}