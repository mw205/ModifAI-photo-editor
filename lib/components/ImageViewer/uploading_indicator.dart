import 'package:flutter/material.dart';

class UploadingIndicator extends StatefulWidget {
  const UploadingIndicator({super.key});

  @override
  State<UploadingIndicator> createState() => _UploadingIndicatorState();
}

class _UploadingIndicatorState extends State<UploadingIndicator> {
  @override
  Widget build(BuildContext context) {
    final double width= MediaQuery.of(context).size.width;
    final double height= MediaQuery.of(context).size.height;
    return SizedBox(
      width:width*(40/width),
      height: height*(40/height),
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Color(0xff6da5c0),
        ),
      ),
    );
  }
}
