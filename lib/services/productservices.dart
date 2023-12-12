import 'package:dio/dio.dart';
import 'package:workwithgetx/model/product_model.dart';

class ProductServices{


 static Future postProduct({ required String imgPath})async{
  
var data = FormData.fromMap({
  // 'files': [
  //   await MultipartFile.fromFile('/C:/Users/mohsi/Downloads/IMG-20230422-WA0016.jpg', filename: '/C:/Users/mohsi/Downloads/IMG-20230422-WA0016.jpg')
  // ],
  "image":
            await MultipartFile.fromFile(imgPath, filename:'1.png'),
  // 'image':imgPath,
  'category': '654425a23db2a126392197b9',
  'price': '120',
  'name': 'CropShirt',
  'description': 'crop dop with exiting colors ',
  'brand': 'Denim',
  'countInStock': '23',
  'isFeatured': 'true'
});
    var headers = {
  // 'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGVjOTUyZTY4YzY2NTU1ZTcwZjFmNTgiLCJlbWFpbCI6Im1vaHNpbkBqamoxLmNvbSIsImlhdCI6MTY5MzIzMDM4OSwiZXhwIjoxNjkzNDg5NTg5fQ.Cv1OXxKCc2qZ4xtQxNOpEjdpea4d66zBE4tn0twGAsM',
          'Content-Type': 'multipart/form-data',
          
};

    List<ProductModel> productList =[];
    
Dio dio  = Dio();

    await dio.post("http://192.168.18.72:8000/api/v1/products/",

    
      data: data,
      options: Options(
        contentType:  'multipart/form-data',
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