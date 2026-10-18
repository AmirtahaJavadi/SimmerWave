import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simmerwave/models/radio_station.dart';
import 'package:simmerwave/pages/search_radio.dart';
import 'package:simmerwave/service/radio_api.dart';
import 'package:simmerwave/widgets/station_card.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPagestate();
}

class _RadioPagestate extends State<RadioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello there"),
      ),
      body: RadioLists(),
    ) ;
  }  
}
