import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/productservices.dart';
enum ImageSourceType { gallery, camera }
class PostProduct extends StatefulWidget {
  const PostProduct({super.key});

  @override
  State<PostProduct> createState() => _PostProductState();
}

class _PostProductState extends State<PostProduct> {
   void _handleURLButtonPress(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)));
  }

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

   var image;
  var imagePicker;
  var type;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Image Picker Example"),
        ),
         body: Center(
          child: Column(
            children: [
     
     

                   Center(
            child: GestureDetector(
              onTap: () async {
           _pickImageFromGallery();
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.red[200]),
                child: _pickedImage != null
                    ? Image.file(
                          _pickedImage!,
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.fitHeight,
                        )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.red[200]),
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),


              ),
            ),
          ),

          ElevatedButton(onPressed: ()async{
       await     ProductServices.uploadImageToCloudinary(_pickedImage!.path);
          }, child: Text('POST '))
            ],
          ),
        ));
    
  }
}




class ImageFromGalleryEx extends StatefulWidget {
  final type;
  ImageFromGalleryEx(this.type);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState(this.type);
}

class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
  var _image;
  var imagePicker;
  var type;

  ImageFromGalleryExState(this.type);

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(type == ImageSourceType.camera
              ? "Image from Camera"
              : "Image from Gallery")),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 52,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                var source = type == ImageSourceType.camera
                    ? ImageSource.camera
                    : ImageSource.gallery;
                XFile image = await imagePicker.pickImage(
                    source: source, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
                setState(() {
                  _image = File(image.path);
                });
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.red[200]),
                child: _image != null
                    ? Image.file(
                          _image,
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.fitHeight,
                        )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.red[200]),
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          ),

          ElevatedButton(onPressed: ()async{

            print(_image.toString());
             ProductServices.postProduct(imgPath: _image.toString());
            // print(_image);
          }, child: Text('aaaaaaaaaaaaaa')),




            ElevatedButton(onPressed: ()async{

            print(_image.toString());
             ProductServices productServices =ProductServices();
             await productServices.getD();
            // print(_image);
          }, child: Text('bbbb'))








        ],
      ),
    );
  }
}