import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mnpj099/model/story.dart';


class Formstory extends StatefulWidget {
  const Formstory({ Key? key }) : super(key: key);

  @override
  State<Formstory> createState() => _FormstoryState();
}

class _FormstoryState extends State<Formstory> {
  final formKey = GlobalKey<FormState>();
   Animestory myAnimestory =  Animestory();
  //เตรียม firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference _animestoryCollection =
      FirebaseFirestore.instance.collection(" Animestory");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Record From My Anime",
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  IconButton(
                      icon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 70, 0),
                        child: const Icon(
                          Icons.exit_to_app_rounded,
                          color: Colors.redAccent,
                          size: 30,
                        ),
                      ),
                      onPressed: () {
                        SystemNavigator.pop();
                      })
                ],
              ),
              body: Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            validator: RequiredValidator(
                                errorText:
                                    "ป้อนชื่อ อนิเมะ ด้วยค่ะ"),
                            onSaved: (attraction) {
                              myAnimestory.attraction = attraction;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.cyan, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.cyan, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
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
                            validator: RequiredValidator(
                                errorText: "ป้อนเนื้อหาด้วยค่ะ"),
                            onSaved: (story) {
                              myAnimestory.story = story;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.cyan, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.cyan, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
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
                            validator: RequiredValidator(
                                errorText: "ป้อนคะแนนความชอบด้วยค่ะ"),
                            onSaved: (score) {
                              myAnimestory.score = score;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.cyan, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.cyan, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
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
                          padding: const EdgeInsets.fromLTRB(120, 0, 0, 0),
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                await _animestoryCollection.add({
                                  "attraction": myAnimestory.attraction,
                                  "story": myAnimestory.story,
                                  "score": myAnimestory.score
                                });
                                formKey.currentState!.reset();
                                Fluttertoast.showToast(
                                    msg: "บันทึกข้อมูลเรียบร้อยแล้วค่ะ",
                                    fontSize: 15,
                                    gravity: ToastGravity.TOP);
                              }
                            },
                            icon: const Icon(Icons.add,
                                color: Color.fromARGB(255, 241, 101, 148), size: 25),
                            label: const Text(
                              "บันทึกข้อมูล",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}