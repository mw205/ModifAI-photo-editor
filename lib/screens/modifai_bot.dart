import 'package:flutter/material.dart';
import 'package:modifai/components/buttons/clear_text_button.dart';
import 'package:modifai/components/buttons/modifai_back_button.dart';
import 'package:modifai/components/buttons/send_button.dart';
import 'package:modifai/components/modifai_text.dart';
import 'package:photo_view/photo_view.dart';

import '../components/ModifAi bot/text_fields_modifai.dart';

class ModifAiBotPage extends StatefulWidget {
  final String mediaUrl;
  final String photoId;
  const ModifAiBotPage({
    super.key,
    required this.mediaUrl,
    required this.photoId,
  });

  @override
  State<ModifAiBotPage> createState() => _ModifAiBotPageState();
}

class _ModifAiBotPageState extends State<ModifAiBotPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController promptcontroller = TextEditingController();
  final TextEditingController selectcontroller = TextEditingController();
  String? select;
  String? prompt;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 6.0, top: 8),
          child: ModifAiBackButton(),
        ),
        backgroundColor: const Color(0xff05161A),
        centerTitle: true,
        title: const ModifAiText(
          text: "ModifAi Bot",
          fontSize: 35,
        ),
      ),
      backgroundColor: const Color(0xff05161A),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 200.0),
              child: SizedBox(
                height: height * 0.52,
                width: width * 0.95,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: PhotoView(
                    imageProvider: NetworkImage(widget.mediaUrl),
                  ),
                ),
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 3, 46, 53),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(15))),
                  height: height * 0.3,
                  child: Column(
                    children: [
                      //select mask textfield
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: ModifAiTextField.type(
                          textEditingController: selectcontroller,
                          textFieldType: ModifAiBotTextFieldType.select,
                        ),
                      ),
                      //prompt textfield
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 9),
                        child: ModifAiTextField.type(
                          textEditingController: promptcontroller,
                          textFieldType: ModifAiBotTextFieldType.prompt,
                          suffixIcon: SizedBox(
                            height: height * 0.14,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5.0, top: 1),
                                    child: SendButton(
                                      photoId: widget.photoId,
                                      promptText: promptcontroller.value.text,
                                      selectText: selectcontroller.value.text,
                                    ),
                                  ),
                                  ClearTextButton(
                                      textEditingController: promptcontroller)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
