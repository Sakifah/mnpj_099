import 'package:flutter/material.dart';
import 'package:mnpj099/page/login.dart';
import 'package:mnpj099/page/register.dart';

class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/A1.jpg'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 100, 10, 50),
                child: Image.asset('images/logo.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  login(),
                  const SizedBox(
                    width: 20,
                  ),
                  register(),
                ],
              )
            ],
          ),
        ),
      ),
    )
    );
  }


  SizedBox login() {
    return SizedBox(
        child: ElevatedButton.icon(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const Login();
              }));
            },
            icon: Icon(
              Icons.login,
              color: Color.fromARGB(255, 241, 101, 148), size: 25,
            ),
            label: Text(
              "Login",
              style: TextStyle(fontSize: 20, color: Colors.black),
            )));
  }


 SizedBox register() {
    return SizedBox(
        child: ElevatedButton.icon(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const Register();
        }));
      },
      icon: const Icon(Icons.add, color: Color.fromARGB(255, 241, 101, 148), size: 25),
      label: const Text(
        "Register",
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    ));
  }
}