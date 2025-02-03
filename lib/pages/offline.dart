import 'package:flutter/material.dart';
import 'package:neushub/theme.dart';

import '../icons.dart';
import '../main.dart';

class NeusHubOfflinePage extends StatelessWidget {
  const NeusHubOfflinePage({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/offline_background.png',
            width: 300,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(NeusHubIcons.offline, size: 35),
              SizedBox(height: 10),
              Text('You\'re offline'),
              SizedBox(height: 10),
              Text(
                'Please connect to the internet and try again.',
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 10),
              TextIconButtonJO.filled(
                icon: Icons.replay,
                label: 'Retry',
                padding: EdgeInsets.all(5),
                radius: BorderRadius.all(Radius.circular(50)),
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: NeusHubColors.blackLight,
                onPressed: onPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
