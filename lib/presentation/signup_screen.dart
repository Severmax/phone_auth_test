import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../domain/models/country_code.dart';
import '../domain/state/auth_cubit.dart';
import '../domain/state/country_code_cubit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isHiddenPassword = true;
  TextEditingController _countryCodeController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordRepeatController = TextEditingController();
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
    _passwordRepeatController.dispose();
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
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(height: 60,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Create account",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Phone number",
                        style: TextStyle(
                            color: Colors.black45
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: (){
                            context.read<CountryCodeCubit>().fetchCountryCodes();
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return BlocBuilder<CountryCodeCubit, List<CountryCode>>(
                                  builder: (context, countryCodes) {
                                    if (countryCodes.isEmpty) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                labelText: 'Search by country name',
                                                prefixIcon: Icon(Icons.search),
                                              ),
                                              onChanged: (query){
                                                context.read<CountryCodeCubit>().filterCountryCodes(query);
                                              },
                                            ),
                                          ),
                                          Expanded(child: Center(child: CircularProgressIndicator())),
                                        ],
                                      );
                                    } else {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                labelText: 'Search by country name',
                                                prefixIcon: Icon(Icons.search),
                                              ),
                                              onChanged: (query){
                                                context.read<CountryCodeCubit>().filterCountryCodes(query);
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: countryCodes.length,
                                              itemBuilder: (context, index) {
                                                final countryCode = countryCodes[index];
                                                return InkWell(
                                                  onTap: () {
                                                    _countryCodeController.text = "${countryCode.code} ${countryCode.dialCode}";
                                                    _countryDialCode = countryCode.dialCode;
                                                    Navigator.pop(context);
                                                  },
                                                  child: ListTile(
                                                    title: Text(countryCode.name),
                                                    trailing: Text(
                                                      '${countryCode.code}  ${countryCode.dialCode}',
                                                      style: TextStyle(fontSize: 15),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 110,
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: _countryCodeController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 28, color: Colors.black38,),
                                ),

                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            validator: (phone) =>
                            phone == null || phone.length != 9 || _countryCodeController.text == "" || !RegExp(r'^[0-9]+$').hasMatch(phone)
                                ? 'Invalid number format'
                                : null,
                            autocorrect: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      autocorrect: false,
                      decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.normal
                          )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: _passwordController,
                      autocorrect: false,
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
                              fontWeight: FontWeight.normal
                          )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: _passwordRepeatController,
                      autocorrect: false,
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
                          hintText: 'Repeat Password',
                          hintStyle: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.normal
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width:  double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()){
                          String phone = _countryDialCode + _phoneController.text;
                          await context.read<AuthCubit>().register(phone, _passwordController.text, _passwordRepeatController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Create account', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have a account?"),
                      SizedBox(width: 4,),
                      InkWell(
                          child: const Text("Log In", style: TextStyle(color: Colors.blue),),
                          onTap: (){
                            Navigator.of(context).pop();
                          }
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
