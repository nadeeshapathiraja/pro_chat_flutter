import 'package:flutter/material.dart';

class CustomTextfeild extends StatelessWidget {
  const CustomTextfeild({
    Key? key,
    this.controller,
    this.preffix,
    this.hintText,
  }) : super(key: key);

  final TextEditingController? controller;
  final Widget? preffix;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: preffix,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red)),
        ),
      ),
    );
  }
}
