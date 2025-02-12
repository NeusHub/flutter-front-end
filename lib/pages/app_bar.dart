import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:neushub/pages/sign.dart';
import 'package:neushub/bloc/sign_bloc.dart';

import '../theme.dart';
import '../inheritance.dart';
import '../widgets.dart';
import '../main.dart';

class NeusHubAppBarMenu {
  final GlobalKey? appBarKey;
  final BuildContext context;
  final Iterable<String> tabs;
  final bool menuFlag;
  final ScrollController? scrollController;

  const NeusHubAppBarMenu({
    this.appBarKey,
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
                  return NeusHubTextIconButton(
                    icon: Icons.menu,
                    label: '',
                    only: NeusHubTextIconOnly.iconOnly,
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
                                    NeusHubTextIconButton(
                                      icon: Icons.close,
                                      label: '',
                                      only: NeusHubTextIconOnly.iconOnly,
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
                                            appBarKey: appBarKey,
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
                    appBarKey: appBarKey,
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
          NeusHubSignButton(label: 'Grow your audience today'),
        ],
      ),
    );
  }
}

class NeusHubSignButton extends StatelessWidget {
  const NeusHubSignButton({
    super.key,
    this.label = '',
    this.expanded = false,
    this.visible = true,
    this.fromFinder = false,
    this.activated = false,
    this.signTypeDialog = NeusHubSignType.signIn,
  });

  final String label;
  final bool expanded, visible, fromFinder, activated;
  final NeusHubSignType signTypeDialog;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: nodeAPI.token(),
      builder: (context, snapshot) {
        if (snapshot.data.toString() == '[false]' || snapshot.data == null) {
          return NeusHubTextIconButton.filled(
            icon: Icons.abc,
            label: label,
            only: NeusHubTextIconOnly.textOnly,
            expanded: expanded,
            activated: activated,
            onPressed: () async {
              if (await nodeAPI.connection() == 200) {
                if (fromFinder == true) {
                  Navigator.of(context).pop();
                }
                showDialog(
                  context: context,
                  builder: (context) {
                    return NeusHubSignDialog(
                      signTypeDialog: signTypeDialog,
                    );
                  },
                );
              }
            },
          );
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            return Visibility(
              visible: visible,
              child: TextButton(
                onPressed: () {},
                child: PopupMenuButton(
                  tooltip: 'log out',
                  offset: Offset(0, 13),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      padding: EdgeInsets.zero,
                      height: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: NeusHubTextIconButton(
                            icon: Icons.abc,
                            label: 'Log out',
                            only: NeusHubTextIconOnly.textOnly,
                            onPressed: () async {
                              await nodeAPI.preferences?.clear();
                              rootKey.currentState?.refresh();
                              // Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          snapshot.data![1]['full_name']
                              .toString()[0]
                              .toUpperCase(),
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        snapshot.data![1]['full_name']
                            .toString()
                            .split(' ')
                            .map(
                              (e) => e[0].toUpperCase() + e.substring(1),
                            )
                            .first,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        }
      },
    );
  }
}

class NeusHubAppBarTitle extends StatelessWidget {
  const NeusHubAppBarTitle({
    super.key,
    this.menuFlag = false,
    this.scrollController,
    this.onPressed,
  });

  final bool menuFlag;
  final ScrollController? scrollController;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NeusHubHover<Color>>(
      create: (context) => NeusHubHover<Color>(
        theme.colorScheme.primary,
        theme.colorScheme.onPrimary,
      ),
      builder: (context, child) {
        return GestureDetector(
          onTapDown: (details) {
            Provider.of<NeusHubHover<Color>>(
              context,
              listen: false,
            ).hover(true);
          },
          onTapCancel: () {
            Provider.of<NeusHubHover<Color>>(
              context,
              listen: false,
            ).hover(false);
          },
          child: TextButton(
            onPressed: () {
              try {
                scrollController?.animateTo(
                  0,
                  duration: Durations.long2,
                  curve: Curves.easeInOut,
                );
                if (menuFlag) {
                  Navigator.of(context).pop();
                }
              } catch (e) {
                return;
              }
              if (onPressed != null) {
                onPressed!();
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
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: RichText(
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
    this.appBarKey,
    this.menuFlag = false,
  });

  final String tab;
  final ScrollController? scrollController;
  final GlobalKey? appBarKey;
  final bool menuFlag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (menuFlag) ? 0 : 10),
      child: NeusHubTextIconButton(
        icon: Icons.abc,
        label: tab,
        only: NeusHubTextIconOnly.textOnly,
        onPressed: () {
          try {
            double? appBarHeight = appBarKey?.currentContext?.size!.height;
            if (menuFlag) {
              Navigator.of(context).pop();
            }
            scrollController?.animateTo(
              ((pages[tab]?.key as GlobalKey).currentContext?.findRenderObject()
                          as RenderBox)
                      .localToGlobal(Offset.zero)
                      .dy +
                  scrollController!.offset -
                  appBarHeight! -
                  17,
              duration: Durations.long2,
              curve: Curves.easeInOut,
            );
          } catch (e) {}
        },
      ),
    );
  }
}
