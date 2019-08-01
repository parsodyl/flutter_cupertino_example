import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: Builder(builder: (context) {
        final settings = Provider.of<Settings>(context);
        return ListView(children: [
          SettingControl(
            'Dark mode',
            CupertinoSwitch(
              value: settings.isDarkMode,
              onChanged: (bool value) {
                settings.isDarkMode = !settings.isDarkMode;
              },
            ),
          ),
          SettingControl(
            'Primary color',
            ColorPreview(
              onTap: () async {
                final color = await _selectColor(context, settings.accentColor);
                if (color != null) {
                  settings.accentColor = color;
                }
              },
              color: settings.accentColor,
            ),
          ),
        ]);
      }),
    );
  }

  Future<Color> _selectColor(BuildContext context, Color currentColor) async {
    return showCupertinoDialog<Color>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: Text("Change color"),
            content: Center(
              child: ColorSelector(
                onSelection: (color) {
                  Navigator.of(context).pop(color);
                },
                currentColor: currentColor,
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Cancel"),
                isDefaultAction: true,
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
    );
  }
}

class SettingControl extends StatelessWidget {
  final String name;
  final Widget contentWidget;

  SettingControl(this.name, this.contentWidget);

  @override
  Widget build(BuildContext context) {
    const kFontSize = 16.0;
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 0, minHeight: 50, maxHeight: 50),
        child: DecoratedBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(name, style: TextStyle(fontSize: kFontSize)),
                contentWidget,
              ],
            ),
          ),
          decoration: _buildDecoration(context),
        ),
      ),
    );
  }

  static BoxDecoration _buildDecoration(BuildContext context) {
    final isLight = CupertinoTheme.of(context).brightness == Brightness.light;
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: isLight
              ? CupertinoColors.lightBackgroundGray
              : CupertinoColors.darkBackgroundGray,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
    );
  }
}

class ColorPreview extends StatelessWidget {
  final GestureTapCallback onTap;
  final Color color;

  ColorPreview({this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 28,
        height: 28,
        child: Container(
          decoration: _buildDecoration(context, color),
        ),
      ),
    );
  }

  static BoxDecoration _buildDecoration(BuildContext context, Color bgColor) {
    final isLight = CupertinoTheme.of(context).brightness == Brightness.light;
    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.all(Radius.circular(5)),
      border: Border.all(
        color: !isLight
            ? CupertinoColors.lightBackgroundGray
            : CupertinoColors.darkBackgroundGray,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    );
  }
}

typedef ColorSelectedCallback = void Function(Color color);

class ColorSelector extends StatelessWidget {
  final Color currentColor;
  final ColorSelectedCallback onSelection;

  ColorSelector({@required this.onSelection, this.currentColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildCircleButton(kYellow),
          const SizedBox(width: 10),
          _buildCircleButton(kMagenta),
          const SizedBox(width: 10),
          _buildCircleButton(kCyan),
          const SizedBox(width: 10),
          _buildCircleButton(kGreen),
        ],
      ),
    );
  }

  CircleButton _buildCircleButton(Color color) {
    return CircleButton(
      isSelected: currentColor == color,
      color: color,
      onTap: () => onSelection(color),
    );
  }
}

class CircleButton extends StatelessWidget {
  final bool isSelected;
  final GestureTapCallback onTap;
  final Color color;

  const CircleButton({Key key, this.onTap, this.color, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const kSize = 28.0;

    return GestureDetector(
      onTap: !isSelected ? onTap : null,
      child: Container(
        width: kSize,
        height: kSize,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: _buildBorder(context, isSelected),
        ),
      ),
    );
  }

  static BoxBorder _buildBorder(BuildContext context, bool isSelected) {
    final isLight = CupertinoTheme.of(context).brightness == Brightness.light;
    return Border.all(
      color: !isSelected
          ? CupertinoColors.black
          : CupertinoColors.white.withOpacity(0.3),
      width: !isSelected ? 1.0 : 3.0,
      style: BorderStyle.solid,
    );
  }
}
