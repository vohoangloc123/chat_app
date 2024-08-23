import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onnPickImage});
  final void Function(File pickedImage) onnPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickImageFile;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();

    // Hiển thị hộp thoại lựa chọn
    final selectedOption = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Pick an image',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.camera),
            child: const Text(
              'Camera',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
            child: const Text(
              'Library',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (selectedOption != null) {
      final pickedImage = await picker.pickImage(
        source: selectedOption,
        imageQuality: 50,
        maxWidth: 150,
      );

      if (pickedImage != null) {
        setState(() {
          _pickImageFile = File(pickedImage.path);
        });
        widget.onnPickImage(_pickImageFile!);
      } else {
        print('No image selected.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Theme.of(context).colorScheme.primary,
          backgroundImage:
              _pickImageFile != null ? FileImage(_pickImageFile!) : null,
        ),
        TextButton.icon(
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          onPressed: _pickImage,
        ),
      ],
    );
  }
}
