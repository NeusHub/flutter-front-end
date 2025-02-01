import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme.dart';
import '../inheritance.dart';
import '../main.dart';

class NeusHubAppBarMenu {
  final BuildContext context;
  final Iterable<String> tabs;
  final bool menuFlag;

  const NeusHubAppBarMenu({
    required this.context,
    required this.tabs,
    this.menuFlag = false,
  });

  Widget list() {
    return (menuFlag)
        ? ChangeNotifierProvider<NeusHubHover<bool>>(
            create: (context) => NeusHubHover<bool>(false, true),
            builder: (context, child) {
              return Consumer<NeusHubHover<bool>>(
                builder: (context, value, child) {
                  return TextIconButtonJO(
                    icon: (value.flag) ? Icons.close : Icons.menu,
                    label: '',
                    only: TextIconButtonOnlyJO.iconOnly,
                    activated: value.flag,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: TextIconButtonJO(
                                  icon: Icons.close,
                                  label: '',
                                  only: TextIconButtonOnlyJO.iconOnly,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: tabs
                                      .map<TextIconButtonJO>(
                                        (e) => TextIconButtonJO(
                                          icon: Icons.abc,
                                          label: e,
                                          only: TextIconButtonOnlyJO.textOnly,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ...tabs.map((tab) => NeusHubAppBarTab(tab)),
              SizedBox(width: 10),
            ],
          );
  }
}

class NeusHubAppBar extends PreferredSize {
  const NeusHubAppBar({
    super.key,
    required super.preferredSize,
    required super.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal:
            (MediaQuery.sizeOf(context).width < mobileSize.width) ? 25 : 50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ChangeNotifierProvider<NeusHubHover<Color>>(
            create: (context) => NeusHubHover<Color>(
              theme.colorScheme.primary,
              theme.colorScheme.onPrimary,
            ),
            builder: (context, child) {
              return GestureDetector(
                child: ElevatedButton(
                  onPressed: () {},
                  onHover: (value) {
                    Provider.of<NeusHubHover<Color>>(
                      context,
                      listen: false,
                    ).hover(value);
                  },
                  child: Consumer<NeusHubHover<Color>>(
                    builder: (context, value, child) {
                      return RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Neus',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            TextSpan(text: 'Hub'),
                          ],
                          style: TextStyle(
                            color: value.flag,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          Expanded(child: child),
          TextIconButtonJO.filled(
            icon: Icons.abc,
            label: 'Sign in',
            only: TextIconButtonOnlyJO.textOnly,
          ),
        ],
      ),
    );
  }
}

class NeusHubAppBarTab extends StatelessWidget {
  const NeusHubAppBarTab(
    this.tab, {
    super.key,
  });

  final String tab;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextIconButtonJO(
        icon: Icons.abc,
        label: tab,
        only: TextIconButtonOnlyJO.textOnly,
      ),
    );
  }
}
