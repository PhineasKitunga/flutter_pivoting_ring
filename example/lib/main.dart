import 'package:flutter/material.dart';
import 'package:flutter_pivoting_ring/flutter_pivoting_ring.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Pivoting Ring Example')),
        body: Center(child: PivotingRing()),
      ),
    );
  }
}
