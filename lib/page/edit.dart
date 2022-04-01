import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mnpj099/model/story.dart';


class EditPage extends StatefulWidget {
  const EditPage({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final formKey = GlobalKey<FormState>();
  Animestory mytravelstory = Animestory();
  //เตรียม firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final _editFormKey = GlobalKey<FormState>();

  final TextEditingController _attraction = TextEditingController();
  final TextEditingController _story = TextEditingController();
  final TextEditingController _score = TextEditingController();

  CollectionReference travel =
      FirebaseFirestore.instance.collection('Animestory');

  // Future<void> getdata() async {
  //   FirebaseFirestore.instance
  //       .collection('Travelstory')
  //       .doc(widget.id)
  //       .get()
  //       .then((value) {
  //     Map<String, dynamic> doc = value.data()! as Map<String, dynamic>;
  //     _attraction.text = doc["attraction"];
  //     _story.text = doc["story"];
  //     _score.text = doc["score"];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(90, 0, 0, 0),
          child: const Text('Update',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 25,
              )),
        ),
      ),
      body: Form(
        key: _editFormKey,
        child: mainInput(),
      ),
    );
  }

  Widget mainInput() {
    return FutureBuilder<DocumentSnapshot>(
      future: travel.doc(widget.id).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> doc =
              snapshot.data!.data() as Map<String, dynamic>;
          _attraction.text = doc["attraction"];
          _story.text = doc["story"];
          _score.text = doc["score"];

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: _attraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ป้อนชื่ออนิเมะด้วยค่ะ';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: Colors.cyan, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: Colors.cyan, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        prefixIcon: Icon(
                          Icons.travel_explore_rounded,
                          color: Color.fromARGB(255, 241, 101, 148),
                        ),
                        label: Text(
                          'ชื่ออนิเมะ',
                          style: TextStyle(color: Color.fromARGB(255, 241, 101, 148)),
                        ),
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                      controller: _story,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ป้อนเนื้อหาของอนิเมะด้วยค่ะ';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: Colors.cyan, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: Colors.cyan, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        prefixIcon: Icon(
                          Icons.drive_file_rename_outline_outlined,
                          color: Color.fromARGB(255, 241, 101, 148),
                        ),
                        label: Text(
                          'เรื่องราว',
                          style: TextStyle(color: Color.fromARGB(255, 241, 101, 148)),
                        ),
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                      controller: _score,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ป้อนคะแนนด้วยค่ะ';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: Colors.cyan, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: Colors.cyan, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        prefixIcon: Icon(
                          Icons.scoreboard_outlined,
                          color: Color.fromARGB(255, 241, 101, 148),
                        ),
                        label: Text(
                          'คะแนน',
                          style: TextStyle(color: Color.fromARGB(255, 241, 101, 148)),
                        ),
                      )),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        update();
                      },
                      icon:
                          const Icon(Icons.add, color: Colors.amber, size: 25),
                      label: const Text(
                        "บันทึกข้อมูล",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          );
        }
        return const Text('loading');
      },
    );
  }

  Future<void> update() async {
    return FirebaseFirestore.instance
        .collection('Animestory')
        .doc(widget.id)
        .update({
          'attraction': _attraction.text,
          'story': _story.text,
          'score': _score.text
        })
        .then((value) => Navigator.pop(context))
        // ignore: avoid_print
        .catchError((error) => print("Failed to update user: $error"));
  }
}