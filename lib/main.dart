import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:neushub/pages/app_bar.dart';
import 'package:neushub/pages/offline.dart';
import 'package:neushub/pages/home.dart';
import 'package:neushub/pages/find_newsletter.dart';
import 'package:neushub/pages/about_us.dart';
import 'package:neushub/pages/contact_us.dart';
import 'package:neushub/pages/footer.dart';

import './theme.dart';
import './nodejsapi.dart';

final Map<String, Widget> pages = {
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

final GlobalKey<_NeusHubAppState> rootKey =
    GlobalKey<_NeusHubAppState>(debugLabel: 'root');

NeusHubNodeAPI nodeAPI = NeusHubNodeAPI(
  '71a8-156-195-149-243.ngrok-free.app',
  secured: true,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences user = await SharedPreferences.getInstance();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: NeusHubColors.white,
      systemNavigationBarColor: NeusHubColors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  nodeAPI = NeusHubNodeAPI(
    nodeAPI.host,
    port: nodeAPI.port,
    secured: nodeAPI.secured,
    preferences: user,
  );

  runApp(NeusHubApp(nodeAPI: nodeAPI));
}

class NeusHubApp extends StatefulWidget {
  const NeusHubApp({
    super.key,
    required this.nodeAPI,
    this.scrollController,
  });

  final NeusHubNodeAPI nodeAPI;
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

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey appBarKey = GlobalKey(debugLabel: 'app bar');

    return MaterialApp(
      theme: theme,
      title: 'NeusHub',
      home: SafeArea(
        child: Scaffold(
          appBar: NeusHubAppBar(
            key: appBarKey,
            preferredSize: NeusHubAppSize(context).size(),
            scrollController: _scrollController,
            child: NeusHubAppBarMenu(
              appBarKey: appBarKey,
              context: context,
              tabs: pages.keys.skip(1),
              menuFlag: (MediaQuery.sizeOf(context).width < mobileSize.width)
                  ? true
                  : false,
              scrollController: _scrollController,
            ).list(),
          ),
          body: FutureBuilder<int>(
            future: widget.nodeAPI.connection(),
            builder: (context, snapshot) {
              if (!snapshot.hasError) {
                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: nodeAPI.token(),
                          builder: (context, snapshot) {
                            if (snapshot.data != null &&
                                snapshot.data.toString() != '[false]') {
                              return Column(
                                children: pages.values.toList().sublist(1),
                              );
                            } else {
                              return Column(
                                children: pages.values.toList(),
                              );
                            }
                          }),
                      NeusHubFooter(tabs: pages.keys.skip(1)),
                    ],
                  ),
                );
              } else {
                return NeusHubOfflinePage(
                  onPressed: () {
                    setState(() {});
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
