import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/app_theme/theme_generator.dart';

enum ButtonWidgetType { xLarge, large, small }

enum ButtonWidgetStyle { primary, secondary }

class ButtonProperties {
  // Colors that used by button
  static Color transparent = Colors.transparent;
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color seaWeed = Color.fromARGB(255, 3, 137, 123);
}

/// Class provides reusable component for button types primary, secondary.
// Button is a StatefulWidget where it's observing changes in state of button.
class Button extends StatefulWidget {
  // required properties
  final ButtonWidgetType buttonWidgetType;
  final ButtonWidgetStyle buttonWidgetStyle;
  final String title;
  final double width;
  final Key? buttonKey;
  final TextStyle? textStyle;
  final bool? isAccountSettings;

  // optional property where it provides callback of onPressed.
  final VoidCallback? onPressed;

  /// Constructor for class
  const Button(
      {Key? key,
      this.buttonKey,
      this.onPressed,
      this.buttonWidgetType = ButtonWidgetType.large,
      this.buttonWidgetStyle = ButtonWidgetStyle.primary,
      required this.title,
      required this.width,
      this.textStyle,
      this.isAccountSettings})
      : super(key: key);

  /// Private state for Button
  @override
  _ButtonState createState() => _ButtonState();
}

/// Private Button State where it provides StatefulWidget
class _ButtonState extends State<Button> {
  // private properties for state class
  late final ButtonWidgetType _buttonWidgetType = widget.buttonWidgetType;
  late final ButtonWidgetStyle _buttonWidgetStyle = widget.buttonWidgetStyle;

  // properties that are useful for button creation
  late double titleFontSize;
  late Color backgroundColor;
  late double buttonHeight;
  late bool isHighlighted = false;
  late Color highlightColor;
  double borderWidth = 1.0.w;
  double highlightedElevation = 0.0;
  double elevation = 6;
  double largeButtonHeight = 45;
  double xLargeButtonHeight = 50;
  double smallButtonHeight = 30;
  Color splashColor = Colors.white.withOpacity(0.2);
  late BorderRadius buttonBorderRadius;

  /// Method that returns text color based on changed state of button
  /// parameters: bool
  /// returns: Color
  Color textColor(changed) {
    return changed == false
        ? widget.isAccountSettings == true
            ? (_buttonWidgetStyle == ButtonWidgetStyle.primary
                ? ButtonProperties.seaWeed
                : ButtonProperties.white)
            : (_buttonWidgetStyle == ButtonWidgetStyle.primary
                ? ButtonProperties.white
                : ButtonProperties.seaWeed)
        : ButtonProperties.white;
  }

  /// Method that returns border color based on changed state of button
  /// parameters: bool
  /// returns: Color
  Color borderColor(changed) {
    return changed == false
        ? widget.isAccountSettings == true
            ? (_buttonWidgetStyle == ButtonWidgetStyle.primary
                ? ButtonProperties.seaWeed
                : ButtonProperties.white)
            : (_buttonWidgetStyle == ButtonWidgetStyle.primary
                ? ButtonProperties.transparent
                : ButtonProperties.seaWeed)
        : ButtonProperties.white;
  }

  /// override initState method creating initial properties for default state
  @override
  void initState() {
    switch (_buttonWidgetType) {
      case ButtonWidgetType.xLarge:
        titleFontSize = ThemeGenerator.defaultXlButtonTitleFontSize.sp;
        buttonHeight = xLargeButtonHeight;
        break;
      case ButtonWidgetType.small:
        titleFontSize = ThemeGenerator.defaultSmallButtonTitleFontSize.sp;
        buttonHeight = smallButtonHeight;
        break;
      case ButtonWidgetType.large:
        titleFontSize = ThemeGenerator.defaultButtonTitleFontSize.sp;
        buttonHeight = largeButtonHeight;
        break;
    }

    buttonBorderRadius = BorderRadius.circular(buttonHeight);
    backgroundColor = _buttonWidgetStyle == ButtonWidgetStyle.primary
        ? ButtonProperties.seaWeed
        : ButtonProperties.white;
    if (widget.isAccountSettings == true) {
      backgroundColor = _buttonWidgetStyle == ButtonWidgetStyle.primary
          ? ButtonProperties.white
          : ButtonProperties.transparent;
    }

    highlightColor = _buttonWidgetStyle == ButtonWidgetStyle.primary
        ? Color.fromARGB(255, 11, 46, 76)
        : Color.fromARGB(255, 0, 131, 239);

    super.initState();
  }

  /// dispose method will dispose the widget after allocation set to nil
  @override
  void dispose() {
    super.dispose();
  }

  /// build method that takes BuildContext and return Widget for StatefulWidget
  /// parameters: BuildContext
  /// return: Widget
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: buttonHeight.h,
      child: ClipRRect(
        borderRadius: buttonBorderRadius,
        child: MaterialButton(
          key: widget.buttonKey,
          elevation: elevation,
          highlightElevation: highlightedElevation,
          color: backgroundColor,
          onPressed: buttonOnPressed,
          onHighlightChanged: onHighlightChanged,
          shape: RoundedRectangleBorder(
            borderRadius: buttonBorderRadius,
            side: BorderSide(
              color: borderColor(isHighlighted),
              width: borderWidth,
            ),
          ),
          highlightColor: highlightColor,
          splashColor: splashColor,
          child: Text(
            widget.title,
            style: widget.textStyle?.copyWith(
                  color: textColor(isHighlighted),
                  backgroundColor: ButtonProperties.transparent,
                  fontWeight: FontWeight.w700,
                ) ??
                ThemeGenerator().bodyCopy_16.copyWith(
                      color: textColor(isHighlighted),
                      backgroundColor: ButtonProperties.transparent,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w700,
                    ),
          ),
        ),
      ),
    );
  }

  // double smallButtonTitleFontSize(double fontSize) =>
  //     fontSize < 10.0 ? 10.0 : fontSize;

  /// button's highlighted state changes observed
  ///
  void onHighlightChanged(changed) {
    setState(() {
      isHighlighted = !isHighlighted;
    });
  }

  /// button's tap action handler
  ///
  void buttonOnPressed() {
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }
}
