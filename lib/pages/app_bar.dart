import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme.dart';
import '../inheritance.dart';
import '../main.dart';

class NeusHubAppBarMenu {
  final BuildContext context;
  final Iterable<String> tabs;
  final bool menuFlag;
  final ScrollController? scrollController;

  const NeusHubAppBarMenu({
    required this.context,
    required this.tabs,
    this.scrollController,
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
                    icon: Icons.menu,
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
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Theme.of(context).appBarTheme.shape
                                      as Border,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    NeusHubAppBarTitle(
                                      menuFlag: true,
                                      scrollController: scrollController,
                                    ),
                                    TextIconButtonJO(
                                      icon: Icons.close,
                                      label: '',
                                      only: TextIconButtonOnlyJO.iconOnly,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: tabs
                                      .map<Padding>(
                                        (tab) => Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: NeusHubAppBarTab(
                                            tab,
                                            menuFlag: menuFlag,
                                            scrollController: scrollController,
                                          ),
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
              ...tabs.map<NeusHubAppBarTab>((tab) => NeusHubAppBarTab(
                    tab,
                    scrollController: scrollController,
                  )),
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
    this.scrollController,
  });

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Theme.of(context).appBarTheme.shape as Border,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal:
            (MediaQuery.sizeOf(context).width < mobileSize.width) ? 15 : 50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NeusHubAppBarTitle(scrollController: scrollController),
          Expanded(child: child),
          TextIconButtonJO.filled(
            icon: Icons.abc,
            label: 'Grow your audience today',
            only: TextIconButtonOnlyJO.textOnly,
          ),
        ],
      ),
    );
  }
}

class NeusHubAppBarTitle extends StatelessWidget {
  const NeusHubAppBarTitle({
    super.key,
    this.menuFlag = false,
    this.scrollController,
  });

  final bool menuFlag;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NeusHubHover<Color>>(
      create: (context) => NeusHubHover<Color>(
        theme.colorScheme.primary,
        theme.colorScheme.onPrimary,
      ),
      builder: (context, child) {
        return GestureDetector(
          child: ElevatedButton(
            onPressed: () {
              scrollController?.animateTo(
                0,
                duration: Durations.long2,
                curve: Curves.easeInOut,
              );
              if (menuFlag) {
                Navigator.of(context).pop();
              }
            },
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
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class NeusHubAppBarTab extends StatelessWidget {
  const NeusHubAppBarTab(
    this.tab, {
    super.key,
    this.scrollController,
    this.menuFlag = false,
  });

  final String tab;
  final ScrollController? scrollController;
  final bool menuFlag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (menuFlag) ? 0 : 10),
      child: TextIconButtonJO(
        icon: Icons.abc,
        label: tab,
        only: TextIconButtonOnlyJO.textOnly,
        onPressed: () {
          if (menuFlag) {
            Navigator.of(context).pop();
          }
          scrollController?.animateTo(
            ((pages[tab]?.key as GlobalKey).currentContext?.findRenderObject()
                        as RenderBox)
                    .localToGlobal(Offset.zero)
                    .dy +
                scrollController!.offset -
                60,
            duration: Durations.long2,
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
