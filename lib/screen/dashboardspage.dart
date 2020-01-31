import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Form(
          child: Center(
            child: Text("Ini Adalah Halaman Dashboard"),
          )
      ),
    );
  }

}