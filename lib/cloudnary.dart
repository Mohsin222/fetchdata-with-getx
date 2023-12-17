import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadToCloudnary extends StatefulWidget {
  const UploadToCloudnary({super.key});

  @override
  State<UploadToCloudnary> createState() => _UploadToCloudnaryState();
}

class _UploadToCloudnaryState extends State<UploadToCloudnary> {
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

  Future<void> uploadImageToCloudinary(String imagePath) async {
      Dio dio = new Dio();
  try {
    String cloudinaryUrl = 'https://api.cloudinary.com/v1_1/dv8st8mw4/upload';
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imagePath),
      'upload_preset': 'YOUR_UPLOAD_PRESET',
      // Add any additional parameters or options as needed
    });

    Response response = await dio.post(cloudinaryUrl, data: formData);

    if (response.statusCode == 200) {
      // Image uploaded successfully
      print("Image uploaded successfully");
      print(response.data);
    } else {
      // Handle error
      print("Error uploading image: ${response.statusCode}");
    }
  } catch (e) {
    // Handle exception
    print("Exception during image upload: $e");
  }
}
// upload to cloudnary
Future<void> uploadWithHttp(String path)async{
  final url = Uri.parse("https://api.cloudinary.com/v1_1/dv8st8mw4/upload");

  final request = http.MultipartRequest('POST',url)
  ..fields['upload_preset'] ='bgeybrv4'
  ..files.add(await http.MultipartFile.fromPath('file', path));

  final response =await request.send();

  if(response.statusCode==200){
    log("UPLOADED");
  }else{
    log("NOT UPLOADED");
  }
}


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('UPLOAD TO CLOUDNARY'),),
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
            // ProductServices.postProduct(imgPath: _pickedImage!.path);
            // print('_pickedImage'!.path);
            // _upload(_pickedImage!);
       
         await   uploadImageToCloudinary(_pickedImage!.path);

        // await uploadWithHttp(_pickedImage!.path);
                  }, child: Text('aaaaaaaaaaaa')),



                  ElevatedButton(onPressed: ()async{
                    
                    // await _uploadToServer(_pickedImage, base64Image);
                    
                    
                    }, child: Text('UPLOAD TO SERVER'))
        ],
      ),
    );
  }
}