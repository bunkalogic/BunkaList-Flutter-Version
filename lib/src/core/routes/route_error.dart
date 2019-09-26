import 'package:flutter/material.dart';

 Route<dynamic> routeError() {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
      appBar:AppBar(
        title: Text('Error Route'),
        ),
      body: Center(
        child: Text('ERROR ROUTE'),
      ),  
    );
    }
  );
}