

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:workwithgetx/model/product_model.dart';

class ProductServices{


   static Future<void> uploadImageToCloudinary(String imagePath) async {
      Dio dio = new Dio();
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
      log(response.data['url']);
if(response.data['url'] !=null){
await  postProduct(imgPath: response.data['url']);
}

    } else {
      // Handle error
      log("Error uploading image: ${response.statusCode}");
    }
  } catch (e) {
    // Handle exception
    log("Exception during image upload: $e".toString());
  }
}


 static Future postProduct({ required String imgPath})async{
  
var data = FormData.fromMap({
  // 'files': [
  //   await MultipartFile.fromFile('/C:/Users/mohsi/Downloads/IMG-20230422-WA0016.jpg', filename: '/C:/Users/mohsi/Downloads/IMG-20230422-WA0016.jpg')
  // ],
  "image": imgPath,

  'category': '654425a23db2a126392197b9',
  'price': '120',
  'name': 'CropShirt',
  'description': 'crop dop with exiting colors ',
  'brand': 'Denim',
  'countInStock': '23',
  'isFeatured': 'true'
});
//     var headers = {
//   // 'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGVjOTUyZTY4YzY2NTU1ZTcwZjFmNTgiLCJlbWFpbCI6Im1vaHNpbkBqamoxLmNvbSIsImlhdCI6MTY5MzIzMDM4OSwiZXhwIjoxNjkzNDg5NTg5fQ.Cv1OXxKCc2qZ4xtQxNOpEjdpea4d66zBE4tn0twGAsM',
//           'Content-Type': 'multipart/form-data',
          
// };

    List<ProductModel> productList =[];
    
Dio dio  = Dio();

    await dio.post("http://192.168.18.72:8000/api/v1/products/",

    
      data: data,
      options: Options(
        // contentType:  'multipart/form-data',
      )
    
    ).then((value){
print(value);
    }).catchError((err){
      
      print('CATCH ERROR   '+err.toString());
      throw Exception('aaaaaaaa');

    });
  }



  getD()async{
    Dio dio  = Dio();

    await dio.get("http://192.168.18.72:8000/api/v1/products/65789b31ad6e8176e170ad81",

    
   
    
    ).then((value){
print(value.toString() +'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    }).catchError((err){

      throw Exception('aaaaaaaa');
      
      print('CATCH ERROR   '+err.toString());
    });
  }
}