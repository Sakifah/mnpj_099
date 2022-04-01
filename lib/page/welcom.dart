import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mnpj099/page/fromstrory.dart';
import 'package:mnpj099/page/datapage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        textTheme: GoogleFonts.notoSansThaiTextTheme(),
      ),
      home: const Welcome(title: ''),
    );
  }
}

class Welcome extends StatefulWidget {
  const Welcome({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  

  @override
  Widget build(BuildContext context) {
      return const DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              Formstory(),
              datapage()
            ],
            ),
            backgroundColor: Color.fromARGB(255, 241, 101, 148),
            bottomNavigationBar: TabBar(
              tabs: [
                Tab(text: 'Record From My Anime',icon: Icon(Icons.save_alt_outlined,color: Colors.cyan,)),
                Tab(text: 'My Anime List',icon: Icon(Icons.list_alt_outlined,color: Colors.cyan))
                
              ]
        )
      ));
  }
}
  