import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

import 'package:neushub/pages/app_bar.dart';
import 'package:neushub/pages/offline.dart';
import 'package:neushub/pages/home.dart';
import 'package:neushub/pages/find_newsletter.dart';
import 'package:neushub/pages/about_us.dart';
// import 'package:neushub/pages/contact_us.dart';
import 'package:neushub/pages/footer.dart';
import 'package:neushub/pages/sign.dart';

import './theme.dart';
import './nodejsapi.dart';
import './bloc/sign_bloc.dart';

final GlobalKey<_NeusHubAppHomeState> rootKey =
    GlobalKey<_NeusHubAppHomeState>(debugLabel: 'root');
final GlobalKey appBarKey = GlobalKey(debugLabel: 'app bar');
final ScrollController scrollController = ScrollController();

final Map<String, Widget> pages = {
  'Home': NeusHubHomePage(
    key: GlobalKey(debugLabel: 'Home'),
    appBarKey: appBarKey,
    scrollController: scrollController,
  ),
  'Find Newsletter': NeusHubFindPage(
    key: GlobalKey(debugLabel: 'Find Newsletter'),
  ),
  'About Us': NeusHubAboutPage(
    key: GlobalKey(debugLabel: 'About Us'),
  ),
  // 'Contact Us': NeusHubContactPage(
  //   key: GlobalKey(debugLabel: 'Contact Us'),
  // ),
};

NeusHubNodeAPI nodeAPI = NeusHubNodeAPI(
  'nodejs-back-end-production.up.railway.app',
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

  runApp(NeusHubApp(
    nodeAPI: nodeAPI,
    scrollController: scrollController,
  ));
}

class NeusHubApp extends StatelessWidget {
  const NeusHubApp({
    super.key,
    required this.nodeAPI,
    this.scrollController,
  });

  final NeusHubNodeAPI nodeAPI;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: theme,
      title: 'NeusHub',
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => NeusHubAppHome(
              key: rootKey,
              nodeAPI: nodeAPI,
              scrollController: scrollController,
            ),
          ),
          GoRoute(
            path: '/password:id',
            builder: (context, state) => NeusHubAppPasswordReset(
              id: state.pathParameters['id'] ?? '',
            ),
          ),
        ],
        errorBuilder: (context, state) => NeusHubAppError404(),
      ),
    );
  }
}

class NeusHubAppHome extends StatefulWidget {
  const NeusHubAppHome({
    super.key,
    required this.nodeAPI,
    this.scrollController,
  });

  final NeusHubNodeAPI nodeAPI;
  final ScrollController? scrollController;

  @override
  State<NeusHubAppHome> createState() => _NeusHubAppHomeState();
}

class _NeusHubAppHomeState extends State<NeusHubAppHome> {
  late ScrollController? _scrollController;

  @override
  void initState() {
    _scrollController = widget.scrollController;
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    NeusHubFooter(
                      tabs: pages.keys.skip(1),
                      appBarKey: appBarKey,
                      scrollController: scrollController,
                    ),
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
    );
  }
}

class NeusHubAppPasswordReset extends StatelessWidget {
  const NeusHubAppPasswordReset({
    super.key,
    this.id = '',
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return NeusHubSignDialog(signTypeDialog: NeusHubSignType.resetPassword);
  }
}

class NeusHubAppError404 extends StatelessWidget {
  const NeusHubAppError404({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NeusHubSignDialog(signTypeDialog: NeusHubSignType.resetPassword),
    );
  }
}
