import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Allocate extends StatefulWidget {
  const Allocate({super.key});

  @override
  State<Allocate> createState() => _AllocateState();
}

class _AllocateState extends State<Allocate> {

  TextEditingController descriptionController = TextEditingController();
  TextEditingController scheduledDateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController startedDateController = TextEditingController();
  TextEditingController completedDateController = TextEditingController();
  TextEditingController uploadsPathController = TextEditingController();

  Future<bool>? successAllo;

  Future<bool> allo (String descriptionController,
      scheduledDateController,
      dueDateController,
      statusController,
      startedDateController,
      completedDateController,
      uploadsPathController
      ) async{
    var alloRes = await http.post(Uri.parse("http://catodotest.elevadosoftwares.com/Allocation/InsertAllocation"),
    headers: <String, String>{
      'Content-Type' : 'application/json; charset=utf-8'
    },
      body: jsonEncode(<String, dynamic> {
        "allocationId": 0,
        "clientId": 1,
        "categoryId": 1,
        "employeeId": 1,
        "description": descriptionController,
        "scheduledDate":scheduledDateController,
        "dueDate":  dueDateController,
        "status": statusController,
        "startedDate": startedDateController,
        "completedDate":  completedDateController,
        "uploadsPath": uploadsPathController,
        "createdBy": 1
      })
    );
    return jsonDecode(alloRes.body)["success"];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: (successAllo == null ? buildColumn() : buildFutureBuilder()),
          )
        ],
      ),
    );
  }

  Column buildColumn() {
    return Column(
      children: [
        TextFormField(
          controller: descriptionController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Description"
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: scheduledDateController,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "ScheduledDate"
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: dueDateController,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "DueDate"
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: statusController,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Status"
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: startedDateController,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "StartedDate"
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: completedDateController,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "CompletedDate"
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: uploadsPathController,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "UploadsPath"
          ),
        ),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: (){
          setState(() {
            successAllo = allo(
              descriptionController.text,
              scheduledDateController.text,
              dueDateController.text,
              statusController.text,
              startedDateController.text,
              completedDateController.text,
              uploadsPathController.text
            );
          });
        },
            child: Text("Save"),
        )
      ],
    );
  }

  FutureBuilder buildFutureBuilder() {
    return FutureBuilder(
        future: successAllo,
        builder: (BuildContext context, snapshot){
          if(snapshot.hasData){
            return Text("added successfully");
          }
          if(snapshot.hasError){
            return Text("error");
          } return CircularProgressIndicator();
        }
    );
  }
}
