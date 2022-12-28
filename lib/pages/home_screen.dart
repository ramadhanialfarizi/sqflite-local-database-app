import 'package:flutter/material.dart';
import 'package:sqflite_training_app/helper/db_helper.dart';
import 'package:sqflite_training_app/model/product_model.dart';
import 'package:sqflite_training_app/pages/update_screen.dart';

class FirstSCreen extends StatefulWidget {
  const FirstSCreen({super.key});

  @override
  State<FirstSCreen> createState() => _FirstSCreenState();
}

class _FirstSCreenState extends State<FirstSCreen> {
  DatabaseHelper? databaseHelper = DatabaseHelper();

  Future refresh() async {
    setState(() {});
  }

  Future _initDatabase() async {
    await databaseHelper!.databaseAvailable();
    setState(() {});
  }

  Future delete(int id) async {
    await databaseHelper!.deleteData(id);
    setState(() {});
  }

  @override
  void initState() {
    _initDatabase();
    super.initState();
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
              Navigator.of(context).pushNamed("/create").then((value) {
                setState(() {});
              });
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refresh,
          child: (databaseHelper != null)
              ? FutureBuilder<List<ProductModel>>(
                  future: databaseHelper!.getAllData(),
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
                            subtitle:
                                Text(snapshot.data![index].category ?? " "),
                            leading: IconButton(
                              onPressed: () {
                                delete(snapshot.data![index].id!);
                              },
                              icon: Icon(Icons.delete),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                // Navigator.of(context).pushNamed(
                                //   "/update",
                                //   arguments: snapshot.data![index],
                                // );
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return UpdateScreen(
                                      productModel: snapshot.data![index],
                                    );
                                  },
                                )).then((value) {
                                  setState(() {});
                                });
                              },
                              icon: Icon(Icons.edit),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ),
                      );
                    }
                  },
                )
              : Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  ),
                ),
        ),
      ),
    );
  }
}
