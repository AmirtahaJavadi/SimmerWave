import 'package:flutter/material.dart';

class headerMain extends StatefulWidget {
  const headerMain({super.key});

  @override
  State<headerMain> createState() => _headerMainState();
}

class _headerMainState extends State<headerMain> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "SimmerWave",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_active_outlined),
              onPressed: () {
                // Open search
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings_rounded),
              onPressed: () {
                // Open search
              },
            ),
          ],
        ),
      ],
    );
  }
}
