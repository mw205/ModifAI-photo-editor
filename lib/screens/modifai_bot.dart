import 'package:flutter/material.dart';
import 'package:modifai/components/buttons/clear_text_button.dart';
import 'package:modifai/components/buttons/modifai_back_button.dart';
import 'package:modifai/components/buttons/send_button.dart';
import 'package:modifai/components/modifai_text.dart';
import 'package:photo_view/photo_view.dart';

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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: TextFormField(
                          maxLines: 1,
                          textAlignVertical: TextAlignVertical.top,
                          cursorColor: const Color(0xff0f969c),
                          style: const TextStyle(color: Color(0xff0f969c)),
                          controller: selectcontroller,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 10),
                              labelStyle:
                                  const TextStyle(color: Color(0xff0f969c)),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 32, 82, 107)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff0f969c)),
                              ),
                              focusColor: const Color(0xff0f969c),
                              labelText: "Select what you want to change",
                              hintText:
                                  "tell the bot what is the the thing you want to change",
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(123, 15, 149, 156),
                                  fontSize: 15),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8),
                                child: ClearTextButton(
                                    textEditingController: selectcontroller),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 9),
                        child: TextFormField(
                          maxLines: 3,
                          maxLength: 500,
                          textAlignVertical: TextAlignVertical.top,
                          cursorColor: const Color(0xff0f969c),
                          style: const TextStyle(color: Color(0xff0f969c)),
                          controller: promptcontroller,
                          decoration: InputDecoration(
                              counterStyle: const TextStyle(
                                color: Color(0xff0f969c),
                              ),
                              suffixIcon: SizedBox(
                                height: height * 0.14,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10.0, top: 1),
                                        child: SendButton(
                                          photoId: widget.photoId,
                                          promptText: promptcontroller.text,
                                          selectText: selectcontroller.text,
                                        ),
                                      ),
                                      ClearTextButton(
                                          textEditingController:
                                              promptcontroller)
                                    ],
                                  ),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 10),
                              labelStyle:
                                  const TextStyle(color: Color(0xff0f969c)),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 32, 82, 107)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff0f969c)),
                              ),
                              focusColor: const Color(0xff0f969c),
                              labelText: "Enter a prompt",
                              hintText: "tell the bot what you want to change",
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(123, 15, 149, 156))),
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
