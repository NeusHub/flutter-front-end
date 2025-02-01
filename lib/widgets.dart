part of './main.dart';

class _TextIconButtonJO extends TextIconButtonJO {
  const _TextIconButtonJO({
    super.key,
    required super.icon,
    required super.label,
    required super.reversed,
    required super.only,
    super.onPressed,
    super.activated,
    super.iconSize,
    super.textSize,
    super.cursor,
    this.filled = false,
  });

  final bool filled;

  @override
  Widget build(BuildContext context) {
    TextIconButtonTypeJO type =
        (filled) ? TextIconButtonTypeJO.filled : TextIconButtonTypeJO.outlined;
    return TextIconButtonWidgetJO(
      reversed: reversed,
      icon: icon,
      label: label,
      type: type,
      only: only,
      activated: activated,
      onPressed: onPressed,
      iconSize: iconSize,
      textSize: textSize,
      cursor: cursor,
    );
  }
}

class TextIconButtonJO extends StatelessWidget {
  const TextIconButtonJO({
    super.key,
    required this.icon,
    required this.label,
    this.reversed = false,
    this.activated = false,
    this.onPressed,
    this.only = TextIconButtonOnlyJO.normal,
    this.iconSize,
    this.textSize,
    this.cursor,
  });

  final IconData icon;
  final String label;
  final bool reversed, activated;
  final void Function()? onPressed;
  final TextIconButtonOnlyJO only;
  final double? iconSize, textSize;
  final MouseCursor? cursor;

  @override
  Widget build(BuildContext context) {
    return TextIconButtonWidgetJO(
      reversed: reversed,
      icon: icon,
      label: label,
      only: only,
      activated: activated,
      onPressed: onPressed,
      iconSize: iconSize,
      textSize: textSize,
      cursor: cursor,
    );
  }

  factory TextIconButtonJO.outlined({
    Key? key,
    required IconData icon,
    required String label,
    TextIconButtonOnlyJO only = TextIconButtonOnlyJO.normal,
    bool reversed = false,
    bool activated = false,
    Function()? onPressed,
    double? iconSize,
    double? textSize,
    MouseCursor? cursor,
  }) {
    return _TextIconButtonJO(
      key: key,
      icon: icon,
      label: label,
      only: only,
      reversed: reversed,
      activated: activated,
      onPressed: onPressed,
      iconSize: iconSize,
      textSize: textSize,
      cursor: cursor,
    );
  }

  factory TextIconButtonJO.filled({
    Key? key,
    required IconData icon,
    required String label,
    TextIconButtonOnlyJO only = TextIconButtonOnlyJO.normal,
    bool reversed = false,
    bool activated = false,
    Function()? onPressed,
    double? iconSize,
    double? textSize,
    MouseCursor? cursor,
  }) {
    return _TextIconButtonJO(
        key: key,
        icon: icon,
        label: label,
        only: only,
        reversed: reversed,
        filled: true,
        activated: activated,
        onPressed: onPressed,
        iconSize: iconSize,
        textSize: textSize,
        cursor: cursor);
  }
}

enum TextIconButtonTypeJO { normal, filled, outlined }

enum TextIconButtonOnlyJO { normal, textOnly, iconOnly }

class TextIconButtonWidgetJO extends StatefulWidget {
  const TextIconButtonWidgetJO({
    super.key,
    required this.reversed,
    required this.icon,
    required this.label,
    required this.only,
    this.activated = false,
    this.type = TextIconButtonTypeJO.normal,
    this.onPressed,
    this.iconSize,
    this.textSize,
    this.cursor,
  });

  final bool reversed, activated;
  final IconData icon;
  final String label;
  final TextIconButtonTypeJO type;
  final void Function()? onPressed;
  final TextIconButtonOnlyJO only;
  final double? iconSize, textSize;
  final MouseCursor? cursor;

  @override
  State<TextIconButtonWidgetJO> createState() {
    return _TextIconButtonWidgetJOState();
  }
}

class _TextIconButtonWidgetJOState extends State<TextIconButtonWidgetJO> {
  late bool hovered;

  @override
  initState() {
    hovered = widget.activated;
    super.initState();
  }

  void onHover(bool value) {
    setState(() {
      hovered = (widget.activated) ? true : value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: (widget.type == TextIconButtonTypeJO.filled)
            ? (hovered)
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.primary
            : null,
        border: (widget.type == TextIconButtonTypeJO.outlined)
            ? Border.all(
                color: (hovered)
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.primary,
                width: 1,
              )
            : (widget.type == TextIconButtonTypeJO.filled)
                ? Border.all(
                    color: (hovered)
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.primary,
                    width: 1,
                  )
                : null,
      ),
      child: MouseRegion(
        cursor: widget.cursor ?? SystemMouseCursors.click,
        child: GestureDetector(
          onPanStart: (details) {
            onHover(true);
            widget.onPressed!();
          },
          onPanCancel: () {
            onHover(false);
          },
          child: TextButton(
            onPressed: () {
              widget.onPressed!();
            },
            onHover: onHover,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: widget.type == TextIconButtonTypeJO.normal ? 0 : 5,
                horizontal: widget.type == TextIconButtonTypeJO.normal ? 0 : 20,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: (widget.reversed) ? TextDirection.rtl : null,
                children: [
                  ...(widget.only == TextIconButtonOnlyJO.normal ||
                          widget.only == TextIconButtonOnlyJO.iconOnly)
                      ? [
                          Icon(
                            widget.icon,
                            color: (widget.type ==
                                    TextIconButtonTypeJO.outlined)
                                ? (hovered)
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.primary
                                : (widget.type == TextIconButtonTypeJO.filled)
                                    ? Theme.of(context).scaffoldBackgroundColor
                                    : (hovered)
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                        : Theme.of(context).colorScheme.primary,
                            size: widget.iconSize,
                          ),
                        ]
                      : [],
                  ...(widget.only == TextIconButtonOnlyJO.normal ||
                          widget.only == TextIconButtonOnlyJO.textOnly)
                      ? [
                          ...(widget.only == TextIconButtonOnlyJO.textOnly)
                              ? []
                              : [
                                  Text(
                                    ' ',
                                    style: TextStyle(fontSize: widget.textSize),
                                  ),
                                ],
                          Text(
                            widget.label,
                            style: TextStyle(
                              color: (widget.type ==
                                      TextIconButtonTypeJO.outlined)
                                  ? (hovered)
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.primary
                                  : (widget.type == TextIconButtonTypeJO.filled)
                                      ? (hovered)
                                          ? Theme.of(context)
                                              .scaffoldBackgroundColor
                                          : Theme.of(context)
                                              .scaffoldBackgroundColor
                                      : (hovered)
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary,
                              fontSize: widget.textSize,
                            ),
                          ),
                        ]
                      : [],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
