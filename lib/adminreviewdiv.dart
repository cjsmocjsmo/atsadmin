import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewDivAdmin extends StatelessWidget {
  const ReviewDivAdmin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
// Column smallReviewsDiv(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          height: 700,
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
                .collection("reviewz")
                .where("approved", isEqualTo: 'no')
                .where("quarintine", isEqualTo: 'yes')
                // .where("Delete", isEqualTo: 'no')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return !snapshot.hasData
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        return AReview(
                          approved: data["approved"],
                          date: data["date"],
                          delete: data["delete"],
                          email: data["email"],
                          message: data["message"],
                          name: data["name"],
                          quarintine: data["quarintine"],
                          sig: data["sig"],
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

class AReview extends StatefulWidget {
  final String approved;
  final String date;
  final String delete;
  final String email;
  final String message;
  final String name;
  final String quarintine;
  final String sig;
  final String uuid;
  final String imgref;

  const AReview({
    Key? key,
    required this.approved,
    required this.date,
    required this.delete,
    required this.email,
    required this.message,
    required this.name,
    required this.quarintine,
    required this.sig,
    required this.uuid,
    required this.imgref,
  }) : super(key: key);

  @override
  AReviewState createState() => AReviewState();
}

class AReviewState extends State<AReview> {
  @override
  Widget build(BuildContext context) {
    return ReviewCard(
      approved: widget.approved,
      date: widget.date,
      delete: widget.delete,
      email: widget.email,
      name: widget.name,
      message: widget.message,
      quarintine: widget.quarintine,
      sig: widget.sig,
      uuid: widget.uuid,
      imgref: widget.imgref,
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
    required this.approved,
    required this.date,
    required this.delete,
    required this.email,
    required this.name,
    required this.message,
    required this.quarintine,
    required this.sig,
    required this.uuid,
    required this.imgref,
  }) : super(key: key);

  final String approved;
  final String date;
  final String delete;
  final String email;
  final String name;
  final String message;
  final String quarintine;
  final String sig;
  final String uuid;
  final String imgref;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        textStyle: const TextStyle(fontSize: 20));

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.blueAccent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                date,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                ),
              ),
              Text(
                name,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:8.0, right:30.0, bottom:8.0),
                    child: IconButton(
                      style: style,
                      icon: const Icon(Icons.thumb_up),
                      tooltip: 'Accept',
                      onPressed: () {
                        var docname = "reviews$uuid";
                        var db = FirebaseFirestore.instance;
                        db.collection("reviewz").doc(docname).update(
                          {
                            'approved': 'yes',
                            'quarintine': 'yes',
                            'delete': 'no'
                          },
                        );

                        // ElevatedButton(
                        //   style: style,
                        //   onPressed: () {
                        //     var docname = "reviews$uuid";
                        //     var db = FirebaseFirestore.instance;
                        //     db.collection("reviewz").doc(docname).update({
                        //       'approved': 'yes',
                        //       'quarintine': 'yes',
                        //       'delete': 'no'
                        //     });
                        //   },
                        //   child: const Text(
                        //     "Accept",
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 20,
                        //     ),
                        //   ),
                        // ),
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      style: style,
                      icon: const Icon(Icons.thumb_down),
                      onPressed: () {
                        var docname = "reviews$uuid";
                        var db = FirebaseFirestore.instance;
                        db.collection("reviewz").doc(docname).update({
                          'approved': 'no',
                          'quarintine': 'no',
                          'delete': 'yes'
                        });
                      },
                    ),
                  ),
                  //   child: const Text(
                  //     "Reject",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 20,
                  //     ),
                  //   ),
                  // ),
                  // ElevatedButton(
                  //   style: style,
                  //   onPressed: () {
                  //     var docname = "reviews$uuid";
                  //     var db = FirebaseFirestore.instance;
                  //     db.collection("reviewz").doc(docname).update({
                  //       'approved': 'no',
                  //       'quarintine': 'no',
                  //       'delete': 'yes'
                  //     });
                  //   },
                  //   child: const Text(
                  //     "Reject",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 20,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
