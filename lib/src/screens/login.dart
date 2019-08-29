import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './Pricing.dart';

class Busse extends StatefulWidget {
  BusseMain createState() => BusseMain();
}

class BusseMain extends State<Busse> {
  String email;
  String password;
  String token;

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final String _url = "https://busse-nestjs-api.herokuapp.com/users/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Busse Hospital Disposables"),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
              emailField(),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
              passwordField(),
              Padding(padding: EdgeInsets.symmetric(vertical: 20.0)),
              loginButton(),
            ],
          ),
        ));
  }

  Widget emailField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(labelText: "Email Address"),
        validator: (input) {
          return (!input.contains("@"))
              ? "Please enter a valid e-mail address"
              : null;
        },
        onSaved: (input) {
          setState(() => email = input);
        },
      ),
    );
  }

  Widget passwordField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(labelText: "Password"),
        validator: (input) {
          return input.length < 6 ? "Password is not valid" : null;
        },
        onSaved: (input) {
          setState(() => password = input);
        },
      ),
    );
  }

  Widget loginButton() {
    return RaisedButton(
      child: Text("Login"),
      color: Colors.blue,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();

          var body = {"email": "$email", "password": "$password"};

          var response = await http.post(
            _url,
            body: body,
          );

          final String id = json.decode(response.body)['token'];

          setState(() => token = id);

          print(id);

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PricesStateless(
                  token: id,
                ),
              ));
        }
        return null;
      },
    );
  }
}
