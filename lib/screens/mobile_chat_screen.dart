import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_ui_app/style/colors.dart';
import 'package:whatsapp_ui_app/info.dart';
import 'package:whatsapp_ui_app/widgets/chat_list.dart';
//import 'package:emoji_picker/emoji_picker.dart';

class MobileChatScreen extends StatefulWidget {
  const MobileChatScreen({Key? key}) : super(key: key);

  @override
  State<MobileChatScreen> createState() => _MobileChatScreenState();
}

class _MobileChatScreenState extends State<MobileChatScreen> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: appBarColor,
          leadingWidth: 80,
          titleSpacing: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    child: SvgPicture.asset(
                      "assets/person.svg",
                      color: Colors.white,
                      height: 35,
                      width: 35,
                    ),
                    radius: 20,
                    backgroundColor: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
          title: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info[0]['name'].toString(),
                  style: TextStyle(
                    fontSize: 18.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "last seen today at 14:06",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          centerTitle: true,
          actions: [
            //------------
            // Video Call
            //------------
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.video_call),
            ),
            //-------
            // Call
            //-------
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        preferredSize: Size.fromHeight(60),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/img/whatsapp_Back.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              //-----------
              // Chat list
              //-----------
              const Expanded(
                child: ChatList(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 60,
                            child: Card(
                              margin:
                                  EdgeInsets.only(left: 2, right: 2, bottom: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextFormField(
                                controller: _controller,
                                focusNode: focusNode,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                minLines: 1,
                                onChanged: (value) {
                                  if (value.length > 0) {
                                    setState(() {
                                      sendButton = true;
                                    });
                                  } else {
                                    setState(() {
                                      sendButton = false;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type a message",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: IconButton(
                                    icon: Icon(
                                      show
                                          ? Icons.keyboard
                                          : Icons.emoji_emotions_outlined,
                                    ),
                                    onPressed: () {
                                      if (!show) {
                                        focusNode.unfocus();
                                        focusNode.canRequestFocus = false;
                                      }
                                      setState(() {
                                        show = !show;
                                      });
                                    },
                                  ),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.attach_file),
                                        onPressed: () {
                                          showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (builder) =>
                                                  bottomSheet());
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.camera_alt),
                                        onPressed: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (builder) => CameraApp(),
                                          //   ),
                                          // );
                                        },
                                      ),
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.all(5),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                              right: 2,
                              left: 2,
                            ),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Color(0xFF128C7E),
                              child: IconButton(
                                icon: Icon(
                                  sendButton ? Icons.send : Icons.mic,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          )
                        ],
                      ),
                      //show ? emojiSelect() : Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  const SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

  // Widget emojiSelect() {
  //   return EmojiPicker(
  //       rows: 4,
  //       columns: 7,
  //       onEmojiSelected: (emoji, category) {
  //         print(emoji);
  //         setState(() {
  //           _controller.text = _controller.text + emoji.emoji;
  //         });
  //       });
  // }
}
