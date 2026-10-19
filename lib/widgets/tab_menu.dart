import 'package:flutter/material.dart';

class TabMenuWidget extends StatelessWidget {
  const TabMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          // 1. The TabBar is now just a widget in a Column
          const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.red,
            indicatorWeight: 3.0,
            dividerColor: Colors.transparent,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Radios'),
              Tab(text: 'Podcasts'),
              Tab(text: 'FM'),
            ],
          ),
          
          // 2. Expanded is REQUIRED so the view fills the rest of the screen
          const Expanded(
            child: TabBarView(
              children: [
                Center(child: Text('Overview Content')),
                Center(child: Text('Songs Content')),
                Center(child: Text('Albums Content')),
                Center(child: Text('Coming soon')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}