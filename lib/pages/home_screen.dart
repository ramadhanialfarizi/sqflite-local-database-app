import 'package:flutter/material.dart';
import 'package:sqflite_training_app/helper/db_helper.dart';
import 'package:sqflite_training_app/model/product_model.dart';

class FirstSCreen extends StatefulWidget {
  const FirstSCreen({super.key});

  @override
  State<FirstSCreen> createState() => _FirstSCreenState();
}

class _FirstSCreenState extends State<FirstSCreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    databaseHelper.databaseAvailable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQFlite Example'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/create");
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refresh,
          child: FutureBuilder<List<ProductModel>>(
            future: databaseHelper.getAllData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.length == 0) {
                  return Center(
                    child: Text('Data is empty'),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].name ?? " "),
                      subtitle: Text(snapshot.data![index].category ?? " "),
                    );
                  },
                );
              } else if (snapshot.hasData == null) {
                return Center(
                  child: Text('Data not find'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
