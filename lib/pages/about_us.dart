import 'package:flutter/material.dart';

class NeusHubAboutPage extends StatelessWidget {
  const NeusHubAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: RichText(
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
          ),
          SizedBox(height: 15),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width,
              maxHeight: 1500,
            ),
            child: Wrap(
              spacing: 15,
              runSpacing: 15,
              children: [
                NeusHubAboutChildren(
                  title: 'Newsletter is like magic',
                  image: Image.asset('assets/images/about_magic.png'),
                  description:
                      'It takes you to what is beyond your knowledge with few sentence that have a lot of power to change your outer world, We founded NuesHub to teach you magic.',
                ),
                NeusHubAboutChildren(
                  title: 'A bridge for Newsletter owners and fans',
                  image: Image.asset('assets/images/about_owner.png'),
                  description:
                      'NuesHub is a platform for newsletter fans and owners, It connect great newsletters that has valuable content to it\'s targeted audience.',
                ),
                NeusHubAboutChildren(
                  title:
                      'Finding a newsletter is like finding magic crystal ball',
                  image: Image.asset('assets/images/about_finder.png'),
                  description:
                      'It\'s hard to find the right newsletter with useful content to your needs it sounds like looking for a mgic crystal ball that\'s why NuesHub got your back.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NeusHubAboutChildren extends StatelessWidget {
  const NeusHubAboutChildren({
    super.key,
    required this.title,
    required this.image,
    this.description = '',
  });

  final String title, description;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary,
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 10),
                width: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: image,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            description,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
