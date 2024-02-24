import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:personal_diary/models/redendering_data.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datum = (ModalRoute.of(context)?.settings.arguments) as Data;

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.15),
              child: Text(
                datum.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          )),
      body: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            border: Border.all(
                color: Theme.of(context).colorScheme.primary, width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  // child: const Text(
                  //   "Description",
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 30,
                  //       decoration: TextDecoration.underline),
                  //   textAlign: TextAlign.center,
                  // ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  datum.description,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
