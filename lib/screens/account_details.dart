import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifai/components/AccountDetails/logout_button.dart';
import 'package:modifai/components/AccountDetails/modifai_change_detail_button.dart';
import 'package:modifai/components/AccountDetails/profile_photo.dart';
import 'package:modifai/components/ImageViewer/modifai_progress_indicator.dart';
import 'package:modifai/components/buttons/confirm_name_button.dart';
import 'package:modifai/components/buttons/modifai_back_button.dart';

import '../components/AccountDetails/delete_account_button.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final TextEditingController _nameController = TextEditingController();
  bool _isEditingName = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = FirebaseAuth.instance.currentUser!.displayName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 6.0, top: 8),
          child: ModifAiBackButton(),
        ),
        backgroundColor: const Color(0xff05161A),
        actions: [
          if (_isEditingName)
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 8),
              child: ConfirmNameButton(
                newName: _nameController.text,
                onPressed: () async {
                  final newName = _nameController.text;
                  if (newName.isNotEmpty) {
                    final User? user = FirebaseAuth.instance.currentUser;
                    DialogUtils.modifAiProgressindicator();
                    if (user != null) {
                      await user.updateDisplayName(newName);
                      await user.reload();
                      Get.back();
                      setState(() {
                        _isEditingName = false;
                      });
                    }
                  }
                },
              ),
            )
        ],
      ),
      backgroundColor: const Color(0xff05161A),
      body: ListView(
        children: [
          Column(
            children: [
              const Center(child: ProfilePhoto()),
              SizedBox(
                height: height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 16.0,
                      ),
                      child: Text(
                        'Name',
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff6da5c0)),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.15,
                    ),
                    SizedBox(
                      width: width * 0.5,
                      child: _isEditingName
                          ? TextField(
                              controller: _nameController,
                              style: TextStyle(
                                  color: const Color(0xFFFFFFFF),
                                  fontSize: height * 0.021),
                              decoration: const InputDecoration(
                                hintText: 'Name',
                                hintStyle: TextStyle(color: Colors.white60),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white60),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            )
                          : Text(
                              (FirebaseAuth.instance.currentUser != null)
                                  ? FirebaseAuth
                                      .instance.currentUser!.displayName!
                                  : 'No name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: height * 0.021),
                            ),
                    ),
                    ChangeDetailsButton(
                      onTap: () {
                        setState(() {
                          _isEditingName = true;
                          _nameController.text =
                              FirebaseAuth.instance.currentUser!.displayName ??
                                  '';
                        });
                      },
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
                indent: 10,
                endIndent: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: 
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 16.0,
                      ),
                      child: Text(
                        'Email',
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff6da5c0)),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.159,
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser!.email!,
                      style: TextStyle(
                          color: Colors.white, fontSize: height * 0.021),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
                indent: 10,
                endIndent: 30,
              ),
              SizedBox(height: height * 0.15),
              const LogoutButton(),
              const DeleteAccountButton()
            ],
          ),
        ],
      ),
    );
  }
}
