import 'package:flutter/material.dart';

import 'package:neushub/pages/app_bar.dart';

import './theme.dart';
part './widgets.dart';

const Map<String, Widget> pages = {
  'home': Text('data'),
  'finds newsletter': Text('data'),
  'about us': Text('data'),
};

void main() {
  runApp(const NeusHubApp());
}

class NeusHubApp extends StatelessWidget {
  const NeusHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'NeusHub',
      home: Scaffold(
        appBar: NeusHubAppBar(
          preferredSize: NeusHubAppSize(context).size(),
          child: NeusHubAppBarMenu(
            context: context,
            tabs: pages.keys,
            menuFlag: (MediaQuery.sizeOf(context).width < mobileSize.width)
                ? true
                : false,
          ).list(),
        ),
        body: Text('data'),
      ),
    );
  }
}
