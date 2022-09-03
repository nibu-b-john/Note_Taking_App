import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:personal_diary/api/data_api.dart';
import 'package:personal_diary/api/date_dpi.dart';
import 'package:personal_diary/api/delete_api.dart';
import 'package:personal_diary/models/date.dart';
import 'package:personal_diary/models/redendering_data.dart';
import 'package:personal_diary/widgets/date_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          initialData: const [],
          future: Future.wait<List<dynamic>>(
              [DataApi.getData(), DateApi.getDate()]),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            final data = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return const Center(child: Text('Some error occurred!'));
                } else if (snapshot.hasData) {
                  return RenderedListWidget(data: data[0], date: data[1]);
                } else {
                  return const Text('nothing muchg');
                }
            }
          }),
    );
  }
}

class RenderedListWidget extends StatefulWidget {
  final data;
  final date;
  const RenderedListWidget({Key? key, required this.data, required this.date})
      : super(key: key);

  static const routeName = '/addEntry';

  @override
  State<RenderedListWidget> createState() => _RenderedListWidgetState();
}

class _RenderedListWidgetState extends State<RenderedListWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> returnedData = {"": 1};
    Data data = Data(id: 1, title: '', description: '');
    Date date = Date(date: '', datumId: 1);
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.3),
            child: const Text('Personal Diary')),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RenderedListWidget.routeName)
                    .then((value) => {
                          returnedData = value as Map<String, dynamic>,
                          returnedData.forEach(
                            (key, value) {
                              if (key == "instanceOfData") {
                                data = value;
                              } else {
                                date = value;
                              }
                            },
                          ),
                          setState(() {
                            widget.data.add(data);
                            widget.date.add(date);
                          })
                        });
              },
              icon: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Icon(Icons.add)))
        ],
      ),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.background,
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
                itemCount: widget.data.length,
                itemBuilder: (context, index) => Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Dismissible(
                          confirmDismiss: (DismissDirection direction) async {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm"),
                                  content: const Text(
                                      "Are you sure you wish to delete this item?"),
                                  actions: <Widget>[
                                    ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text("DELETE")),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text("CANCEL"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          key: ValueKey(widget.data[index].id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            child: const Icon(
                              Icons.delete,
                              size: 30,
                            ),
                          ),
                          onDismissed: (_) {
                            DeleteItemsApi.deleteItems(widget.data[index].id);
                          },
                          child: DateTellerWidget(
                              dates: widget.date[index], data: widget.data),
                        )
                      ],
                    ))),
      )),
    );
  }
}
