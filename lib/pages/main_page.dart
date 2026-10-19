import 'package:flutter/material.dart';
import 'package:simmerwave/pages/search_radio.dart';
import 'package:simmerwave/widgets/header.dart';
import 'package:simmerwave/widgets/search_button.dart';
import 'package:simmerwave/widgets/tab_menu.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPagestate();
}

class _RadioPagestate extends State<RadioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Remove the 'appBar' property completely
      backgroundColor: Colors.white, // Good to set a background color
      body: SafeArea(
        // 2. SafeArea ensures you don't go under the notch
        child: Padding(
          padding: const EdgeInsets.all(16.0), // 3. The root padding you wanted
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerMain(),
              const SizedBox(height: 16), // Space between header and tabs
              CoolSearchBar(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RadioLists()),
                  );
                },
              ),
              // 5. Your Tab Menu (Wrapped in Expanded)
              // Expanded is required so the TabBarView fills the rest of the screen
              const Expanded(child: TabMenuWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
