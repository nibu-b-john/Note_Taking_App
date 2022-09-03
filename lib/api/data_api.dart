import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:personal_diary/models/redendering_data.dart';

class DataApi {
  static Future<List<Data>> getData() async {
    final url =
        Uri.parse('${dotenv.env['YOUR_ENDPOINT_URL']}/getHomeScreenVariables');

    var response = await http.get(
      url,
    );
    final jsonData = jsonDecode(response.body);

    List<Data> data = [];
    for (var d in jsonData) {
      Data datum =
          Data(id: d['id'], title: d['title'], description: d['description']);
      data.add(datum);
    }
    return data;
  }
}
