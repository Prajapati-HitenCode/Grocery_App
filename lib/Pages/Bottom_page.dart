import 'package:flutter/material.dart';
import 'package:groceryapp/Pages/Account/Account_page.dart';
import 'package:groceryapp/Pages/Cart/Cart_page.dart';
import 'package:groceryapp/Pages/Home/Home_page.dart';
import 'package:groceryapp/Pages/Login_page.dart';
import 'package:groceryapp/Pages/Search/Search_page.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  late List<Widget> pages = [];
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    setpages();
  }

  void setpages() {
    setState(() {
      pages = [HomePage(), SearchPage(), CartPage(), AccountPage()];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
      return Center(child: CircularProgressIndicator()); // Show a loading indicator while fetching data
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Lima'),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login_page()),
          ),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: IndexedStack(
        index: pageIndex, // Use IndexedStack to preserve state
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(context),
    );
  }

  Widget BottomNavigationBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black87,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
              Icons.home,
              color: Colors.green,
              size: 35,
            )
                : const Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
              Icons.search_outlined,
              color: Colors.green,
              size: 35,
            )
                : const Icon(
              Icons.search,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
              Icons.shopping_cart,
              color: Colors.green,
              size: 35,
            )
                : const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
              Icons.person,
              color: Colors.green,
              size: 35,
            )
                : const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}