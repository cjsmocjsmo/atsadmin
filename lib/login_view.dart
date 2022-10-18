// import 'package:auth_example/signup/view/signup_view.dart';
// import 'package:auth_service/signup_view.dart';
// import 'package:auth_example/home/view/home_view.dart';
// import 'signup_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController loginemailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? loginemail = "";
  String? password = "";
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alphatree Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Text('Admin Login'),
          centerTitle: true,
        ),
        body: FocusTraversalGroup(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            onChanged: () {
              Form.of(primaryFocus!.context!)!.save();
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(200, 50)),
                      child: TextFormField(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "A Name is required";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'loginemail',
                        ),
                        onSaved: (String? value) {
                          loginemail = value;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(200, 50)),
                      child: TextFormField(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "A Name is required";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'password',
                        ),
                        onSaved: (String? value) {
                          password = value;
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (loginemail == "curtis@alphatreeio.xyz" &&
                          password == "0205") {
                        Navigator.pushNamed(context, '/admin');
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
