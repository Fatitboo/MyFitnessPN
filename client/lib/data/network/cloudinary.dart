import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:http/http.dart' as http;

const CLOUD_NAME = "dcdjan0oo";
const UPLOAD_PRESET = "gtfyctaw";

class CloudinaryNetWork {
  final cloudinary = Cloudinary.full(
    apiKey: "512949436267937",
    apiSecret: "JFaFGzZ8BmR4uzsxxrSPQFmRasI",
    cloudName: "dcdjan0oo",
  );

  // Future<Map<String, dynamic>> uploadFile(String path) async{
  //   final url = Uri.parse('https://api.cloudinary.com/v1_1/$CLOUD_NAME/upload');
  //   final request = http.MultipartRequest('POST', url)
  //     ..fields['upload_preset'] = UPLOAD_PRESET
  //     ..files.add(await http.MultipartFile.fromPath('file', path));
  //   print("aloo1");
  //   final response = await request.send();
  //   print("aloo2");
  //   if(response.statusCode == 200){
  //     final respondData = await response.stream.toBytes();
  //     final responseString = String.fromCharCodes(respondData);
  //     final jsonMap = jsonDecode(responseString);
  //     Map<String, dynamic> res = {
  //       "imageUrl": jsonMap["secure_url"],
  //       "isSuccess": true
  //     };
  //     return res;
  //   }
  //   else{
  //     Map<String, dynamic> res = {
  //       "message": "",
  //       "isSuccess": false
  //     };
  //     return res;
  //   }
  // }

  Future<Map<String, dynamic>> upload(String folder, File file, CloudinaryResourceType typeFile) async{
    final response = await cloudinary.unsignedUploadResource(
        CloudinaryUploadResource(
            uploadPreset: UPLOAD_PRESET,
            filePath: file.path,
            fileBytes: file.readAsBytesSync(),
            resourceType: typeFile,
            folder: folder,
            progressCallback: (count, total) {
              print(
                  'Uploading image from file with progress: $count/$total'
              );
            }
        )
    );

    if(response.isSuccessful) {
      Map<String, dynamic> res = {
        "imageUrl": response.secureUrl,
        "isSuccess": true
      };
      return res;
    }
    else{
      Map<String, dynamic> res = {
        "message": "",
        "isSuccess": false
      };
      return res;
    }
  }
  Future<bool> delete(String urlImage, CloudinaryResourceType typeFile) async{
    final response = await cloudinary.deleteResource(
      url: urlImage,
      resourceType: typeFile,
      invalidate: false,
    );
    return response.isSuccessful;
  }
}