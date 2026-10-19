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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // required height
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30), // Pill shape
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              onChanged: _onQueryChanged,
              controller: _controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search stations, songs, artists...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),

                // Show the clear button only if there is text
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[600]),
                        onPressed: () {
                          _controller.clear();
                          // You can trigger a search reset here if needed
                        },
                      )
                    : null,

                // Remove the default underline
                border: InputBorder.none,

                // Adjust padding so the text is vertically centered
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onSubmitted: (value) {
                // Handle the search action when the user presses "Enter" or "Search"
                debugPrint('Searching for: $value');
              },
            ),
          ),
        ),
      ),
      body: Expanded(child: _buildResults()),
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
