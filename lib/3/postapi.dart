import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CliEnt extends StatefulWidget {
  const CliEnt({super.key});

  @override
  State<CliEnt> createState() => _CliEntState();
}

class _CliEntState extends State<CliEnt> {

  Future<bool>? successClient;

  TextEditingController clientNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  Future<bool> cliENT(
      String clientNameController,
      phoneController,
      addressController,
      gstController,
      websiteController,
      emailController,
      contactPersonController,
      phoneNumberController,
      ) async{
    var clientRes = await http.post(Uri.parse("http://catodotest.elevadosoftwares.com/Client/InsertClient"),
    headers: <String, String> {
      'Content-Type' : 'application/json; charset=utf-8'
    },
    body: jsonEncode(<String, dynamic> {
      "clientId": 0,
      "clientName": clientNameController,
      "phone": phoneController,
      "address": addressController,
      "gst": gstController,
      "website": websiteController,
      "email": emailController,
      "contactPerson": contactPersonController,
      "phoneNumber": phoneNumberController,
      "createdBy": 1
    })
    );
    return jsonDecode(clientRes.body)["success"];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         Container(
           child: (successClient == null ? buildColumn() : buildFutureBuilder()),
         )
        ],
      ),
    );
  }

  Column buildColumn() {
    return Column(
      children: [
        TextFormField(
          controller: clientNameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "ClientName",
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: phoneController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Phone",
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: addressController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Address",
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: gstController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "GST",
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: websiteController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Website",
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Email",
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: contactPersonController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "ContactPerson",
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: phoneNumberController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Phone Number",
          ),
        ),
        SizedBox(height: 10,),
        ElevatedButton(
            onPressed: (){
              setState(() {
                successClient = cliENT(
                  clientNameController.text,
                  phoneController.text,
                  addressController.text,
                  gstController.text,
                  websiteController.text,
                  emailController.text,
                  contactPersonController.text,
                  phoneNumberController.text,
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
        future: successClient,
        builder: (BuildContext context, snapshot){
          if(snapshot.hasData){
            return Text("added successfully");
          }
          if(snapshot.hasError){
            return Text("Error");
          }
          return CircularProgressIndicator();
        }
    );
  }
}
