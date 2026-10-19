// services/Radio_service.dart
import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/adapters.dart';
import '../models/radio_schema.dart';

class RadioService {
  static const String _boxName = 'Radios';
  late Box<RadioSchema> _box;

  // Open the box once (call in main or via init())
  Future<void> init() async {
    Hive.registerAdapter(RadioSchemaAdapter()); // safe to call once
    _box = await Hive.openBox<RadioSchema>(_boxName);
  }

  // CREATE
  Future<RadioSchema> addRadio(RadioSchema Radio) async {
    await _box.put(Radio.id, Radio);
    return Radio;
  }

  // READ all
  List<RadioSchema> getAllRadios() => _box.values.toList();

  // READ one
  RadioSchema? getRadio(String id) => _box.get(id);

  // UPDATE
  Future<void> updateRadio(RadioSchema Radio) async {
    await _box.put(Radio.id, Radio);
  }

  // DELETE
  Future<void> deleteRadio(String id) async {
    await _box.delete(id);
  }

  // LISTENABLE — for reactive UI
  ValueListenable<Box<RadioSchema>> get listenable => _box.listenable();

  // CLOSE
  Future<void> dispose() async => await _box.close();
}

final radioService = RadioService();