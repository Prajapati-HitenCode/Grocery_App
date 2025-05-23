import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groceryapp/Pages/Bottom_page.dart';

class Login_page extends StatefulWidget {
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  late bool _isHidden=false;

  @override
  void initState() {

    super.initState();
    emailController.text='';
    passController.text='';
    _isHidden=true;
  }

  @override
  void dispose() {

    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  changeVisibility()
  {
    setState(() {
      _isHidden=!_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body:loginScreen(),
    );
  }

  Widget loginScreen() {
    return SingleChildScrollView(
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Container(
              color: Colors.green,
              child: Icon(
                Icons.person,
                size: 130,
                color: Colors.white,
              ),
            ),
          ),
          Text('Login',style: GoogleFonts.alfaSlabOne(textStyle: TextStyle(fontSize: 60.0),)),
          SizedBox(height: 20),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20.0,left: 20.0,bottom: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1,color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                        icon: Icon(Icons.mail),
                        hintText: 'Enter Email ID',
                        border: InputBorder.none
                    )
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20.0,left: 20.0,bottom: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1,color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                    controller: passController,
                    obscureText: _isHidden,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: 'Enter Password',
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                        suffixIcon: IconButton(onPressed: changeVisibility,
                            icon: Icon( _isHidden? Icons.visibility_off : Icons.visibility)),
                        fillColor: Colors.grey[400],
                        border: InputBorder.none
                    )
                ),
              ),
              TextButton(
                  style: ButtonStyle(
                    minimumSize: WidgetStatePropertyAll<Size>(Size(150, 50)),
                    backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomPage()),
                    );
                  },
                  child: Text('Login',style: TextStyle(color: Colors.black,fontSize: 20.0),)
              ),
            ],
          ),
          SizedBox(height: 150)
        ],
      ),
    );
  }
}