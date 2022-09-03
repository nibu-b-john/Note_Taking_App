import 'package:flutter/material.dart';
import 'package:personal_diary/models/redendering_data.dart';

class DateTellerWidget extends StatefulWidget {
  final dates;
  final data;
  const DateTellerWidget({Key? key, required this.dates, required this.data})
      : super(key: key);
  static const routeName = '/thisDatedScreen';

  @override
  State<DateTellerWidget> createState() => _DateTellerWidgetState();
}

class _DateTellerWidgetState extends State<DateTellerWidget> {
  bool showTitle = false;
  @override
  Widget build(BuildContext context) {
    Data toPassDataInstance = Data(title: '', description: '', id: 1);

    for (var datum in widget.data) {
      if (datum.id == widget.dates.datumId) {
        toPassDataInstance = datum;
      }
    }
    return InkWell(
      onTap: (() {
        Navigator.of(context).pushNamed(DateTellerWidget.routeName,
            arguments: toPassDataInstance);
      }),
      child: Column(
        children: [
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0))),
            margin: const EdgeInsets.only(bottom: 0),
            child: Container(
              decoration: showTitle
                  ? BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1))
                  : null,
              height: 50,
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        maxRadius: 15,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      Text(
                        widget.dates.date.toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            setState(() {
                              showTitle = !showTitle;
                            });
                          },
                          icon: Icon(showTitle
                              ? Icons.arrow_drop_up_sharp
                              : Icons.arrow_drop_down_sharp))
                    ],
                  )),
            ),
          ),
          showTitle
              ? Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        left: BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        right: BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Text('About: ',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 111,
                          child: Text(
                            toPassDataInstance.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
