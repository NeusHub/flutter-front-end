import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:neushub/bloc/sign_bloc.dart';
import 'package:neushub/pages/app_bar.dart';

import '../main.dart';
import '../widgets.dart';
import '../theme.dart';

class NeusHubFindPage extends StatelessWidget {
  const NeusHubFindPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Find Newsletter'),
                  ],
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 44,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Search and find the perfect match Newsletter that fit your needs',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder(
            future: nodeAPI.posts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: (snapshot.data[0] as Map).keys.map(
                      (category) {
                        return NeusHubFindCategory(
                          size: 300,
                          name: category as String,
                          posts: snapshot.data[0] as Map,
                          direction: (MediaQuery.sizeOf(context).width <
                                  mobileSize.width)
                              ? Axis.vertical
                              : Axis.horizontal,
                        );
                      },
                    ).toList(),
                  ),
                );
              } else {
                return Text('');
              }
            },
          ),
        ],
      ),
    );
  }
}

class NeusHubFindCategory extends StatelessWidget {
  const NeusHubFindCategory({
    super.key,
    required this.size,
    required this.name,
    required this.posts,
    this.direction = Axis.horizontal,
  });

  final double size;
  final String name;
  final Map posts;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            name.toString()[0].toUpperCase() + name.toString().substring(1),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 30,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 20),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: size * ((direction == Axis.vertical) ? 1.75 : 1),
            maxWidth: MediaQuery.sizeOf(context).width,
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: ((posts)[name] as List).length + 2,
            separatorBuilder: (context, index) => (index == 0 || index == ((posts)[name] as List).length)
                ? SizedBox()
                : SizedBox(
                    width: 20,
                  ),
            itemBuilder: (context, index) {
              if (index == 0 || index == ((posts)[name] as List).length + 1) {
                return SizedBox(width: 20);
              } else {
                return NeusHubFindCard(
                  post: ((posts)[name] as List)[index - 1],
                  size: size - 40,
                  direction: direction,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class NeusHubFindCard extends StatefulWidget {
  const NeusHubFindCard({
    super.key,
    required this.post,
    required this.size,
    this.direction = Axis.horizontal,
  });

  final dynamic post;
  final double size;
  final Axis direction;

  @override
  State<NeusHubFindCard> createState() => _NeusHubFindCardState();
}

class _NeusHubFindCardState extends State<NeusHubFindCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size * ((widget.direction == Axis.horizontal) ? 2.2 : 1),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: NeusHubListView(
        direction: widget.direction,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(20),
            height: widget.size - 40,
            width: widget.size - 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                height: widget.size - 40,
                width: widget.size - 40,
                fit: BoxFit.cover,
                nodeAPI.image((widget.post['image_path'] as String)
                    .replaceFirst('post_images/', '')),
                scale: 0.5,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: (widget.direction == Axis.horizontal)
                  ? EdgeInsets.only(top: 25, right: 50, bottom: 20)
                  : EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post['title'],
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      FutureBuilder(
                          future: nodeAPI.getData(widget.post['user_email']),
                          builder: (context, snapshot) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: (snapshot.connectionState ==
                                      ConnectionState.done)
                                  ? [
                                      Text(
                                        (snapshot.data[0]['full_name'][0]
                                                    as String)
                                                .toUpperCase() +
                                            (snapshot.data[0]['full_name']
                                                    as String)
                                                .split(' ')[0]
                                                .substring(1),
                                      ),
                                      Text(
                                        '${snapshot.data[0]['total_subscribers']} subscribers',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ),
                                    ]
                                  : [],
                            );
                          }),
                      SizedBox(height: 10),
                      Text(
                        widget.post['description'] ?? '',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder(
                          future: nodeAPI.subscribed(widget.post['user_email']),
                          builder: (context, snapshot) {
                            return NeusHubTextIconButton.filled(
                              icon: Icons.abc,
                              label: (snapshot.connectionState ==
                                      ConnectionState.done)
                                  ? snapshot.data[0][0]
                                          .toString()
                                          .toUpperCase() +
                                      snapshot.data[0].toString().substring(1)
                                  : '',
                              only: NeusHubTextIconOnly.textOnly,
                              activated: true,
                              onPressed: () async {
                                if ((await nodeAPI.token()).toString() !=
                                    '[false]') {
                                  if ((await nodeAPI.subscribe(
                                              widget.post['user_email']))
                                          .toString() ==
                                      '[subscribe]') {
                                    setState(() {});
                                  }
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .surfaceContainer,
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          width: 300,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Neus',
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary,
                                                      ),
                                                    ),
                                                    TextSpan(text: 'Hub'),
                                                  ],
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                'Hundred of newsletter in one place',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              NeusHubSignButton(
                                                label: 'Join Us Today',
                                                fromFinder: true,
                                                activated: true,
                                                signTypeDialog:
                                                    NeusHubSignType.signUp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            );
                          }),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Publish\n',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                              ),
                              TextSpan(
                                text: 'Every Fri, Sat',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NeusHubListView extends StatelessWidget {
  const NeusHubListView({
    super.key,
    required this.direction,
    required this.children,
  });

  final Axis direction;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return switch (direction) {
      Axis.horizontal => Row(children: children),
      Axis.vertical => Column(children: children),
    };
  }
}
