import 'package:flutter/material.dart';

import 'package:neushub/pages/app_bar.dart';

import '../main.dart';
import '../theme.dart';
import '../widgets.dart';

class NeusHubHomePage extends StatelessWidget {
  const NeusHubHomePage({
    super.key,
    this.scrollController,
    this.appBarKey,
  });

  final ScrollController? scrollController;
  final GlobalKey? appBarKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height - 52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            width: (MediaQuery.sizeOf(context).width < mobileSize.width)
                ? MediaQuery.sizeOf(context).width - 50
                : (MediaQuery.sizeOf(context).width - 10) / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hundred of newsletter in one place',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(text: '\n'),
                        TextSpan(
                          text:
                              'Looking for life changer newsletter to Subscribe?',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(text: '\n\n'),
                        TextSpan(
                          text:
                              'Find newsletter with rich content for career advices, Finance, Crypto, Tech, Programming, Designing and even much more.',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(text: '\n\n'),
                      ],
                    ),
                  ),
                ),
                (MediaQuery.sizeOf(context).width < mobileSize.width)
                    ? Column(
                        children: [
                          NeusHubTextIconButton.filled(
                            icon: Icons.abc,
                            label: 'Find Newsletter',
                            only: NeusHubTextIconOnly.textOnly,
                            activated: true,
                            expanded: true,
                          ),
                          SizedBox(height: 20),
                          NeusHubSignButton(
                            label: 'Grow your audience today',
                            visible: false,
                            expanded: (MediaQuery.sizeOf(context).width <
                                mobileSize.width),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          NeusHubTextIconButton.filled(
                            icon: Icons.abc,
                            label: 'Find Newsletter',
                            only: NeusHubTextIconOnly.textOnly,
                            activated: true,
                            onPressed: () {
                              double? appBarHeight =
                                  appBarKey?.currentContext?.size!.height;
                              scrollController?.animateTo(
                                ((pages['Find Newsletter']?.key as GlobalKey)
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
                          SizedBox(width: 20),
                          NeusHubSignButton(
                            label: 'Grow your audience today',
                            visible: false,
                          ),
                        ],
                      ),
              ],
            ),
          ),
          Visibility(
            visible: (MediaQuery.sizeOf(context).width >= mobileSize.width),
            child: Stack(
              children: [
                CustomPaint(
                  painter: NeusHubHomeMainImage(),
                  size: Size(300, 300),
                ),
                Positioned(
                  bottom: 39,
                  left: 30,
                  child: Image.asset(
                    'assets/images/main.png',
                    width: 250,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NeusHubHomeMainImage extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint firstSquare = Paint()..color = NeusHubColors.purple;
    Paint secondSquare = Paint()
      ..style = PaintingStyle.stroke
      ..color = NeusHubColors.purple
      ..strokeWidth = 1;

    Path diamond = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, size.height / 2)
      ..close();

    canvas.drawRect(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2.7,
      ),
      firstSquare,
    );

    canvas.drawPath(
      diamond,
      secondSquare,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
