import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) imagePickFn;

  UserImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  final _picker = ImagePicker();

  Future _pickImage() async {
    final pickedImageFile = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickFn(File(pickedImageFile.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
        radius: 45,
      ),
      FlatButton.icon(
        onPressed: _pickImage,
        icon: Icon(Icons.image),
        label: Text('Add image'),
        textColor: Theme.of(context).primaryColor,
      ),
    ]);
  }
}
