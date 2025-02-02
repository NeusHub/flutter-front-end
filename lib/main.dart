import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:neushub/pages/app_bar.dart';
import 'package:neushub/pages/home.dart';
import 'package:neushub/pages/find_newsletter.dart';
import 'package:neushub/pages/about_us.dart';
import 'package:neushub/pages/contact_us.dart';
import 'package:neushub/pages/footer.dart';

import './theme.dart';
part './widgets.dart';

Map<String, Widget> pages = {
  'Home': NeusHubHomePage(
    key: GlobalKey(debugLabel: 'Home'),
  ),
  'Find Newsletter': NeusHubFindPage(
    key: GlobalKey(debugLabel: 'Find Newsletter'),
  ),
  'About Us': NeusHubAboutPage(
    key: GlobalKey(debugLabel: 'About Us'),
  ),
  'Contact Us': NeusHubContactPage(
    key: GlobalKey(debugLabel: 'Contact Us'),
  ),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences user = await SharedPreferences.getInstance();

  runApp(const NeusHubApp());
}

class NeusHubApp extends StatefulWidget {
  const NeusHubApp({
    super.key,
    this.scrollController,
  });

  final ScrollController? scrollController;

  @override
  State<NeusHubApp> createState() => _NeusHubAppState();
}

class _NeusHubAppState extends State<NeusHubApp> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'NeusHub',
      home: SafeArea(
        child: Scaffold(
          appBar: NeusHubAppBar(
            preferredSize: NeusHubAppSize(context).size(),
            scrollController: _scrollController,
            child: NeusHubAppBarMenu(
              context: context,
              tabs: pages.keys.skip(1),
              menuFlag: (MediaQuery.sizeOf(context).width < mobileSize.width)
                  ? true
                  : false,
              scrollController: _scrollController,
            ).list(),
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: pages.values.toList(),
                  ),
                ),
                NeusHubFooter(tabs: pages.keys.skip(1)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
