import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobily/model/auth.dart';
import 'package:mobily/screens/login.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static String route = '/signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final RegExp _emailRegex = RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _emailInputWidget() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'Email Address',
        labelText: 'Email',
        border: OutlineInputBorder()
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email can\'t be blank.';
        } 

        if (!_emailRegex.hasMatch(value)) {
          return 'This is not a valid email';
        }

        return null;
      },
    );
  }

  Widget _passwordInputWidget() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'Password',
        labelText: 'Password',
        border: OutlineInputBorder()
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password can\'t be blank.';
        }
        return null;
      },
    );
  }

  Widget _submitButtonWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {

          try {
            await Provider.of<AuthProvider>(context, listen: false).signUp(
              email: _emailController.text, 
              password: _passwordController.text
            );
          } on FirebaseAuthException catch(err) {
            print('ERRRRR------------------ $err.code');
            ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Failed')));
          } catch(err) {
            print('SOMETHING WENT WRONG');
          }
        }
      },
      child: Text('Submit'),
    );
  }

  Widget _loginButtonWidget() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, Login.route);
      }, 
      child: Text(
        'I already have an account',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlutterLogo(size: 50),
                    SizedBox(height: 10),
                    Text(
                      'Create your Account', 
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    SizedBox(height: 15),
                    _emailInputWidget(),
                    SizedBox(height: 10),
                    _passwordInputWidget(),
                    SizedBox(height: 10),
                    _submitButtonWidget(context),
                    SizedBox(height: 10),
                    _loginButtonWidget()
                  ],
                )
              )
            )
          )
        )
      )
    );
  }
}