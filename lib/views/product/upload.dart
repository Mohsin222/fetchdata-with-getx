import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workwithgetx/services/productservices.dart';
import 'package:http/http.dart' as http;

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

  Dio dio = new Dio();
//upload to cloudnary
  void _upload(File? file) async {
   String fileName = file!.path.split('/').last;
print(file.path + 'aaaaaaaaaaaaaaaaaaa');
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
      'upload_preset': 'bgeybrv4',
      // Add any additional parameters or options as needed
    });


  // dio.post("http://192.168.18.72:8000/api/products/a", data: data,
  dio.post("https://api.cloudinary.com/v1_1/dv8st8mw4/upload/",data: formData,
  // options: Options(contentType: "multipart/form-data")
  
  )
  .then((response) => log(response.data.toString()))
  .catchError((error) => log(error.toString()));
}

  uploadImage(File? image) async {
    var bytes = await rootBundle.load(_pickedImage!.path);
    var buffer = bytes.buffer;
    var imageBytes =
        buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

    var base64Image = base64Encode(imageBytes);
  }
  
Future<void> uploadImageToCloudinary(String imagePath) async {
  try {
    String cloudinaryUrl = 'https://api.cloudinary.com/v1_1/dv8st8mw4/upload';
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imagePath),
      'upload_preset': 'bgeybrv4',
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




//upload to server
  Future _uploadToServer(File? file,) async {


    try {
         String fileName = file!.path.split('/').last;
print(file.path + '_uploadToServer RUNNING');
 
         FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(file.path,filename: fileName),
        'category': '654425a23db2a126392197b9',
  'price': '120',
  'name': 'CropShirt',
  'description': 'crop dop with exiting colors ',
  'brand': 'Denim',
  'countInStock': '23',
  'isFeatured': 'true'
  
      // Add any additional parameters or options as needed
    });
    // http://10.0.2.16:8000/api/v1/products/
// 
    Response  response =await Dio().post("http://192.168.18.72:8000/api/v1/products/",data: formData,
    onReceiveProgress: (count, total) {
      print(count);
    },
    
    );
    log(response.toString());
    } catch (e) {


      log(e.toString() +'ERRR');

      throw Exception("Not UPLOAD "+e.toString());
    }


 
}
    var baseImage ;
 uploadImageInBytes(File image) async {
    var bytes = await rootBundle.load(_pickedImage!.path);
    var buffer = bytes.buffer;
    var imageBytes =
        buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

    var base64Image = base64Encode(imageBytes);


    log(base64Image);
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
            uploadImageInBytes(_pickedImage!);
        //  await   uploadImageToCloudinary(_pickedImage!.path);

        // await uploadWithHttp(_pickedImage!.path);
                  }, child: Text('aaaaaaaaaaaa')),



                  ElevatedButton(onPressed: ()async{
                   await _uploadToServer(_pickedImage);
                // await  uploadImageToCloudinary(_pickedImage!.path);
              
                    
                    
                    }, child: Text('UPLOAD TO SERVER'))
        ],
      ),
    );
  }
}