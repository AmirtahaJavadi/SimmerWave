import 'package:flutter/material.dart';
import 'package:simmerwave/models/radio_station.dart';
import 'package:simmerwave/widgets/station_card.dart';

class RadioLists extends StatefulWidget {
  const RadioLists({super.key});

  @override
  State<RadioLists> createState() => _RadioListsState();
}

class _RadioListsState extends State<RadioLists> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          StationCard(
            station: RadioStation(
              id: "id",
              name: "name",
              streamUrl: "streamUrl",
            ),
          ),
          StationCard(
            station: RadioStation(
              id: "id",
              name: "name",
              streamUrl: "streamUrl",
            ),
          ),
          StationCard(
            station: RadioStation(
              id: "id",
              name: "name",
              streamUrl: "streamUrl",
            ),
          ),
          StationCard(
            station: RadioStation(
              id: "id",
              name: "name",
              streamUrl: "streamUrl",
            ),
          ),
          StationCard(
            station: RadioStation(
              id: "id",
              name: "name",
              streamUrl: "streamUrl",
            ),
          ),
        ],
      ),
    );
  }
}
