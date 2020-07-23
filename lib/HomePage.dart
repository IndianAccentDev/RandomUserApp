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
    return Container(
      
    );
  }
}