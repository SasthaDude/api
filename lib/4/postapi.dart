import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Employ extends StatefulWidget {
  const Employ({super.key});

  @override
  State<Employ> createState() => _EmployState();
}

class _EmployState extends State<Employ> {

  TextEditingController employeeNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confromPasswordController = TextEditingController();

  Future<bool>? successEmployee;

  Future<bool> emoPloy(
      String employeeNameController,
      mobileController,
      userNameController,
      passwordController,
      confromPasswordController
      ) async{
    var empolyRes = await http.post(Uri.parse("http://catodotest.elevadosoftwares.com/Employee/InsertEmployee"),
    headers: <String, String>{
      'Content-Type' : 'application/json; charset=utf-8'
    },
      body: jsonEncode(<String, dynamic> {
        "employeeId": 0,
        "employeeName": employeeNameController,
        "mobile": mobileController,
        "userName": userNameController,
        "password": passwordController,
        "confirmPassword": confromPasswordController,
        "createdBy": 1
      })
    );
    return jsonDecode(empolyRes.body)["success"];
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: (successEmployee == null ? buildColumn() : buildFutureBuilder()),
          )
        ],
      ),
    );
  }

  Column buildColumn() {
    return Column(
      children: [
        TextFormField(
          controller: employeeNameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Employee Name"
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: mobileController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Mobile"
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: userNameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "User Name"
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Password"
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: confromPasswordController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Confrom Password"
          ),
        ),
        SizedBox(height: 10,),
        ElevatedButton(
            onPressed: (){
              setState(() {
                successEmployee = emoPloy(
                  employeeNameController.text,
                  mobileController.text,
                  userNameController.text,
                  passwordController.text,
                  confromPasswordController.text,
                );
              });
            },
            child: Text("Save")
        )
      ],
    );
  }

  FutureBuilder buildFutureBuilder() {
    return FutureBuilder(
        future: successEmployee,
        builder: (BuildContext context, snapshot){
          if(snapshot.hasData){
            return Text("added successfully");
          }
          if(snapshot.hasError){
            return Text("Error");
          } return CircularProgressIndicator();
        }
    );
  }
}
