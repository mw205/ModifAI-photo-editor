import 'package:flutter/material.dart';

class AboutModifAiListTile extends StatefulWidget {
  final Widget answerContent;
  final Widget questionContent;
  const AboutModifAiListTile(
      {super.key, required this.answerContent, required this.questionContent});

  @override
  State<AboutModifAiListTile> createState() => _AboutModifAiListTileState();
}

class _AboutModifAiListTileState extends State<AboutModifAiListTile> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: widget.questionContent,
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          trailing: _isExpanded
              ? const Icon(
                  Icons.arrow_drop_up_rounded,
                  color: Color(0xff6da5c0),
                )
              : const Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Color(0xff6da5c0),
                ),
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: widget.answerContent,
          ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(
            indent: 25,
            endIndent: 25,
            color: Color.fromARGB(255, 255, 255, 255),
            thickness: 0.1,
          ),
        ),
      ],
    );
  }
}
