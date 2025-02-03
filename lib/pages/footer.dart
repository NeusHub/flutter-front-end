import 'package:flutter/material.dart';

import '../theme.dart';
import '../icons.dart';
import '../main.dart';

class NeusHubFooter extends StatelessWidget {
  const NeusHubFooter({
    super.key,
    required this.tabs,
  });

  final Iterable<String> tabs;

  @override
  Widget build(BuildContext context) {
    bool mobileFlag =
        (MediaQuery.sizeOf(context).width < mobileSize.width + 130)
            ? true
            : false;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      alignment: Alignment.center,
      child: NeusHubFooterList(
        mobileFlag: mobileFlag,
        children: [
          NeusHubFooterColumn(
            mobileFlag: mobileFlag,
            children: [
              TextIconButtonJO(
                icon: Icons.abc,
                label: 'NeusHub',
                only: TextIconButtonOnlyJO.textOnly,
                textSize: 20,
                textWeight: FontWeight.w700,
                color: Theme.of(context).scaffoldBackgroundColor,
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
                    child: TextIconButtonJO(
                      icon: Icons.abc,
                      label: tab,
                      only: TextIconButtonOnlyJO.textOnly,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      textDecoration: TextDecoration.underline,
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
              TextIconButtonJO(
                icon: Icons.abc,
                label: 'hallo@naushub.com',
                only: TextIconButtonOnlyJO.textOnly,
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
                  TextIconButtonJO(
                    icon: NeusHubIcons.facebook,
                    label: '',
                    only: TextIconButtonOnlyJO.iconOnly,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  SizedBox(width: 10),
                  TextIconButtonJO(
                    icon: NeusHubIcons.x,
                    label: '',
                    only: TextIconButtonOnlyJO.iconOnly,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  SizedBox(width: 10),
                  TextIconButtonJO(
                    icon: NeusHubIcons.linkedin,
                    label: '',
                    only: TextIconButtonOnlyJO.iconOnly,
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
            constraints: BoxConstraints(maxHeight: 280),
            child: ListView.separated(
              itemBuilder: (context, index) => children[index],
              separatorBuilder: (context, index) => Divider(height: 20),
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
