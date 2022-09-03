import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_diary/models/date.dart';
import 'package:personal_diary/models/redendering_data.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({Key? key}) : super(key: key);

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  final _form = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> postData(
      String title, String description) async {
    DateTime now = DateTime.now();
    var dateString = DateFormat('dd-MM-yyyy     hh:mm      EEEE').format(now);
    var url = Uri.parse('${dotenv.env['YOUR_ENDPOINT_URL']}/postDetails');
    var response = await http.post(url,
        body: jsonEncode(
            {"title": title, "description": description, "date": dateString}),
        headers: {"Content-Type": "application/json"});
    final jsonData = json.decode(response.body);
    Data data = Data(
        title: jsonData['data']['title'],
        description: jsonData['data']['description'],
        id: jsonData['data']['id']);
    Date date = Date(
        date: jsonData['date']['date'], datumId: jsonData['date']['datumId']);
    return {"instanceOfData": data, "instanceOfDate": date};
  }

  dynamic onSubmit() async {
    final validate = _form.currentState!.validate();
    if (!validate) {
      return false;
    }
    dynamic callBackResult =
        await postData(_titleController.text, _descriptionController.text);
    _form.currentState!.save();
    _titleController.clear();
    _descriptionController.clear();
    return callBackResult;
  }

  bool isLoading = false;
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : SafeArea(
            child: Scaffold(
            appBar: AppBar(
              flexibleSpace: const Center(
                  child: Text(
                'Tell me what happened today',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
            ),
            body: Container(
              color: Theme.of(context).colorScheme.background,
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Form(
                    key: _form,
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Form',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 30),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a valid title';
                            } else {
                              return null;
                            }
                          },
                          controller: _titleController,
                          style: const TextStyle(color: Colors.white),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                            labelText: 'Title',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          maxLines: null,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a valid description';
                            }
                          },
                          controller: _descriptionController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                            labelText: 'Description',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              onSubmit().then((callbackMethod) => {
                                    if (callbackMethod != false)
                                      {
                                        setState(() {
                                          isLoading = true;
                                        }),
                                        Navigator.pop(context, callbackMethod)
                                      }
                                  });
                            },
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ))
                      ],
                    )),
              ),
            ),
          ));
  }
}
