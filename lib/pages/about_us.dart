import 'package:flutter/material.dart';

class NeusHubAboutPage extends StatelessWidget {
  const NeusHubAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'About '),
              TextSpan(
                text: 'Neus',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              TextSpan(text: 'Hub'),
            ],
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 44,
            ),
          ),
        ),
        SizedBox(height: 15),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width - 40,
            maxHeight: 1500,
          ),
          child: GridView.extent(
            maxCrossAxisExtent: 500,
            children: [
              SizedBox.shrink(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Image.asset('assets/images/about_finder.png'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
