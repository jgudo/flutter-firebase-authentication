import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static  String route = '/login';
  final _formKey = GlobalKey<FormState>();

  Widget _emailInputWidget() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email Address'
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email can\'t be blank.';
        }
        return null;
      },
    );
  }

  Widget _passwordInputWidget() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password'
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
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Processing Data')));
        }
      },
      child: Text('Submit'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login')
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: <Widget>[
                _emailInputWidget(),
                _passwordInputWidget(),
                _submitButtonWidget(context)
              ],
            )
          )
        )
      )
    );
  }
}