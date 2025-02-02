part of './main.dart';

class _TextIconButtonJO extends TextIconButtonJO {
  const _TextIconButtonJO({
    super.key,
    required super.icon,
    required super.label,
    required super.reversed,
    required super.only,
    required this.expanded,
    super.onPressed,
    super.activated,
    super.iconSize,
    super.textSize,
    super.textWeight,
    super.color,
    super.cursor,
    this.filled = false,
  });

  final bool filled, expanded;

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
      expanded: expanded,
      activated: activated,
      onPressed: onPressed,
      iconSize: iconSize,
      textSize: textSize,
      textWeight: textWeight,
      color: color,
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
    this.textWeight,
    this.color,
    this.cursor,
  });

  final IconData icon;
  final String label;
  final bool reversed, activated;
  final void Function()? onPressed;
  final TextIconButtonOnlyJO only;
  final double? iconSize, textSize;
  final FontWeight? textWeight;
  final Color? color;
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
      textWeight: textWeight,
      color: color,
      cursor: cursor,
      expanded: false,
    );
  }

  factory TextIconButtonJO.outlined({
    Key? key,
    required IconData icon,
    required String label,
    TextIconButtonOnlyJO only = TextIconButtonOnlyJO.normal,
    bool reversed = false,
    bool activated = false,
    bool expanded = false,
    Function()? onPressed,
    double? iconSize,
    double? textSize,
    FontWeight? textWeight,
    Color? color,
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
      textWeight: textWeight,
      color: color,
      cursor: cursor,
      expanded: expanded,
    );
  }

  factory TextIconButtonJO.filled({
    Key? key,
    required IconData icon,
    required String label,
    TextIconButtonOnlyJO only = TextIconButtonOnlyJO.normal,
    bool reversed = false,
    bool activated = false,
    bool expanded = false,
    Function()? onPressed,
    double? iconSize,
    double? textSize,
    FontWeight? textWeight,
    Color? color,
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
      textWeight: textWeight,
      color: color,
      cursor: cursor,
      expanded: expanded,
    );
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
    required this.expanded,
    this.activated = false,
    this.type = TextIconButtonTypeJO.normal,
    this.onPressed,
    this.iconSize,
    this.textSize,
    this.textWeight,
    this.color,
    this.cursor,
  });

  final bool reversed, activated, expanded;
  final IconData icon;
  final String label;
  final TextIconButtonTypeJO type;
  final void Function()? onPressed;
  final TextIconButtonOnlyJO only;
  final double? iconSize, textSize;
  final FontWeight? textWeight;
  final Color? color;
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
    return Container(
      width: (widget.expanded) ? double.infinity : null,
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
            if (widget.onPressed != null) {
              widget.onPressed!();
            }
          },
          onPanCancel: () {
            onHover(false);
          },
          child: TextButton(
            onPressed: () {
              if (widget.onPressed != null) {
                widget.onPressed!();
              }
            },
            onHover: onHover,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: widget.type == TextIconButtonTypeJO.normal ? 0 : 7.5,
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
                                    : (widget.color == null)
                                        ? Theme.of(context).colorScheme.primary
                                        : widget.color
                                : (widget.type == TextIconButtonTypeJO.filled)
                                    ? Theme.of(context).scaffoldBackgroundColor
                                    : (hovered)
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                        : (widget.color == null)
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : widget.color,
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
                                      : (widget.color == null)
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : widget.color
                                  : (widget.type == TextIconButtonTypeJO.filled)
                                      ? (hovered)
                                          ? Theme.of(context)
                                              .scaffoldBackgroundColor
                                          : (widget.color == null)
                                              ? Theme.of(context)
                                                  .scaffoldBackgroundColor
                                              : widget.color
                                      : (hovered)
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                          : (widget.color == null)
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                              : widget.color,
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
