import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, required this.buttonString});
  final String? buttonString;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.height * 0.3,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 121, 183, 213),
          borderRadius: BorderRadius.circular(17),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 121, 183, 213).withOpacity(0.25),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes the shadow position
            ),
          ],
        ),
        child: Center(
          child: Text(
            buttonString!,
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
