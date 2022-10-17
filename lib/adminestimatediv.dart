import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class EstimateDivAdmin extends StatelessWidget {
  const EstimateDivAdmin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          height: 750,
          alignment: const Alignment(0, 0),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 47, 28, 218),
              border: Border.all(
                color: Colors.greenAccent, //color of border
                width: 2, //width of border
              ),
              borderRadius: BorderRadius.circular(5)),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("estimatz")
                .where("delete", isEqualTo: 'no')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return !snapshot.hasData
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        return AEstimate(
                          name: data['name'],
                          address: data['address'],
                          citystate: data['citystate'],
                          telephone: data['telephone'],
                          delete: data["delete"],
                          email: data["email"],
                          message: data["message"],
                          uuid: data["uuid"],
                          imgref: data["imgref"],
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}

class AEstimate extends StatefulWidget {
  final String name;
  final String address;
  final String citystate;
  final String telephone;
  final String delete;
  final String email;
  final String message;
  final String uuid;
  final String imgref;

  const AEstimate({
    Key? key,
    required this.name,
    required this.address,
    required this.citystate,
    required this.telephone,
    required this.delete,
    required this.email,
    required this.message,
    required this.uuid,
    required this.imgref,
  }) : super(key: key);

  @override
  AEstimateState createState() => AEstimateState();
}

class AEstimateState extends State<AEstimate> {
  @override
  Widget build(BuildContext context) {
    return EstimateCard(
      name: widget.name,
      address: widget.address,
      citystate: widget.citystate,
      telephone: widget.telephone,
      delete: widget.delete,
      email: widget.email,
      message: widget.message,
      uuid: widget.uuid,
      imgref: widget.imgref,
    );
  }
}

class EstimateCard extends StatelessWidget {
  const EstimateCard({
    Key? key,
    required this.name,
    required this.address,
    required this.citystate,
    required this.telephone,
    required this.delete,
    required this.email,
    required this.message,
    required this.uuid,
    required this.imgref,
  }) : super(key: key);

  final String name;
  final String address;
  final String citystate;
  final String telephone;
  final String delete;
  final String email;
  final String message;
  final String uuid;
  final String imgref;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        textStyle: const TextStyle(fontSize: 20));

    // Future<Uint8List?> downloadImage() async {
    //   final storageRef = FirebaseStorage.instance.ref();
    //   final pathReference = storageRef.child(imgref);
    //   const oneMegabyte = 1024 * 1024;
    //   final Uint8List? data = await pathReference.getData(oneMegabyte);
    //   return data;
    // }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.blueAccent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              Text(
                telephone,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                ),
              ),
              Text(
                address,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Text(
                citystate,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Text(
                imgref,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),

              imgref != "none"
                  ? _aPicCard(context, imgref)
                  : _aPicCardTxt(context),
              // Center(
              //   child: SizedBox(
              //     height: 1067,
              //     width: 600,
              //     child: Image.network(imgref),
              //   ),
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: style,
                      onPressed: () {
                        var docname = "estimate$uuid";
                        var db = FirebaseFirestore.instance;
                        db
                            .collection("estimatz")
                            .doc(docname)
                            .update({'delete': "yes"});
                      },
                      child: const Text(
                        "Completed",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Center aPicCard(durl) {
//   return Center(
//     child: SizedBox(
//       height: 710,
//       width: 400,
//       child: Image.memory(durl),
//     ),
//   );
// }

_aPicCard(BuildContext context, imgref) {
  Future<String> downloadImage() async {
    final storageRef = FirebaseStorage.instance.ref();
    final pathReference = storageRef.child(imgref);
    // const oneMegabyte = 1024 * 1024;
    // final Uint8List? data = await pathReference.getData(oneMegabyte);
    final Uint8List? data = await pathReference.getData();
    final Uint8List foo = (data as Uint8List);
    final directory = await getApplicationDocumentsDirectory();
    final String zoo = '${directory.path}/legendary.png';
    print(zoo);
    final pathOfImage = await File(zoo).create();
    final Uint8List bytes = foo.buffer.asUint8List();
    await pathOfImage.writeAsBytes(bytes);
    return zoo;
  }

  return ElevatedButton(
    style: raisedButtonStyle,
    onPressed: () async {
      print("button has been pressed");
      String imgpage = await downloadImage();
      print(imgpage);
      // final storageRef = FirebaseStorage.instance.ref();
      // final pathReference = storageRef.child(imgref);
      // const oneMegabyte = 1024 * 1024;
      // final Uint8List? data = await pathReference.getData(oneMegabyte);
      // print(data);
      // Uint8List durl = await boo;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute<void>(
      //     builder: (BuildContext context) {
      //       return Scaffold(
      //         appBar: AppBar(
      //           title: const Text(""),
      //           backgroundColor: Colors.blue,
      //         ),
      //         body: Center(
      //           child: SizedBox(
      //             height: 710,
      //             width: 400,
      //             child: Image.memory(data as Uint8List),
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // );
    },
    child: const Text('View Pic'),
  );
}

_aPicCardTxt(BuildContext context) {
  return const Text(
    "No Pics To Display",
    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
  );
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.black87,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
