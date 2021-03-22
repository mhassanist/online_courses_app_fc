
import 'package:flutter/material.dart';

class OCErrorWidget extends StatelessWidget {
  final message;


  OCErrorWidget(this.message);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.white, child: Center(child: Text(message))),
    );
  }
}
