import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DeleteItemsApi {
  static void deleteItems(int id) async {
    final url = Uri.parse('${dotenv.env['YOUR_ENDPOINT_URL']}/deleteItems');
    log(id.toString());
    var response = await http.post(url,
        body: jsonEncode({"id": id}),
        headers: {"Content-Type": "application/json"});
  }
}
