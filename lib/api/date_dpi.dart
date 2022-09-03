import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:personal_diary/models/date.dart';
import 'package:http/http.dart' as http;

class DateApi {
  static Future<List<Date>> getDate() async {
    try {
      final url = Uri.parse('${dotenv.env['YOUR_ENDPOINT_URL']}/getdate');

      final response = await http.get(url);

      final jsonData = jsonDecode(response.body);
      List<Date> dates = [];
      for (var d in jsonData) {
        final date = Date(date: d['date'], datumId: d['datumId']);
        dates.add(date);
      }
      return dates;
    } catch (e) {
      List<Date> dates = [];
      return dates;
    }
  }
}
