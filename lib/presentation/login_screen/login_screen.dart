import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/country_code.dart';
import '../../domain/state/auth_cubit.dart';
import '../../domain/state/country_code_cubit.dart';
import '../signup_screen.dart';

part "country_code_picker.dart";
part 'footer.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHiddenPassword = true;
  TextEditingController _countryCodeController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _countryDialCode = "";
  final formKey = GlobalKey<FormState>();

  void _toggleVisibility(){
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  @override
  void dispose() {
    _countryCodeController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                    const SizedBox(height: 60),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Log in",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Phone number",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCountryCodePicker(context, _countryCodeController, _countryDialCode),
                        SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            validator: (phone) =>
                            phone == null || phone.length < 8 || _countryCodeController.text == "" || !RegExp(r'^[0-9]+$').hasMatch(phone)
                                ? 'Invalid number format'
                                : null,
                            controller: _phoneController,
                            autocorrect: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: isHiddenPassword,
                      autocorrect: false,
                      controller: _passwordController,
                      validator: (pass) =>
                      pass == null || pass.length < 8
                          ? 'Password must be at least 8 characters long'
                          : null,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: _toggleVisibility,
                          child: Icon(
                            isHiddenPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                          ),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  TextButton(
                    child: const Text(
                      "Trouble logging in?",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {},
                  ),
                  ],
                              ),
                ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async{
                      if (formKey.currentState!.validate()) {
                        String phone = _countryDialCode + _phoneController.text;
                        await context.read<AuthCubit>().login(phone, _passwordController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Log in',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(width: 4),
                    InkWell(
                      child: const Text(
                        "Create Account",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
