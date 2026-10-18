import 'dart:convert';

import 'package:flutter/foundation.dart';   // ← debugPrint lives here
import 'package:http/http.dart' as http;
import 'package:simmerwave/models/radio_station.dart';
import 'package:xml/xml.dart';

class RadioApi {
  static const _baseUrl = 'https://opml.radiotime.com';

  static Future<List<RadioStation>> searchRadio(String q) async {
    final uri = Uri.parse('$_baseUrl/Search.ashx')
        .replace(queryParameters: {'query': q});

    debugPrint('🌐 Fetching URL: $uri');      // ← inside the method, uri exists

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 10));

      debugPrint('✅ Status: ${response.statusCode}');
      debugPrint('📄 Body (first 500 chars): '
          '${utf8.decode(response.bodyBytes).substring(0, 500.clamp(0, utf8.decode(response.bodyBytes).length))}');

      if (response.statusCode != 200) {
        throw Exception('Search failed: ${response.statusCode}');
      }

      final doc = XmlDocument.parse(utf8.decode(response.bodyBytes));
      final stations = doc
          .findAllElements('outline')
          .where((el) => el.getAttribute('type') == 'audio')
          .map(RadioStation.fromXml)
          .toList();

      debugPrint('📻 Parsed ${stations.length} stations');
      return stations;
    } catch (e, stackTrace) {
      debugPrint('❌ Search failed: $e');
      debugPrint('$stackTrace');
      rethrow;                                // keep FutureBuilder's error state
    }
  }
}