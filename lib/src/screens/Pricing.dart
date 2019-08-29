import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PricesStateless extends StatelessWidget {
  final String token;

  PricesStateless({Key key, @required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Token"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(token, style: TextStyle(fontSize: 24))),
      ),
    );
  }
}
