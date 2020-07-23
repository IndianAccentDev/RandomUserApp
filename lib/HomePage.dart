import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List userData;
  bool isLoading = true;
  final String url = "https://randomuser.me/api/?results=50";

  // Method for geeting response

  Future getData() async {
    var response = await http.get(Uri.encodeFull(url), headers: {"Accept" : "applicstion.jason"});

    List data = jsonDecode(response.body)['results'];
    setState(() {
      userData = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Users"),
      ),
      body: Container(
        child: Center(
          child: isLoading
          ?  CircularProgressIndicator()
          : ListView.builder(
            itemCount: userData == null ? 0 : userData.length,
            itemBuilder: (context, index){
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: Image(
                        width: 70.0,
                        height: 70.0,
                        fit: BoxFit.contain,
                        image: NetworkImage(
                        userData[index]['picture']['thumbnail']
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        // Name
                        Text(
                          userData[index]['name']['first']+
                          userData[index]['name']['last'],
                          style:  TextStyle(fontSize: 20.0),
                          ),

                        // Phone Number
                        Text(userData[index]['phone']),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}