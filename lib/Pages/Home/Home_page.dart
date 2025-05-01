import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/Data/product_model.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('product').snapshots(),
          builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No product found"));
          }
            List<product_model> productList = snapshot.data!.docs
              .map((doc) => product_model.fromDocument(doc)).toList();

            return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
                return Container(
                  color: Colors.cyanAccent,
                  child: ListTile(
                    title: Text(productList[index].name),
                    subtitle: Text(productList[index].price.toString()),
                  ),
                );
              },
            );
          }
        )
    );
  }
}
