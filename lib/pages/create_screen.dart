import 'package:flutter/material.dart';
//import 'package:path/path.dart';
import 'package:sqflite_training_app/helper/db_helper.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  final productNameController = TextEditingController();
  final productCategoryController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    databaseHelper.databaseAvailable();
  }

  @override
  void dispose() {
    productNameController.dispose();
    productCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new product"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(
                    hintText: 'Product Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* Silahkan masukan nama produk';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: productCategoryController,
                  decoration: InputDecoration(
                    hintText: 'category',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* Silahkan masukan kategori';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final validForm = formKey.currentState!.validate();
                    if (validForm) {
                      await databaseHelper.insertData({
                        'name': productNameController.text,
                        'category': productCategoryController.text,
                        'created_at': DateTime.now().toString(),
                        'update_at': DateTime.now().toString(),
                      });

                      Navigator.pop(context);
                    }
                  },
                  child: Text("Save Data"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
