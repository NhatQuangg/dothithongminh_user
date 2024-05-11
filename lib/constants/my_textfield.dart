// MyTextField
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.keyboardType
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = true;
  bool _isPasswordFocused = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      onTap: () {
        if (widget.obscureText) {
          setState(() {
            _isPasswordFocused = true;
          });
        }
      },
      onChanged: (value) {
        if (widget.obscureText && !_isPasswordFocused) {
          setState(() {
            _isPasswordFocused = true;
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty)
          return "Please input your ${widget.hintText.toLowerCase()}";
      },
      decoration: InputDecoration(
          suffixIcon: widget.obscureText && _isPasswordFocused
              ? IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          )
              : null,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(30.0))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.all(Radius.circular(30.0))
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(30.0))
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(30.0))
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontWeight: FontWeight.w100,
            fontSize: 15,
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
    );
  }
}