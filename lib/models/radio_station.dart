import 'package:xml/xml.dart';

class RadioStation {
  final String id;
  final String name;
  final String streamUrl;
  final String? description;
  final String? imageUrl;
  final int? bitrate;

  const RadioStation({
    required this.id,
    required this.name,
    required this.streamUrl,
    this.description,
    this.imageUrl,
    this.bitrate,
  });

  /// Reads ONE <outline> element. Knows nothing about the document shape.
  factory RadioStation.fromXml(XmlElement el) {
  final url = el.getAttribute('URL');
  if (url == null) {
    throw ArgumentError('outline has no URL — not a playable station');
  }
  return RadioStation(
    id: el.getAttribute('guide_id') ?? url,
    name: el.getAttribute('text') ?? 'Unknown station',
    streamUrl: url,                              // Tune.ashx?id=...
    description: el.getAttribute('subtext'),
    imageUrl: el.getAttribute('image'),
    bitrate: int.tryParse(el.getAttribute('bitrate') ?? ''),
  );
}
}