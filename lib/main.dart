import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login_view.dart';
import 'mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ATSAdminMain());
}

class ATSAdminMain extends StatelessWidget {
  const ATSAdminMain({Key? key}) : super(key: key);

  static const String _title = "AlphaTreeService";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        '/admin': (context) => const ATSAdmin(),
      },
    );
  }
}
