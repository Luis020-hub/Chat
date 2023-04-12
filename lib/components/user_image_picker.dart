import 'dart:io';

import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    super.key,
    required this.onImagePick,
  });

  final void Function(File image) onImagePick;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
        )
      ],
    );
  }
}
