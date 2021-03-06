import 'dart:io';

import 'package:chat_app/screens/auth/widgets/image_upload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
      String email,
      String username,
      String password,
      bool isLogin,
      File dp,
      BuildContext ctx,
      ) submit;

  const AuthForm(this.submit, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String username;
  String password;
  var _isLogin = true;
  File _userDp;

  void _pickerImage(File image) {
    _userDp = image;
  }

  void _validate() {
    FocusScope.of(context).unfocus();

    if (_userDp == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).errorColor,
        content: Text('Please upload an image'),
      ));
      return;
    }

    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    widget.submit(email, username, password, _isLogin, _userDp, context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) ImageUpload(_pickerImage),
                   TextFormField(
                     key: ValueKey('email'),
                    validator: (val) {
                      if (val.isEmpty || !val.contains('@')) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                     autocorrect: false,
                     textCapitalization: TextCapitalization.none,
                     enableSuggestions: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    onSaved: (val) {
                      email = val.trim();
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('uname'),
                      validator: (val) {
                      if (val.isEmpty || val.length < 3) {
                        return 'Enter valid username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                    onSaved: (val) {
                      username = val.trim();
                    },
                  ),
                  TextFormField(
                    key: ValueKey('pass'),
                    validator: (val) {
                      if (val.isEmpty || val.length < 7) {
                        return 'Password is too short';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    onSaved: (val) {
                      password = val.trim();
                    },
                  ),
                  SizedBox(height: 24),
                  widget.isLoading ? CircularProgressIndicator() :
                  RaisedButton(
                    child: Text(_isLogin ? 'Login' : 'Sign Up'),
                    onPressed: _validate,
                  ),
                  SizedBox(height: 8),
                  if (!widget.isLoading)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin ? 'Create new account' : 'Already have an account?'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
