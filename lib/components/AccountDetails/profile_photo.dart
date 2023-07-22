// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modifai/components/ImageViewer/modifai_progress_indicator.dart';

import 'modifai_change_detail_button.dart';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({super.key});

  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

final ImagePicker picker = ImagePicker();

class _ProfilePhotoState extends State<ProfilePhoto> {
  dynamic photo;

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      if (FirebaseAuth.instance.currentUser!.photoURL == null) {
        photo = const AssetImage("assets/images/profileImage.png");
      } else {
        photo = NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!);
      }
    }
  }

  void changePhoto() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      DialogUtils.modifAiProgressindicator();
      final imageBytes = await image.readAsBytes();
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_photos/${FirebaseAuth.instance.currentUser!.uid}');
      final UploadTask uploadTask = storageRef.putData(imageBytes);
      final TaskSnapshot downloadUrl = await uploadTask;
      final String url = await downloadUrl.ref.getDownloadURL();
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePhotoURL(url);
        setState(() {
          photo = NetworkImage(url);
        });
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Stack(
      children: [
        SizedBox(
          width: width * 0.5,
          height: height * 0.25,
          child: ClipPath(
            clipper: const ShapeBorderClipper(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(120),
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: photo, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: ChangeDetailsButton(
            onTap: () {
              changePhoto();
            },
          ),
        ),
      ],
    );
  }
}
