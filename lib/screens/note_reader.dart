import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/styles/app_style.dart';

class NoteReader extends StatefulWidget {
  NoteReader(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;
  @override
  State<NoteReader> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteReader> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Note',
              style: GoogleFonts.kalam(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Mate',
              style: GoogleFonts.kalam(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.doc["note_title"], style: AppStyle.mainTitle),
            SizedBox(
              height: 4.0,
            ),
            Text(widget.doc["creation_date"], style: AppStyle.dateTitle),
            SizedBox(
              height: 28.0,
            ),
            Text(widget.doc["note_content"],
                overflow: TextOverflow.ellipsis, style: AppStyle.mainContent),
          ],
        ),
      ),
    );
  }
}
