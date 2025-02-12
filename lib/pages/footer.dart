import 'package:flutter/material.dart';

import '../main.dart';
import '../theme.dart';
import '../icons.dart';
import '../widgets.dart';

class NeusHubFooter extends StatelessWidget {
  const NeusHubFooter({
    super.key,
    required this.tabs,
    this.appBarKey,
    this.scrollController,
  });

  final Iterable<String> tabs;
  final GlobalKey? appBarKey;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    bool mobileFlag =
        (MediaQuery.sizeOf(context).width < mobileSize.width + 130)
            ? true
            : false;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: NeusHubColors.greyDark,
      ),
      margin: EdgeInsets.only(top: 50),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      alignment: Alignment.center,
      child: NeusHubFooterList(
        mobileFlag: mobileFlag,
        children: [
          NeusHubFooterColumn(
            mobileFlag: mobileFlag,
            children: [
              NeusHubTextIconButton(
                icon: Icons.abc,
                label: 'NeusHub',
                only: NeusHubTextIconOnly.textOnly,
                textSize: 20,
                textWeight: FontWeight.w700,
                color: Theme.of(context).scaffoldBackgroundColor,
                onPressed: () {
                  scrollController?.animateTo(
                    0,
                    duration: Durations.long2,
                    curve: Curves.easeInOut,
                  );
                },
              ),
              SizedBox(height: 5),
              Text(
                'Platform for newsletter fans and owners.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          NeusHubFooterColumn(
            children: tabs
                .map(
                  (tab) => Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 5),
                    child: NeusHubTextIconButton(
                      icon: Icons.abc,
                      label: tab,
                      only: NeusHubTextIconOnly.textOnly,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      textDecoration: TextDecoration.underline,
                      onPressed: () {
                        double? appBarHeight =
                            appBarKey?.currentContext?.size!.height;
                        scrollController?.animateTo(
                          ((pages[tab]?.key as GlobalKey)
                                      .currentContext
                                      ?.findRenderObject() as RenderBox)
                                  .localToGlobal(Offset.zero)
                                  .dy +
                              scrollController!.offset -
                              appBarHeight! -
                              17,
                          duration: Durations.long2,
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                )
                .toList(),
          ),
          NeusHubFooterColumn(
            mobileFlag: mobileFlag,
            children: [
              Text(
                'Email Us:',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 5),
              NeusHubTextIconButton(
                icon: Icons.abc,
                label: 'hallo@naushub.com',
                only: NeusHubTextIconOnly.textOnly,
                color: Theme.of(context).scaffoldBackgroundColor,
                textDecoration: TextDecoration.underline,
              ),
            ],
          ),
          NeusHubFooterColumn(
            mobileFlag: mobileFlag,
            children: [
              Text(
                'Follow Us:',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NeusHubTextIconButton(
                    icon: NeusHubIcons.facebook,
                    label: '',
                    only: NeusHubTextIconOnly.iconOnly,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  SizedBox(width: 10),
                  NeusHubTextIconButton(
                    icon: NeusHubIcons.x,
                    label: '',
                    only: NeusHubTextIconOnly.iconOnly,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  SizedBox(width: 10),
                  NeusHubTextIconButton(
                    icon: NeusHubIcons.linkedin,
                    label: '',
                    only: NeusHubTextIconOnly.iconOnly,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NeusHubFooterList extends StatelessWidget {
  const NeusHubFooterList({
    super.key,
    required this.children,
    this.mobileFlag = false,
  });

  final List<NeusHubFooterColumn> children;
  final bool mobileFlag;

  @override
  Widget build(BuildContext context) {
    return (mobileFlag)
        ? ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 500),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => children[index],
              separatorBuilder: (context, index) => Divider(
                height: 20,
                color: NeusHubColors.transparent,
              ),
              itemCount: children.length,
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          );
  }
}

class NeusHubFooterColumn extends StatelessWidget {
  const NeusHubFooterColumn({
    super.key,
    required this.children,
    this.mobileFlag = false,
  });

  final List<Widget> children;
  final bool mobileFlag;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          (mobileFlag) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: children,
    );
  }
}
