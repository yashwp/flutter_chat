import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitUser(String email, String username, String password, bool isLogin, File dp, BuildContext ctx) async {
    AuthResult _result;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        _result = await _auth.signInWithEmailAndPassword(email: email, password: password);

      } else {
        _result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        final ref = FirebaseStorage.instance.ref().child('user_dp')
          .child(_result.user.uid + '.jpg');
        await ref.putFile(dp).onComplete;
        final dpUrl = await ref.getDownloadURL();

        await Firestore.instance.collection('users').document(_result.user.uid)
            .setData({
              'username': username,
              'email': email,
              'dpUrl': dpUrl
            });
      }
      setState(() {
        _isLoading = false;
      });

    } on PlatformException catch(err) {
        var msg = 'Invalid credentials';

        setState(() {
          _isLoading = false;
        });
        if (err.message != null) {
          msg = err.message;
        }
        Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).errorColor,
        ));
    } catch(e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitUser, _isLoading)
    );
  }
}
