import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mnpj099/page/edit.dart';

// ignore: camel_case_types
class datapage extends StatefulWidget {
  const datapage({Key? key}) : super(key: key);

  @override
  State<datapage> createState() => _datapageState();
}

class _datapageState extends State<datapage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Anime List",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                icon: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 70, 0),
                  child: Icon(
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
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/A6.png'),
              fit: BoxFit.cover,
            )),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Animestory")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                    children: snapshot.data!.docs.map((document) {
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Card(
                            color: Color.fromARGB(255, 159, 159, 216),
                            child: ListTile(
                              onTap: () {
                                // Navigate to Edit Product
                                var doc;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditPage(id: document.id),
                                    )).then((value) => setState(() {}));
                              },
                              leading: CircleAvatar(
                                radius: 30,
                                child: FittedBox(
                                  child: Text(
                                    document["score"],
                                    style: const TextStyle(
                                        fontSize: 35, color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                              ),
                              title: Text(
                                document["attraction"],
                                style: const TextStyle(fontSize: 15),
                              ),
                              subtitle: Text(
                                document["story"],
                                style: const TextStyle(fontSize: 13),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  // Create Alert Dialog
                                  var alertDialog = AlertDialog(
                                    title: const Text('Delete Confirmation'),
                                    content: Text(
                                        'คุณต้องการลบ ${document['attraction']} ใช่หรือไม่'),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('ยกเลิก')),
                                      TextButton(
                                        onPressed: () {
                                          delete(document.id);
                                        },
                                        child: const Text('ยืนยัน'),
                                      ),
                                    ],
                                  );
                                  // Show Alert Dialog
                                  showDialog(
                                      context: context,
                                      builder: (context) => alertDialog);
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ));
  }

  Future<void> delete(String? id) {
    return FirebaseFirestore.instance
        .collection('Animestory')
        .doc(id)
        .delete()
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
// title: Text(document["attraction"]+document["address"]),