import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';

class AddItemScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();

  AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _itemNameController,
                decoration: InputDecoration(
                  labelText: 'Item Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an item name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final itemName = _itemNameController.text;
                    Provider.of<ItemProvider>(context, listen: false).addItem(itemName);
                    Navigator.pop(context); // Go back to the home screen
                  }
                },
                child: Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}