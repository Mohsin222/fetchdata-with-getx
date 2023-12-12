import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workwithgetx/services/productservices.dart';

class UplaodPrac extends StatefulWidget {
  const UplaodPrac({super.key});

  @override
  State<UplaodPrac> createState() => _UplaodPracState();
}

class _UplaodPracState extends State<UplaodPrac> {


    File? _pickedImage;

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  uploadImage(File image) async {
    var bytes = await rootBundle.load(_pickedImage!.path);
    var buffer = bytes.buffer;
    var imageBytes =
        buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

    var base64Image = base64Encode(imageBytes);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           InkWell(
                    onTap: () async{
                await      _pickImageFromGallery();
                    },
                    child: Container(
                      color: Colors.red,
                      child: _pickedImage == null
                          ? Icon(Icons.add_a_photo)
                          : Image.file(
                              _pickedImage!,
                              fit: BoxFit.cover,
                            ),
                      height: 200,
                      width: 100,
                    ),
                  ),

                  ElevatedButton(onPressed: ()async{
            ProductServices.postProduct(imgPath: _pickedImage!.path);
                  }, child: Text('aaaaaaaaaaaa'))
        ],
      ),
    );
  }
}