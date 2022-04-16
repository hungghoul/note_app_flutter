import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app_project/style/app_style.dart';

class NoteEditerScreen extends StatefulWidget {
  const NoteEditerScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditerScreen> createState() => _NoteEditerScreenState();
}

class _NoteEditerScreenState extends State<NoteEditerScreen> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
  TextEditingController _titleControler = TextEditingController();
  TextEditingController _mainControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Add a new Note", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleControler,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              date,
              style: AppStyle.dateTitle,
            ),
            SizedBox(
              height: 28.0,
            ),
            TextField(
              controller: _mainControler,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Content',
              ),
              style: AppStyle.mainContent,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async {
          FirebaseFirestore.instance.collection("notes").add({
            "note_title": _titleControler.text,
            "creation_date": date,
            "note_content": _mainControler.text,
            "color_id": color_id
          }).then((value) {
            Navigator.pop(context);
          }).catchError(
              (Error) => print("Failed to add new Note due to $Error"));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
