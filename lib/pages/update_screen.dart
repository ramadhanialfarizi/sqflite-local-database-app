import 'package:flutter/material.dart';
import 'package:sqflite_training_app/helper/db_helper.dart';

import '../model/product_model.dart';

class UpdateScreen extends StatefulWidget {
  final ProductModel? productModel;
  const UpdateScreen({super.key, this.productModel});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  final productNameController = TextEditingController();
  final productCategoryController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // String? name;
  // String? category;

  @override
  void initState() {
    super.initState();
    databaseHelper.databaseAvailable();
    productNameController.text = widget.productModel!.name ?? " ";
    productCategoryController.text = widget.productModel!.category ?? " ";
  }

  @override
  void dispose() {
    productNameController.dispose();
    productCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final idParameter = ModalRoute.of(context)!.settings.arguments as String;
    // name = idParameter.
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit product"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                    await databaseHelper.updateData(widget.productModel!.id!, {
                      'name': productNameController.text,
                      'category': productCategoryController.text,
                      //'created_at': DateTime.now().toString(),
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
    );
  }
}
