import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
      String email,
      String username,
      String password,
      bool isLogin,
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

  void _validate() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    widget.submit(email, username, password, _isLogin, context);
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
                   TextFormField(
                     key: ValueKey('email'),
                    validator: (val) {
                      if (val.isEmpty || !val.contains('@')) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
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
