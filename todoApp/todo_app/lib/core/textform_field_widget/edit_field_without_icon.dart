import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/app_theme/theme_generator.dart';
import 'package:todo_app/core/keyboard/numeric_keyboard_overlay.dart';

/// [EditTextFieldWithoutIcon] widget is reuseable text field
/// password visibility toggle icon and action button icon
/// it provide text field value via [onChange] and [onSubmit]
/// to display error update [errorMsg] with error message text,
/// to remove error update [errorMsg] with empty string
/// [inputTextStyleFont] font size of input text User Either 14 or 20 as specify in Global in Figma
/// [keyboardType] /// Keyboard type that will be pop up for user check option example [TextInputType.Number]
class EditTextFieldWithoutIcon extends StatefulWidget {
  /// error msg that will display to user
  final String errorMsg;

  /// call back when user start type, onChange(inputValue){ do some thin with inputValue}
  final Function(String) onChange;

  /// call back when user tap on the text field, onChange(inputValue){ do some thin with inputValue}
  final Function(String)? onTap;

  /// call back when enter and submit text field, onSubmit(inputValue){ do some thin with inputValue}
  final Function(String) onSubmit;

  /// Keyboard type that will be pop up for user check option example [TextInputType.Number]
  final TextInputType keyboardType;

  /// decoration will be allowed to type of autofill widget input
  final InputDecoration? decoration;

  /// autofillHints will be allowed to automatically retrieve local user data
  final Iterable<String>? autofillHints;

  /// String value of floating label example: Username / Credit Card Number
  final String floatingLabelText;

  /// font size of input text User Either 14 or 20 as specify in Global in Figma
  final double inputTextStyleFont;

  /// make list of characters allowed in text field
  /// example [ FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9.)]')), ]
  final List<TextInputFormatter> inputFormatters;

  /// text controller that can provide you value of text field example [controller.value.text]
  final TextEditingController? controller;

  final String componentName;

  final bool enableInteractiveSelection;

  final bool enableSuggestions;

  final bool autocorrect;

  final TextInputAction? textInputAction;

  final bool isShowFlag;

  final bool? enableLabel;

  /// semantic label for error message
  final String? errorMessageSemanticLabel;

  final FocusNode? focusNode;

  final bool? isBottomNavigationBar;
  final FocusNode? accessibilityFocusNode;

  final Key? textKey;
  final String? hintErrorMessage;

  const EditTextFieldWithoutIcon(
      {Key? key,
      required this.errorMsg,
      required this.onChange,
      this.onTap,
      required this.onSubmit,
      required this.keyboardType,
      required this.floatingLabelText,
      required this.inputTextStyleFont,
      required this.inputFormatters,
      required this.componentName,
      this.controller,
      this.enableInteractiveSelection = false,
      this.enableSuggestions = false,
      this.autocorrect = false,
      this.textInputAction,
      this.isShowFlag = false,
      this.enableLabel,
      this.errorMessageSemanticLabel,
      this.decoration,
      this.autofillHints = const <String>[],
      this.focusNode,
      this.isBottomNavigationBar,
      this.textKey,
      this.hintErrorMessage,
      this.accessibilityFocusNode})
      : super(key: key);

  @override
  _EditTextFieldWithoutIconState createState() =>
      _EditTextFieldWithoutIconState();
}

class _EditTextFieldWithoutIconState extends State<EditTextFieldWithoutIcon> {
  /// [FocusNode] of text field
  late FocusNode _focus;

  /// default font size of input text style
  double inputTextFontSize = 14.0;

  /// inputTextStyle when user is editing
  late TextStyle inputTextStyleActive;

  /// inputTextStyle for Account Setting Card Activation Page
  late TextStyle inputTextStyleOnRestAS;

  /// inputTextStyle when user completed edit and focus in not on text field
  late TextStyle inputTextStyleOnRest;

  /// inputTextStyle of error state
  late TextStyle inputTextStyleOnRestError;

  late TextEditingController _controller;

  late bool isShowFlag;

  late bool isBottomNavigationBar;

  @override
  void initState() {
    isBottomNavigationBar = widget.isBottomNavigationBar ?? false;

    _focus = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();

    isShowFlag = widget.isShowFlag;

    inputTextFontSize = widget.inputTextStyleFont;
    var heightLine = inputTextFontSize > 18 ? 20.sp : 12.sp;
    inputTextStyleActive = ThemeGenerator().bodyCopy_14.copyWith(
        color: Colors.white,
        height: inputTextFontSize / heightLine,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w700,
        fontSize: inputTextFontSize);
    inputTextStyleOnRest = ThemeGenerator().bodyCopy_14.copyWith(
        color: Color.fromARGB(167, 1, 12, 18),
        height: inputTextFontSize / heightLine,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w700,
        fontSize: inputTextFontSize);

    inputTextStyleOnRestAS = ThemeGenerator().bodyCopy_14.copyWith(
        color: Colors.white,
        height: inputTextFontSize / heightLine,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w700,
        fontSize: inputTextFontSize);

    inputTextStyleOnRestError = ThemeGenerator().bodyCopy_14.copyWith(
        color: Color.fromRGBO(224, 60, 49, 0.2),
        height: inputTextFontSize / heightLine,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w700,
        fontSize: inputTextFontSize);

    if (widget.keyboardType == TextInputType.number) {
      _focus.addListener(() async {
        var hasFocus = _focus.hasFocus;
        if (hasFocus) {
          NumericKeyboardOverlay.showOverlay(context,
              isBottomNavigationBar: isBottomNavigationBar);
        } else {
          NumericKeyboardOverlay.removeOverlay();
        }
      });
    }

    _focus.addListener(() {
      setState(() {});
    });
    // _controller.addListener(() {
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  void dispose() {
    _focus.dispose();
    // _controller.dispose();
    super.dispose();
  }

  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();

  RestorableTextEditingController? _controler;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controler!.value;

  EditableTextState? get _editableText => editableTextKey.currentState;

  /// floatingLabel textStyle when user is editing
  TextStyle floatingLabelStyleActive = ThemeGenerator()
      .bodyCopy_12
      .copyWith(color: Color.fromRGBO(18, 17, 84, 0.2), height: 1.5);

  /// floatingLabel textStyle when user completed edit and focus in not on text field
  TextStyle floatingLabelStyleOnRest = ThemeGenerator()
      .bodyCopy_14
      .copyWith(color: Color.fromRGBO(38, 51, 22, 0.2), height: 1.5);

  ///floatingLabel textStyle for card Activation Account Setting Page
  TextStyle floatingLabelStyleActiveCASP =
      ThemeGenerator().bodyCopy_12.copyWith(color: Colors.white, height: 1.5);

  TextStyle floatingLabelStyleOnRestCASP =
      ThemeGenerator().bodyCopy_14.copyWith(color: Colors.white, height: 1.5);

  /// floatingLabel textStyle of error state
  TextStyle floatingLabelStyleActiveError = ThemeGenerator()
      .bodyCopy_12
      .copyWith(color: Color.fromRGBO(224, 60, 49, 0.2), height: 1.5);

  /// function that return text style based on conditions
  TextStyle getFloatingStyle() {
    if (widget.enableLabel != null) {
      if (widget.enableLabel!) {
        return widget.errorMsg.isNotEmpty
            ? floatingLabelStyleActiveError
            : floatingLabelStyleActive;
      }
    }

    if (isShowFlag) {
      if (_focus.hasFocus && _controller.value.text.isEmpty) {
        return floatingLabelStyleActiveCASP;
      }
    }
    if (isShowFlag) {
      if (_focus.hasFocus && _controller.value.text.isNotEmpty) {
        return floatingLabelStyleActiveCASP;
      }
    }

    if (isShowFlag) {
      return floatingLabelStyleOnRestCASP;
    }

    if (_focus.hasFocus && _controller.value.text.isEmpty) {
      return floatingLabelStyleActive;
    }
    if (_focus.hasFocus && _controller.value.text.isNotEmpty) {
      return floatingLabelStyleActive;
    }
    if (!_focus.hasFocus && _controller.value.text.isNotEmpty) {
      return widget.errorMsg.isNotEmpty
          ? floatingLabelStyleActiveError
          : floatingLabelStyleActive;
    }
    return floatingLabelStyleOnRest;
  }

  /// function that return text style based on conditions
  TextStyle getInputTextStyle() {
    if (widget.enableLabel != null) {
      if (_focus.hasFocus && _controller.value.text.isEmpty) {
        return inputTextStyleActive;
      }
      if (_focus.hasFocus && _controller.value.text.isNotEmpty) {
        return inputTextStyleActive;
      }
      if (widget.enableLabel!) {
        return inputTextStyleOnRest;
      }
    }
    if (isShowFlag) {
      if (!_focus.hasFocus && _controller.value.text.isNotEmpty) {
        return widget.errorMsg.isNotEmpty
            ? inputTextStyleOnRestError
            : inputTextStyleOnRestAS;
      }
    }
    if (_focus.hasFocus && _controller.value.text.isEmpty) {
      return inputTextStyleActive;
    }
    if (_focus.hasFocus && _controller.value.text.isNotEmpty) {
      return inputTextStyleActive;
    }
    if (!_focus.hasFocus && _controller.value.text.isNotEmpty) {
      return widget.errorMsg.isNotEmpty
          ? inputTextStyleOnRestError
          : inputTextStyleOnRest;
    }
    return inputTextStyleOnRest;
  }

  /// function that return floating label position based on conditions
  AlignmentGeometry floatingLabelPosition() {
    if (_focus.hasFocus && _controller.value.text.isEmpty) {
      return Alignment.topLeft;
    }
    if (_focus.hasFocus && _controller.value.text.isNotEmpty) {
      return Alignment.topLeft;
    }
    if (!_focus.hasFocus && _controller.value.text.isNotEmpty) {
      return Alignment.topLeft;
    }
    return Alignment.bottomLeft;
  }

  /// function that return border color or text field
  Color getBorderColor() {
    if (isShowFlag) {
      if (_focus.hasFocus) {
        return Colors.white;
      }
    }
    if (_focus.hasFocus) {
      return Colors.transparent;
    }
    if (widget.errorMsg.isNotEmpty) {
      return Color.fromRGBO(224, 60, 49, 0.2);
    }
    return Colors.transparent;
  }

  /// function that returns border line color inbetween text field
  Color getUnderlineColor() {
    if (isShowFlag) {
      return Colors.white;
    }
    return Color.fromRGBO(38, 51, 22, 0.2);
  }

  // AutofillClient implementation start.
  String get autofillId => _editableText!.autofillId;

  void autofill(TextEditingValue newEditingValue) =>
      _editableText!.autofill(newEditingValue);

  TextInputConfiguration get textInputConfiguration {
    var autofillHints = widget.autofillHints?.toList(growable: false);
    var autofillConfiguration = autofillHints != null
        ? AutofillConfiguration(
            uniqueIdentifier: autofillId,
            autofillHints: autofillHints,
            currentEditingValue: _effectiveController.value,
            hintText: (widget.decoration ?? const InputDecoration()).hintText,
          )
        : AutofillConfiguration.disabled;

    return _editableText!.textInputConfiguration
        .copyWith(autofillConfiguration: autofillConfiguration);
  }

  // AutofillClient implementation end.

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Focus(
      focusNode: widget.accessibilityFocusNode,
      child: SizedBox(
        // height: 80,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 65,
              width: size.width,
              child: Stack(
                children: [
                  /// label text
                  ExcludeSemantics(
                    child: Padding(
                      padding: EdgeInsets.only(

                          ///Fix for MA-2689
                          left: 20.w,
                          right: 20,
                          bottom: 13.h,
                          top: 0),
                      child: AnimatedAlign(
                          alignment: floatingLabelPosition(),
                          duration: const Duration(milliseconds: 300),
                          child: Text(widget.floatingLabelText,
                              style: getFloatingStyle())),
                    ),
                  ),

                  /// animated bottom line
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        right: 20,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: 1,
                        color: widget.errorMsg.isNotEmpty
                            ? Colors.transparent
                            : getUnderlineColor(),
                        width: _focus.hasFocus ? 0 : size.width,
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 20, bottom: 3),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// animated container
                          Semantics(
                            textField:
                                true, // Property reads the widgets as EditBox
                            child: GestureDetector(
                              onTap: _focus.requestFocus,
                              child: AnimatedContainer(
                                height: 40,
                                duration: const Duration(milliseconds: 700),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(color: getBorderColor()),
                                    color: _focus.hasFocus
                                        ? Color.fromARGB(255, 1, 55, 100)
                                        : Colors.transparent),
                                alignment: Alignment.bottomLeft,

                                /// text field
                                child: ExcludeSemantics(
                                  child: TextField(
                                    key: widget.textKey ?? const Key('textKey'),
                                    inputFormatters: widget.inputFormatters,
                                    cursorColor: Colors.white,
                                    enableInteractiveSelection:
                                        widget.enableInteractiveSelection,
                                    enableSuggestions: widget.enableSuggestions,
                                    autocorrect: widget.autocorrect,
                                    autofillHints: widget.autofillHints,
                                    toolbarOptions: ToolbarOptions(
                                        copy: widget.enableInteractiveSelection,
                                        cut: widget.enableInteractiveSelection,
                                        paste:
                                            widget.enableInteractiveSelection,
                                        selectAll:
                                            widget.enableInteractiveSelection),
                                    //autovalidateMode: AutovalidateMode.disabled,
                                    style: getInputTextStyle(),
                                    focusNode: _focus,
                                    controller: _controller,
                                    keyboardType: widget.keyboardType,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(
                                          left: 10.w, bottom: 10.h),
                                    ),
                                    textInputAction: widget.textInputAction,
                                    onTap: () {
                                      widget.onTap;
                                    },
                                    onChanged: (value) {
                                      widget.onChange(value);
                                    },
                                    onSubmitted: (value) {
                                      widget.onSubmit(value);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// error text
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
              ),
              child: Text(
                widget.errorMsg,
                style: floatingLabelStyleActiveError,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
