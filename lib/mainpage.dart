import 'package:flutter/material.dart';
import 'adminestimatediv.dart';
import 'adminreviewdiv.dart';

class ATSAdmin extends StatelessWidget {
  const ATSAdmin({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alphatree Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Alphatree Admin"),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Text("Estimates")),
                Tab(icon: Text("Reviews")),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              EstimateDivAdmin(),
              ReviewDivAdmin(),
            ],
          ),
        ),
      ),
    );
  }
}