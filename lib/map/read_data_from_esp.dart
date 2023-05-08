// ignore_for_file: avoid_print
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class RealTimeDataBaseDisplay extends StatelessWidget {
  var databaseref = FirebaseDatabase.instance.ref().child("esp");

  RealTimeDataBaseDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Read Data From ESP',
        ),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: buildFirebaseAnimatedList(),
      ),
    );
  }

  buildFirebaseAnimatedList() {
    return FirebaseAnimatedList(
      query: databaseref,
      itemBuilder: (
        BuildContext context,
        DataSnapshot snap,
        Animation<double> animation,
        int index,
      ) {
        var de = snap
            .child(
              'int',
            )
            .value;
        var m;
        if (de == 0) {
          m = "Emp";
        } else if (de == 1) {
          m = "Full";
        }
        return Text(
          '$m',
        );
      },
    );
  }
}
