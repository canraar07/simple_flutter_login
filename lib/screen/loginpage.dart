import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:simple_flutter/modelresponse/login.dart';
import 'package:simple_flutter/utils/apiservice.dart';
import 'package:simple_flutter/screen/dashboardspage.dart';

class LoginPage extends StatefulWidget{

  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  String username = '';
  String password = '';
  bool isLoading = false;

  void _clicButton(){
    print('ini $username dan in adalah $password');
    setState(() {
      isLoading = true;
    });
    Login();
  }

  Login() async {
    try {
      ApiService url = ApiService();
      var dio = Dio();
      Response response = await dio.get(
          "${url.baseURL}login.php?username=$username&password=$password");
      if (response != null) {
        setState(() {
          isLoading = false;
        });
        print(response.data);
        final jsonData = json.decode(response.data);
        login Login = login.fromJson(jsonData);
        print(Login.status);
        print(Login.result[0].username);
        Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
      }
    }catch(e){
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: LoadingOverlay(
          isLoading: isLoading,
          child: Form(
              child: Padding(
                  padding: EdgeInsets.only(top: 50, left: 10, right: 10),
                  child: Container(
                    height: 300,
                    child:Card(
                      child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top:30,left: 20, right: 20),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  onChanged: (value) => username = value,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'User',
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 30)),
                                TextField(
                                  onChanged: (value) => password = value,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 30)),
                                RaisedButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: _clicButton,
                                    child: Container(
                                        constraints: BoxConstraints.expand(
                                            height: 50,
                                            width: 90
                                        ),
                                        color: Colors.green,
                                        child: Center(
                                          child:Text('Login',style: TextStyle(
                                              color: Colors.white
                                          ),),
                                        )
                                    )),
                              ],
                            ),
                          )),
                    ),
                  )
              )),
          opacity: 0.5,
          progressIndicator: loadingScreen(context),
        )
    );
  }

  Widget loadingScreen(BuildContext context){
    return Center(
      child: LoadingBouncingGrid.circle(
        backgroundColor: Colors.red,
      ),
    );
  }

}