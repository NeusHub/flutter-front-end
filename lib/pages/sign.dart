import 'package:flutter/material.dart';

import 'package:neushub/pages/app_bar.dart';

import '../theme.dart';

class NeusHubSignDialog extends Dialog {
  const NeusHubSignDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: 12.5,
              horizontal: (MediaQuery.sizeOf(context).width < mobileSize.width)
                  ? 15
                  : 50,
            ),
            decoration: BoxDecoration(
              border: Theme.of(context).appBarTheme.shape as Border,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NeusHubAppBarTitle(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
