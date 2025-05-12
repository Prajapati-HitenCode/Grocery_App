import 'package:cloud_firestore/cloud_firestore.dart';

class product_model
{
   final String name;
   final int price;
   final String image;

  product_model({required this.name, required this.price, required this.image});

   factory product_model.fromMap(Map<String, dynamic> map) {
     return product_model(
       name: map['name'] ?? '',
       price: map['price'] ?? 0,
       image: map['image'] ?? 'image not found',
     );
   }
  factory product_model.fromDocument(DocumentSnapshot doc)
  {
    try
    {
      final data=doc.data() as Map<String,dynamic>;
      return product_model(
          name: data['name'],
          price: (data['price'] is int) ? data['price'] : int.tryParse(
          data['price'].toString()) ?? 0,
          image: data['imageurl']);
    }
    catch(e)
    {
      throw Exception("error while fetching data:- $e");
    }
  }
}

Future<List<product_model>> fetchProducts() async {
  QuerySnapshot snapshot =
  await FirebaseFirestore.instance.collection('product').get();

  // Convert the fetched documents to a list of product_model
  return snapshot.docs.map((doc) => product_model.fromDocument(doc)).toList();
}


