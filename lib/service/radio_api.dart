import 'dart:convert';

import 'package:simmerwave/models/radio_station.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class RadioApi {
  static const _baseUrl = 'https://opml.radiotime.com';
  static Future<List<RadioStation>> searchRadio(String q) async {
    final uri = Uri.parse('$_baseUrl/Search.ashx')
        .replace(queryParameters: {'query': q});
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Search failed: ${response.statusCode}');
    }
    final doc = XmlDocument.parse(utf8.decode(response.bodyBytes));

    return doc
        .findAllElements('outline')
        .where((el) => el.getAttribute('type') == 'audio')
        .map(RadioStation.fromXml)
        .toList();
  }
}
