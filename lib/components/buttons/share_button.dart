// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modifai/components/Output/export.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatefulWidget {
  final String mediaUrl;
  const ShareButton({super.key, required this.mediaUrl});

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color(0xff6da5c0),
      ),
      margin: const EdgeInsets.only(top: 1),
      child: IconButton(
        onPressed: () async {
          File file = await ExportImage.downloadNetworkImage(widget.mediaUrl);
          await Share.shareFiles([file.path], text: 'made with ModifAi');
        },
        icon: const Icon(
          Icons.share,
          color: Color.fromARGB(255, 226, 226, 226),
        ),
      ),
    );
  }
}
