import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simmerwave/models/radio_station.dart';
import 'package:simmerwave/service/radio_api.dart';
import 'package:simmerwave/widgets/station_card.dart';

class RadioLists extends StatefulWidget {
  const RadioLists({super.key});

  @override
  State<RadioLists> createState() => _RadioListsState();
}

class _RadioListsState extends State<RadioLists> {
  final _controller = TextEditingController();
  Timer? _debounce;
  Future<List<RadioStation>>? _resultsFuture;
  @override
  void dispose() {
    _debounce?.cancel(); // stop the timer
    _controller.dispose(); // release the text controller
    super.dispose(); // ← always last
  }
  void _onQueryChanged(String text) {
    _debounce?.cancel();

    if (text.trim().isEmpty) {
      setState(() => _resultsFuture = null);
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _resultsFuture = RadioApi.searchRadio(text.trim());
      });
    });
  }

    @override
  Widget build(BuildContext context) {
    return 
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              onChanged: _onQueryChanged,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search stations...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _controller.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          _onQueryChanged('');
                        },
                      ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(child: _buildResults()),
        ],
      );
  }

  Widget _buildResults() {
    if (_resultsFuture == null) {
      return const Center(child: Text('Type to search'));
    }
    return FutureBuilder<List<RadioStation>>(
      future: _resultsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Search failed:\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        final stations = snapshot.data!;
        if (stations.isEmpty) {
          return const Center(child: Text('No stations found'));
        }
        return ListView.builder(
          itemCount: stations.length,
          itemBuilder: (context, i) => StationCard(
            key: ValueKey(stations[i].id),
            station: stations[i],
            onTap: () {
              // TODO: open player / bottom sheet
              debugPrint('Selected: ${stations[i].name}');
            },
          ),
        );
      },
    );
  }
}
