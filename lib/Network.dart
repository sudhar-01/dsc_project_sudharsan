import 'dart:convert';
import 'package:http/http.dart';

class Network {
  String url;
  Network(this.url);
  Future getData() async {
    Response _response = await get(Uri.encodeFull(url));
    if (_response.statusCode == 200) {
      return json.decode(_response.body);
    } else
      throw Exception("error");
  }
}
