import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modifai/services/authentication.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Media {
  static const baseApi = "https://modifai.onrender.com/api";
  static const String media = "/media";
  static const models = "/models";
  static const removebg = "/remover?id=";
  static const cropper = "/cropper?id=";
  static const editor = "/editor?id=";

  static Future<Map<String, String>> getAccessToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> headers;
    if (FirebaseAuth.instance.currentUser != null) {
      if (preferences.getString("access_token") == null) {
        //AuthAPI.getModifaiAccessToken();
        headers = {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${preferences.getString("access_token")}'
        };
        Get.back();
      } else {
        headers = {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AuthAPI.getModifaiAccessToken()}'
        };
      }
      return headers;
    } else {
      headers = {'Accept': 'application/json'};
      return headers;
    }
  }

  static Future<String> uploadImage({
    File? file,
    XFile? xFile,
    Future<Uint8List?>? data,
  }) async {
    if (file != null && xFile != null && data != null) {
      return '';
    }

    String id;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Uri url;
    if (FirebaseAuth.instance.currentUser == null) {
      url = Uri.parse(
          "$baseApi$media?folderId=${preferences.getString("guestId")}");
    } else {
      url = Uri.parse("$baseApi$media");
    }
    Uint8List? toUploadImagesBytes;
    String? toUploadFileName;
    if (xFile != null) {
      toUploadImagesBytes = await xFile.readAsBytes();
      toUploadFileName = xFile.path.split('/').last;
    } else if (file != null) {
      toUploadImagesBytes = await file.readAsBytes();
      toUploadFileName = file.path.split('/').last;
    } else if (data != null) {
      toUploadImagesBytes = await data;
    }
    if (toUploadImagesBytes != null) {
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(await getAccessToken());

      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          toUploadImagesBytes,
          filename: toUploadFileName,
        ),
      );
      final uploadResponse = await request.send();
      final String responseBody;
      responseBody = await uploadResponse.stream.bytesToString();
      Map<String, dynamic>? responseMap;
      try {
        responseMap = jsonDecode(responseBody);
        if (uploadResponse.statusCode == 200) {
          id = responseMap!['media']['id'];
          return (id);
        } else {
          return "";
        }
      } catch (e) {
        Get.snackbar(
          "Alert",
          "there is an error in our servers 😔, please try again later !!",
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return "";
      }
    } else {
      return "";
    }
  }

  static Future<String?> removerbg({required String photoId}) async {
    Uri url;
    final http.Response request;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser == null) {
      url = Uri.parse(
          "$baseApi$models$removebg$photoId&folderId=${preferences.getString("guestId")}");
    } else {
      url = Uri.parse("$baseApi$models$removebg$photoId");
    }
    // Map<String, dynamic> body;
    // body = {'id': photoId};
    request = await http.post(
      url, headers: await getAccessToken(),
      // body: body
    );

    try {
      Map<String, dynamic> responseMap = jsonDecode(request.body);
      String? mediaUrl = responseMap['media_url'];
      return mediaUrl;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> cropping({required String photoId}) async {
    Uri url;
    final http.Response request;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser == null) {
      url = Uri.parse(
          "$baseApi$models$cropper$photoId&folderId=${preferences.getString("guestId")}");
    } else {
      url = Uri.parse("$baseApi$models$cropper$photoId");
    }
    request = await http.post(url, headers: await getAccessToken()
        //body: body
        );

    try {
      Map<String, dynamic> responseMap = jsonDecode(request.body);

      String? mediaUrl = responseMap['media_url'];
      return mediaUrl;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> getMedia({required String photoId}) async {
    Uri getMediaUrl;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (FirebaseAuth.instance.currentUser == null) {
      getMediaUrl = Uri.parse(
          "$baseApi$media/$photoId?folderId=${preferences.getString("guestId")}");
    } else {
      getMediaUrl = Uri.parse("$baseApi$media/$photoId");
    }

    String? mediaUrl;
    final response =
        await http.get(getMediaUrl, headers: await getAccessToken());
    Map<String, dynamic> respnseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      mediaUrl = respnseMap['media']['url'];
    }
    return mediaUrl;
  }

  static Future<String?> modifAIBot(
      {required String photoId,
      required String prompt,
      required String mask}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Uri botURL;
    if (FirebaseAuth.instance.currentUser == null) {
      botURL =
          Uri.parse("$baseApi$models$editor$photoId&text=$prompt&mask=$mask");
    } else {
      botURL = Uri.parse(
          "$baseApi$models$editor$photoId&text=$prompt&mask=$mask&folderId=${preferences.getString("guestId")}");
    }
    final request = await http.post(botURL, headers: await getAccessToken());

    String? photo;
    if (request.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(request.body);
      photo = responseMap['media_url'];
      return photo;
    } else {
      return null;
    }
  }

  static Future<File> downloadNetworkImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final directory = await getTemporaryDirectory();
    final imagePath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final File file = File(imagePath);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  static Future<bool> isImageURL(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      final contentType = response.headers['content-type'];
      return contentType != null && contentType.startsWith('image/');
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Alert",
        "This URl doesn't have an image, try another one.",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }

  static Future<Uint8List?> loadImageData(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      return null;
    }
  }

  static Future<void> addPermissions() async {
    PermissionStatus? cameraStatus;
    PermissionStatus? photosStatus;
    PermissionStatus? storageStatus;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        cameraStatus = await Permission.camera.status;
        photosStatus = await Permission.photos.status;
        storageStatus = await Permission.storage.status;
      }

      if (cameraStatus != PermissionStatus.granted) {
        cameraStatus = await Permission.camera.request();
      }

      if (photosStatus != PermissionStatus.granted) {
        photosStatus = await Permission.photos.request();
      }
      if (storageStatus != PermissionStatus.granted) {
        photosStatus = await Permission.storage.request();
      }

      if (cameraStatus != PermissionStatus.granted ||
          photosStatus != PermissionStatus.granted ||
          await Permission.storage.isDenied == true ||
          await Permission.photos.isDenied == true ||
          await Permission.camera.isDenied == true) {
        photosStatus = await Permission.storage.request();
        photosStatus = await Permission.photos.request();
        cameraStatus = await Permission.camera.request();
      }
    }
  }
}
