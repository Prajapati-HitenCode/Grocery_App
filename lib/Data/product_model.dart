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
       price: map['Price'] ?? 0,
       image: map['image'] ?? 'image not found',
     );
   }
  factory product_model.fromDocument(DocumentSnapshot doc)
  {
    try
    {
      final Data=doc.data() as Map<String,dynamic>;
      return product_model(
          name: Data['name'],
          price: (Data['Price'] is int) ? Data['Price'] : int.tryParse(
          Data['Price'].toString()) ?? 0,
          image: Data['imageurl']);
    }
    catch(e)
    {
      throw Exception("error while fetching data:- $e");
    }
  }
}


