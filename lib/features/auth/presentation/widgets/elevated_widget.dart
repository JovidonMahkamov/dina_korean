import 'package:flutter/material.dart';

class ElevatedWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const ElevatedWidget({super.key, required this.onPressed,required this.text});
  @override
  Widget build (BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        minimumSize: const Size(double.infinity, 49),
      ),
      onPressed:onPressed,
      child:  Center(
        child: Text(
          text,
          style: const TextStyle (color: Colors.white),
        ), // Text
      ), // Center
    );
  }

}