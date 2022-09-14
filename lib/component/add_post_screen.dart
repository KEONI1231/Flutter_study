import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:per_pro/component/circular_progress_indicator_dialog.dart';
import 'package:per_pro/component/custom_AddPost_TextFiled.dart';
import 'package:per_pro/component/custom_button.dart';
import 'package:per_pro/constant/color.dart';
import 'package:per_pro/firebase_database_model/user.dart';

class AddPost extends StatefulWidget {
  final loginUser user;
  final String postID;
  const AddPost({
    required this.postID,
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> formKey = GlobalKey();
  final ts = TextStyle(color: PRIMARY_COLOR, fontSize: 24);
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController contentTextController = TextEditingController();
  bool setAnony = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BRIGHT_COLOR,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AppBar(
                  title: Text('글 쓰기'),
                  centerTitle: true,
                  backgroundColor: PRIMARY_COLOR,
                  actions: [
                    CustomButton(
                        text: '완료', istext: true, onPressed: postfreeboard)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('제목', style: ts),
                      const SizedBox(height: 16),
                      CustomAddPostTextField(
                          controller: titleTextController, isPostTtile: true),
                      const SizedBox(height: 24),
                      Text('내용', style: ts),
                      const SizedBox(height: 16),
                      CustomAddPostTextField(
                          controller: contentTextController,
                          isPostTtile: false),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('익명', style: ts.copyWith(fontSize: 18)),
                          const SizedBox(width: 8),
                          Switch(
                            value: setAnony,
                            onChanged: (value) {
                              setState(() {
                                setAnony = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(height: 16),
                      Text(
                        '타인을 비방하면 고소 당하고 어쩌구 저쩌구등의 글을 넣으면 되겠습죠.',
                        style: ts.copyWith(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void postfreeboard() async {
    print('함수 테스트');
    if (widget.postID == 'post-free-board') {
      if (formKey.currentState == null) {
        return;
      }
      if (formKey.currentState!.validate()) {
        CustomCircular(context, '게시글 작성...');
        widget.user.postCount++;
        await firestore
            .collection('users')
            .doc(widget.user.ID)
            .update({'post count': widget.user.postCount});
        await firestore
            .collection(widget.postID)
            .doc(widget.user.ID + widget.user.postCount.toString() + '!@#')
            .set({
          'writer id': widget.user.ID,
          'title': titleTextController.text,
          'content': contentTextController.text,
          'heart': 0,
          'school': widget.user.mySchool,
          'posted time': DateTime.now().toString(),
          'anony check': setAnony,
        });
        await firestore
            .collection(widget.postID)
            .doc(widget.user.ID + widget.user.postCount.toString() + '@@')
            .collection('repl')
            .doc()
            .set({});
        Navigator.pop(context);
      }
    }
  }
}
