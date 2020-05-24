import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  final void Function(File image) pickerFn;

  const ImageUpload(this.pickerFn);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File _pickedImage;

  void _pickImage() async {
    final img = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 60);
    setState(() {
      _pickedImage = img;
    });
    widget.pickerFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 45,
            backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
          ),
          FlatButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.image),
            label: Text('Add image'),
          ),
        ],
      ),
    );
  }
}
