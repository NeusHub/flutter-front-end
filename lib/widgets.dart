import 'package:flutter/material.dart';

import './icons.dart';

enum NeusHubTextIconType { normal, filled, outlined }

enum NeusHubTextIconOnly { normal, textOnly, iconOnly }

class _NeusHubTextIconButton extends NeusHubTextIconButton {
  const _NeusHubTextIconButton({
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
    this.backgroundColor,
    super.cursor,
    this.padding,
    this.radius,
    this.filled = false,
  });

  final Color? backgroundColor;
  final bool filled, expanded;
  final EdgeInsets? padding;
  final BorderRadius? radius;

  @override
  Widget build(BuildContext context) {
    NeusHubTextIconType type =
        (filled) ? NeusHubTextIconType.filled : NeusHubTextIconType.outlined;
    return NeusHubTextIconButtonWidget(
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
      backgroundColor: backgroundColor ?? Colors.black,
      padding: padding,
      radius: radius,
      cursor: cursor,
    );
  }
}

class NeusHubTextIconButton extends StatelessWidget {
  const NeusHubTextIconButton({
    super.key,
    required this.icon,
    required this.label,
    this.reversed = false,
    this.activated = false,
    this.onPressed,
    this.only = NeusHubTextIconOnly.normal,
    this.iconSize,
    this.textSize,
    this.textWeight,
    this.textDecoration,
    this.color,
    this.cursor,
  });

  final IconData icon;
  final String label;
  final bool reversed, activated;
  final void Function()? onPressed;
  final NeusHubTextIconOnly only;
  final double? iconSize, textSize;
  final FontWeight? textWeight;
  final TextDecoration? textDecoration;
  final Color? color;
  final MouseCursor? cursor;

  @override
  Widget build(BuildContext context) {
    return NeusHubTextIconButtonWidget(
      reversed: reversed,
      icon: icon,
      label: label,
      only: only,
      activated: activated,
      onPressed: onPressed,
      iconSize: iconSize,
      textSize: textSize,
      textWeight: textWeight,
      textDecoration: textDecoration,
      color: color,
      cursor: cursor,
      expanded: false,
    );
  }

  factory NeusHubTextIconButton.outlined({
    Key? key,
    required IconData icon,
    required String label,
    NeusHubTextIconOnly only = NeusHubTextIconOnly.normal,
    bool reversed = false,
    bool activated = false,
    bool expanded = false,
    Function()? onPressed,
    double? iconSize,
    double? textSize,
    FontWeight? textWeight,
    Color? color,
    Color? backgroundColor,
    EdgeInsets? padding,
    BorderRadius? radius,
    MouseCursor? cursor,
  }) {
    return _NeusHubTextIconButton(
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
      backgroundColor: backgroundColor,
      padding: padding,
      radius: radius,
      cursor: cursor,
      expanded: expanded,
    );
  }

  factory NeusHubTextIconButton.filled({
    Key? key,
    required IconData icon,
    required String label,
    NeusHubTextIconOnly only = NeusHubTextIconOnly.normal,
    bool reversed = false,
    bool activated = false,
    bool expanded = false,
    Function()? onPressed,
    double? iconSize,
    double? textSize,
    FontWeight? textWeight,
    Color? color,
    Color? backgroundColor,
    EdgeInsets? padding,
    BorderRadius? radius,
    MouseCursor? cursor,
  }) {
    return _NeusHubTextIconButton(
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
      backgroundColor: backgroundColor,
      padding: padding,
      radius: radius,
      cursor: cursor,
      expanded: expanded,
    );
  }
}

class NeusHubTextIconButtonWidget extends StatefulWidget {
  const NeusHubTextIconButtonWidget({
    super.key,
    required this.reversed,
    required this.icon,
    required this.label,
    required this.only,
    required this.expanded,
    this.activated = false,
    this.type = NeusHubTextIconType.normal,
    this.onPressed,
    this.iconSize,
    this.textSize,
    this.textWeight,
    this.textDecoration,
    this.color,
    this.backgroundColor = Colors.black,
    this.padding,
    this.radius,
    this.cursor,
  });

  final bool reversed, activated, expanded;
  final IconData icon;
  final String label;
  final NeusHubTextIconType type;
  final void Function()? onPressed;
  final NeusHubTextIconOnly only;
  final double? iconSize, textSize;
  final FontWeight? textWeight;
  final TextDecoration? textDecoration;
  final Color? color;
  final Color backgroundColor;
  final EdgeInsets? padding;
  final BorderRadius? radius;
  final MouseCursor? cursor;

  @override
  State<NeusHubTextIconButtonWidget> createState() {
    return _NeusHubTextIconButtonWidgetState();
  }
}

class _NeusHubTextIconButtonWidgetState
    extends State<NeusHubTextIconButtonWidget> {
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
        borderRadius:
            (widget.radius == null) ? BorderRadius.circular(10) : widget.radius,
        color: (widget.type == NeusHubTextIconType.filled)
            ? (hovered)
                ? Theme.of(context).colorScheme.onPrimary
                : widget.backgroundColor
            : null,
        border: (widget.type == NeusHubTextIconType.outlined)
            ? Border.all(
                color: (hovered)
                    ? Theme.of(context).colorScheme.onPrimary
                    : widget.backgroundColor,
                width: 1,
              )
            : (widget.type == NeusHubTextIconType.filled)
                ? Border.all(
                    color: (hovered)
                        ? Theme.of(context).colorScheme.onPrimary
                        : widget.backgroundColor,
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
            child: Container(
              padding: (widget.padding == null)
                  ? EdgeInsets.symmetric(
                      vertical:
                          widget.type == NeusHubTextIconType.normal ? 0 : 7.5,
                      horizontal:
                          widget.type == NeusHubTextIconType.normal ? 0 : 20,
                    )
                  : widget.padding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: (widget.reversed) ? TextDirection.rtl : null,
                children: [
                  ...(widget.only == NeusHubTextIconOnly.normal ||
                          widget.only == NeusHubTextIconOnly.iconOnly)
                      ? [
                          Icon(
                            widget.icon,
                            color: (widget.type == NeusHubTextIconType.outlined)
                                ? (hovered)
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : (widget.color == null)
                                        ? Theme.of(context).colorScheme.primary
                                        : widget.color
                                : (widget.type == NeusHubTextIconType.filled)
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
                            size: widget.iconSize,
                          ),
                        ]
                      : [],
                  ...(widget.only == NeusHubTextIconOnly.normal ||
                          widget.only == NeusHubTextIconOnly.textOnly)
                      ? [
                          ...(widget.only == NeusHubTextIconOnly.textOnly)
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
                              decoration:
                                  (hovered) ? widget.textDecoration : null,
                              decorationColor: (hovered)
                                  ? Theme.of(context).colorScheme.onSecondary
                                  : (widget.color == null)
                                      ? Theme.of(context).colorScheme.secondary
                                      : widget.color,
                              color: (widget.type ==
                                      NeusHubTextIconType.outlined)
                                  ? (hovered)
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : (widget.color == null)
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : widget.color
                                  : (widget.type == NeusHubTextIconType.filled)
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

// -----------------------------------------------------------------------------

enum NeusHubTextIconFieldType {
  name,
  email,
  password,
  confirmPassword,
}

class _NeusHubTextIconField extends NeusHubTextIconField {
  const _NeusHubTextIconField({
    super.key,
    super.only,
    super.expanded,
    required super.contrroller,
    required super.fieldType,
    required super.formKey,
    required this.type,
  });

  final NeusHubTextIconType type;

  @override
  Widget build(BuildContext context) {
    return NeusHubTextIconFieldWidget(
      key: key,
      only: only,
      expanded: expanded,
      fieldType: fieldType,
      formKey: formKey,
      type: type,
      contrroller: contrroller,
    );
  }
}

class NeusHubTextIconField extends StatelessWidget {
  const NeusHubTextIconField({
    super.key,
    required this.fieldType,
    required this.formKey,
    this.only = NeusHubTextIconOnly.normal,
    this.expanded = false,
    required this.contrroller,
  });

  final NeusHubTextIconOnly only;
  final bool expanded;
  final NeusHubTextIconFieldType fieldType;
  final GlobalKey<FormState> formKey;
  final TextEditingController contrroller;

  @override
  Widget build(BuildContext context) {
    return NeusHubTextIconFieldWidget(
      key: key,
      only: only,
      expanded: expanded,
      fieldType: fieldType,
      formKey: formKey,
      type: NeusHubTextIconType.normal,
      contrroller: contrroller,
    );
  }

  factory NeusHubTextIconField.filled({
    Key? key,
    NeusHubTextIconOnly only = NeusHubTextIconOnly.normal,
    bool expanded = false,
    required NeusHubTextIconFieldType fieldType,
    required GlobalKey<FormState> formKey,
    required TextEditingController contrroller,
  }) {
    return _NeusHubTextIconField(
      key: key,
      only: only,
      expanded: expanded,
      fieldType: fieldType,
      formKey: formKey,
      type: NeusHubTextIconType.filled,
      contrroller: contrroller,
    );
  }

  factory NeusHubTextIconField.outlined({
    Key? key,
    NeusHubTextIconOnly only = NeusHubTextIconOnly.normal,
    bool expanded = false,
    required NeusHubTextIconFieldType fieldType,
    required GlobalKey<FormState> formKey,
    required TextEditingController contrroller,
  }) {
    return _NeusHubTextIconField(
      key: key,
      only: only,
      expanded: expanded,
      fieldType: fieldType,
      formKey: formKey,
      type: NeusHubTextIconType.outlined,
      contrroller: contrroller,
    );
  }
}

class NeusHubTextIconFieldWidget extends StatefulWidget {
  const NeusHubTextIconFieldWidget({
    super.key,
    required this.only,
    required this.expanded,
    required this.fieldType,
    required this.formKey,
    required this.type,
    required this.contrroller,
  });

  final NeusHubTextIconOnly only;
  final NeusHubTextIconFieldType fieldType;
  final GlobalKey<FormState> formKey;
  final NeusHubTextIconType type;
  final bool expanded;
  final TextEditingController contrroller;

  @override
  State<NeusHubTextIconFieldWidget> createState() =>
      _NeusHubTextIconFieldWidgetState();
}

class _NeusHubTextIconFieldWidgetState
    extends State<NeusHubTextIconFieldWidget> {
  Widget? error;
  bool hide = true;

  Icon iconNeusHubTextIconField(NeusHubTextIconFieldType fieldType) {
    return Icon(switch (fieldType) {
      NeusHubTextIconFieldType.name => NeusHubIcons.name,
      NeusHubTextIconFieldType.email => NeusHubIcons.email,
      NeusHubTextIconFieldType.password ||
      NeusHubTextIconFieldType.confirmPassword =>
        NeusHubIcons.lock,
    });
  }

  String placeholderNeusHubTextIconField(NeusHubTextIconFieldType fieldType) {
    return switch (fieldType) {
      NeusHubTextIconFieldType.name => 'Abdelrahman Ahmed',
      NeusHubTextIconFieldType.email => 'Abdelrahman@example.com',
      NeusHubTextIconFieldType.password ||
      NeusHubTextIconFieldType.confirmPassword =>
        'Password',
    };
  }

  String labelNeusHubTextIconField(NeusHubTextIconFieldType fieldType) {
    return switch (fieldType) {
      NeusHubTextIconFieldType.name => 'Full name',
      NeusHubTextIconFieldType.email => 'Email',
      NeusHubTextIconFieldType.password => 'Password',
      NeusHubTextIconFieldType.confirmPassword => 'Confirm password',
    };
  }

  Widget? suffixNeusHubTextIconField(NeusHubTextIconFieldType fieldType) {
    return switch (fieldType) {
      NeusHubTextIconFieldType.password ||
      NeusHubTextIconFieldType.confirmPassword =>
        SizedBox(
          width: 10,
          height: 10,
          child: TextButton(
            style: ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.zero),
            ),
            onPressed: () {
              setState(() {
                hide = !hide;
              });
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(
                NeusHubIcons.eye,
              ),
            ),
          ),
        ),
      _ => null,
    };
  }

  Widget? regxNeusHubTextIconField(
    NeusHubTextIconFieldType fieldType, [
    String value = '',
  ]) {
    switch (fieldType) {
      case NeusHubTextIconFieldType.email:
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return Column(
            children: [
              Text(
                'Please enter a valid email',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              SizedBox(height: 10),
            ],
          );
        } else {
          return null;
        }
      case NeusHubTextIconFieldType.password ||
            NeusHubTextIconFieldType.confirmPassword:
        if (!RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
        ).hasMatch(value)) {
          return Column(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Password must contain:\n'),
                    TextSpan(text: '- At least 8 characters\n'),
                    TextSpan(text: '- At least one uppercase letter\n'),
                    TextSpan(text: '- At least one lowercase letter\n'),
                    TextSpan(text: '- At least one digit\n'),
                    TextSpan(
                        text: '- At least one special character (!@#\$&*~)'),
                  ],
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
              SizedBox(height: 10),
            ],
          );
        } else {
          return null;
        }
      case NeusHubTextIconFieldType.name:
        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
          return Column(
            children: [
              Text(
                'Please enter a valid name',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              SizedBox(height: 10),
            ],
          );
        } else {
          return null;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelNeusHubTextIconField(widget.fieldType),
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        SizedBox(height: 5),
        Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: switch (widget.type) {
                    NeusHubTextIconType.filled ||
                    NeusHubTextIconType.outlined =>
                      Theme.of(context).colorScheme.onSurface,
                    _ => null,
                  },
                  borderRadius: BorderRadius.circular(10),
                  border: switch (widget.type) {
                    NeusHubTextIconType.outlined => Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    _ => Border.all(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  }),
              child: TextFormField(
                controller: widget.contrroller,
                obscureText: switch (widget.fieldType) {
                  NeusHubTextIconFieldType.password ||
                  NeusHubTextIconFieldType.confirmPassword =>
                    hide,
                  _ => false,
                },
                onChanged: (value) {
                  setState(() {
                    error = regxNeusHubTextIconField(widget.fieldType, value);
                  });
                },
                scrollPadding: EdgeInsets.zero,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  icon: (widget.only == NeusHubTextIconOnly.textOnly)
                      ? null
                      : iconNeusHubTextIconField(widget.fieldType),
                  iconColor: Theme.of(context).colorScheme.primary,
                  contentPadding: EdgeInsets.zero,
                  hintText: placeholderNeusHubTextIconField(widget.fieldType),
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  suffix: suffixNeusHubTextIconField(widget.fieldType),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: error,
            ),
          ],
        ),
      ],
    );
  }
}
