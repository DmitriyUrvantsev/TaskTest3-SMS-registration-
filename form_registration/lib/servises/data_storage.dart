import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DataStorageServise extends ChangeNotifier{

  final File image;
  DataStorageServise({required this.image});


//Creating a global Variable    
Reference storageReference = FirebaseStorage.instance.ref();




void addImageToFirebase(image) async {

    //CreateRefernce to path.
   Reference ref = storageReference.child("form_registration/");

    //StorageUpload task is used to put the data you want in storage
    //Make sure to get the image first before calling this method otherwise _image will be null.

    UploadTask storageUploadTask = ref.child("image1.jpg").putFile(image);

    // if (storageUploadTask.isSuccessful || storageUploadTask.isComplete) {
          final String url = await ref.getDownloadURL();
          print("The download URL is  + $url");
   

}


}