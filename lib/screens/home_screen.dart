import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/screens/note_editor.dart';
import 'package:notes/screens/note_reader.dart';
import 'package:notes/styles/app_style.dart';
import 'package:notes/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        backgroundColor: AppStyle.mainColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Note',
              style: GoogleFonts.kalam(
                color: Colors.white,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Recent Notes',
            style: GoogleFonts.kalam(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("notes").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    children: snapshot.data!.docs
                        .map((note) => noteCard(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NoteReader(note)));
                            }, note))
                        .toList(),
                  );
                }
                return Text(
                  "There's No Notes",
                  style: GoogleFonts.nunito(color: Colors.white),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NoteEditor()));
                },
                shape: CircleBorder(),
                child: Icon(
                  Icons.add,
                  size: 65,
                )),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
