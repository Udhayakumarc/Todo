import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/app_theme/theme_generator.dart';
import 'package:todo_app/core/cache_images/cache_image_builder.dart';
import 'package:todo_app/core/keyboard/numeric_keyboard_overlay.dart';

/// [EditTextFieldWithIcons] widget is reuseable text field with optional of tooltip icon button, action button and password toggle
/// password visibility toggle icon and action button icon
/// it provide text field value via [onChange] and [onSubmit]
/// to display error update [errorMsg] with error message text,
/// to remove error update [errorMsg] with empty string
/// if [hasToolTip] is true then tool tip icon will be displayed right end of text field
/// [onToolTipTap] will provide call back when user tap on icon
/// [hasActionButton] is true then action button widget will be display left to tooltip or right end of text field
/// [actionButtonImage] is image path of action button icon
/// [onActionButtonTap] will provide call back when user tap on action icon
class EditTextFieldWithIcons extends StatefulWidget {
  /// error msg that will display to user
  final String errorMsg;

  /// call back when user start type, onChange(inputValue){ do some thin with inputValue}
  final Function(String) onChange;

  /// call back when enter and submit text field, onSubmit(inputValue){ do some thin with inputValue}
  final Function(String) onSubmit;

  /// void callback when user taps on text field
  final VoidCallback? onTap;

  /// Keyboard type that will be pop up for user check option example [TextInputType.Number]
  final TextInputType keyboardType;

  /// decoration will be allowed to type of autofill widget input
  final InputDecoration? decoration;

  /// autofillHints will be allowed to automatically retrieve local user data
  final Iterable<String>? autofillHints;

  /// String value of floating label example: Username / Credit Card Number
  final String floatingLabelText;

  /// true if toolTip icon is available in widget
  final bool hasToolTip;

  /// call back function on event of tap on tool tip icon
  final VoidCallback? onToolTipTap;

  /// if true field will be consider as password field,
  /// and action button widget will be only visible if there is no text in text field,
  /// when there is text is text field password visibility toggle presented
  final bool obscureText;

  /// font size of input text User Either 14 or 20 as specify in Global in Figma
  final double inputTextStyleFont;

  /// make list of characters allowed in text field
  /// example [ FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9.)]')), ]
  final List<TextInputFormatter> inputFormatters;

  /// if ture text filled show action widget
  final bool hasActionButton;

  /// icon image of action button
  final CacheImageUrl? actionButtonImage;

  /// void callback when user click on action button
  final VoidCallback? onActionButtonTap;

  /// semantic label for text field
  final String textFieldSemanticLabel;

  /// semantic label for action button
  final String? actionButtonSemanticLabel;

  /// semantic label for toolTip
  final String? toolTipSemanticLabel;

  /// semantic label for error message
  final String? errorMessageSemanticLabel;

  /// text controller that can provide you value of text field example [controller.value.text]
  final TextEditingController? controller;

  final bool enableInteractiveSelection;

  final bool enableSuggestions;

  final bool autocorrect;

  final TextInputAction? textInputAction;

  final bool isShowFlag;

  final bool isFlag;

  final bool? isBottomNavigationBar;
  final bool isLabelError;
  final VoidCallback? onFocusCallback;
  final double? scrollPadding;
  final Key? toolTipKey;
  final Key? textKey;
  final Key? actionButtonKey;
  final FocusNode? accessibilityFocusNode;

  const EditTextFieldWithIcons(
      {Key? key,
      required this.errorMsg,
      required this.onChange,
      required this.onSubmit,
      this.onTap,
      required this.keyboardType,
      required this.floatingLabelText,
      required this.hasToolTip,
      this.onToolTipTap,
      this.onFocusCallback,
      required this.obscureText,
      required this.inputTextStyleFont,
      required this.inputFormatters,
      required this.hasActionButton,
      this.actionButtonImage,
      this.onActionButtonTap,
      this.toolTipKey,
      required this.textFieldSemanticLabel,
      this.actionButtonSemanticLabel,
      this.toolTipSemanticLabel,
      this.controller,
      this.enableInteractiveSelection = false,
      this.enableSuggestions = false,
      this.autocorrect = false,
      this.textInputAction,
      this.isShowFlag = false,
      this.isFlag = false,
      this.errorMessageSemanticLabel,
      this.decoration,
      this.isLabelError = false,
      this.autofillHints = const <String>[],
      this.scrollPadding,
      this.isBottomNavigationBar,
      this.textKey,
      this.actionButtonKey,
      this.accessibilityFocusNode})
      : super(key: key);

  @override
  _EditTextFieldWithIconsState createState() => _EditTextFieldWithIconsState();
}

class _EditTextFieldWithIconsState extends State<EditTextFieldWithIcons> {
  /// [FocusNode] of text field
  final _focus = FocusNode();

  /// default font size of input text style
  double inputTextFontSize = 14.0;

  /// inputTextStyle when user is editing
  late TextStyle inputTextStyleActive;

  /// inputTextStyle when user completed edit and focus in not on text field
  late TextStyle inputTextStyleOnRest;

  /// inputTextStyle for Account Setting Card Activation Page
  late TextStyle inputTextStyleOnRestAS;

  /// inputTextStyle of error state
  late TextStyle inputTextStyleOnRestError;

  /// password visibility state
  late bool obscureText;

  /// inputTextStyle of  hint
  late TextStyle inputTextHintErrorStyle;
  late TextEditingController _controller;

  late bool isShowFlag;

  late bool isFlag;

  late bool isBottomNavigationBar;

  late bool isLabelError;

  @override
  void initState() {
    isBottomNavigationBar = widget.isBottomNavigationBar ?? false;
    _controller = widget.controller ?? TextEditingController();
    obscureText = widget.obscureText;

    isShowFlag = widget.isShowFlag;
    isFlag = widget.isFlag;
    isLabelError = widget.isLabelError;
    inputTextFontSize = widget.inputTextStyleFont;
    var heightLine = inputTextFontSize > 18 ? 20 : 16;
    inputTextStyleActive = ThemeGenerator().bodyCopy_14.copyWith(
        color: Colors.white,
        height: inputTextFontSize / heightLine,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w700,
        fontSize: inputTextFontSize);
    inputTextStyleOnRest = ThemeGenerator().bodyCopy_14.copyWith(
        color: Color.fromRGBO(51, 69, 30, 0.2),
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

    inputTextHintErrorStyle = ThemeGenerator().bodyCopy_12.copyWith(
        color: Color.fromRGBO(51, 69, 30, 0.2),
        height: inputTextFontSize / heightLine,
        letterSpacing: 0.5,
        fontWeight: FontWeight.bold,
        fontSize: 13.0);

    if (widget.keyboardType == TextInputType.number) {
      _focus.addListener(() async {
        var hasFocus = _focus.hasFocus;
        if (hasFocus) {
          NumericKeyboardOverlay.showOverlay(context,
              isBottomNavigationBar: isBottomNavigationBar);
          if (widget.onFocusCallback != null) {
            widget.onFocusCallback!();
          }
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
      .copyWith(color: Color.fromRGBO(36, 53, 102, 0.2), height: 1.5);

  /// floatingLabel textStyle when user completed edit and focus in not on text field
  TextStyle floatingLabelStyleOnRest = ThemeGenerator()
      .bodyCopy_14
      .copyWith(color: Color.fromRGBO(51, 69, 30, 0.2), height: 1.5);

  /// floatingLabel textStyle of error state
  TextStyle floatingLabelStyleActiveError = ThemeGenerator()
      .bodyCopy_12
      .copyWith(color: Color.fromRGBO(224, 60, 49, 0.2), height: 1.5);

  ///floatingLabel textStyle for card Activation Account Setting Page
  TextStyle floatingLabelStyleActiveCASP =
      ThemeGenerator().bodyCopy_12.copyWith(color: Colors.white, height: 1.5);

  TextStyle floatingLabelStyleOnRestCASP =
      ThemeGenerator().bodyCopy_14.copyWith(color: Colors.white, height: 1.5);

  ///floatinglabel textStyle for card Activation
  TextStyle floatingLabelStyleActiveCA = ThemeGenerator()
      .bodyCopy_12
      .copyWith(color: Color.fromRGBO(51, 69, 30, 0.2), height: 1.5);

  TextStyle floatingLabelStyleError = ThemeGenerator()
      .bodyCopy_12
      .copyWith(color: Color.fromRGBO(224, 60, 49, 0.2), height: 1.5);

  /// function that return text style based on conditions
  TextStyle getFloatingStyle() {
    if (isLabelError) {
      if (widget.errorMsg.isNotEmpty) {
        return floatingLabelStyleError;
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
    if (isFlag) {
      if (_focus.hasFocus && _controller.value.text.isEmpty) {
        return floatingLabelStyleActiveCA;
      }
    }
    if (isFlag) {
      if (_controller.value.text.isNotEmpty) {
        return floatingLabelStyleActiveCA;
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
    if (isLabelError) {
      if (widget.errorMsg.isNotEmpty) {
        return Alignment.topLeft;
      }
    }
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

  /// function that return icon color
  Color getIconColor() {
    if (isShowFlag) {
      return Colors.white;
    }
    if (_focus.hasFocus) {
      return Colors.white;
    }
    return Color.fromRGBO(36, 53, 102, 0.2);
  }

  /// function that returns border line color inbetween text field
  Color getUnderlineColor() {
    if (isShowFlag) {
      return Colors.white;
    }
    return Color.fromRGBO(51, 69, 30, 0.2);
  }

  /// function that manage password visibility based on user interaction
  void changeTextVisibility() {
    if (obscureText) {
      obscureText = false;
    } else {
      obscureText = true;
    }
    setState(() {});
  }

  InputDecoration getHintText() {
    if (isLabelError) {
      return InputDecoration(
        hintText:
            widget.errorMsg.isNotEmpty ? '${widget.floatingLabelText} ' : '',
        hintStyle: inputTextHintErrorStyle,
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.only(left: 10.w),
      );
    }
    return InputDecoration(
      border: InputBorder.none,
      isDense: true,
      contentPadding: EdgeInsets.only(left: 10.w),
    );
  }

  /// Password visibility toggle icons widget
  // Widget visibilityIcon() {
  //   return widget.obscureText
  //       ? Semantics(
  //           label: obscureText
  //               ? AccessibleText.loginShowPassword
  //               : AccessibleText.loginHidePassword,
  //           child: IconButton(
  //             key: const Key('visibilityIconKey'),
  //             onPressed: changeTextVisibility,
  //             padding: const EdgeInsets.all(2),
  //             icon: SizedBox(
  //               height: 17.w,
  //               width: 21.h,
  //               child: CacheImageBuilder(
  //                 imagePath: obscureText
  //                     ? AssetCatlog.loginPageIconHide
  //                     : AssetCatlog.iconShow,
  //                 boxFit: BoxFit.contain,
  //                 color: getIconColor(),
  //               ),
  //               // Image.asset(
  //               //   obscureText ? AssetCatlog.loginPageIconHide : AssetCatlog.iconShow,
  //               //   color: getIconColor(),
  //               //   fit: BoxFit.contain,
  //               // ),
  //             ),
  //           ),
  //         )
  //       : const SizedBox();
  // }

  /// tooltip icon widget
  Widget toolTipActionButton() {
    return widget.hasToolTip
        ? Semantics(
            label: widget.toolTipSemanticLabel ?? 'Tool Tip',
            child: IconButton(
              key: widget.toolTipKey ?? const Key('onToolTip12'),
              onPressed: () {
                widget.onToolTipTap!();
              },
              padding: const EdgeInsets.all(0),
              icon: SizedBox(
                width: 17.w,
                height: 17.h,
                // child: CacheImageBuilder(
                //   imagePath: AssetCatlog.editfieldWithIconHelpIcon,
                //   boxFit: BoxFit.contain,
                //   color: getIconColor(),
                // )
                // Image.asset(
                //   AssetCatlog.editfieldWithIconHelpIcon,
                //   fit: BoxFit.contain,
                //   color: getIconColor(),
                // ),
              ),
            ),
          )
        : const SizedBox();
  }

  /// action button widget
  Widget actionButton() {
    return Semantics(
      label: widget.actionButtonSemanticLabel ?? 'action button',
      child: SizedBox(
        width: 21.w,
        height: 17.h,
        child: IconButton(
          key: widget.actionButtonKey ?? const Key('actionButton'),
          padding: const EdgeInsets.all(0),
          onPressed: () {
            widget.onActionButtonTap!();
          },
          icon: CacheImageBuilder(
            imagePath: widget.actionButtonImage!,
            boxFit: BoxFit.contain,
            color: getIconColor(),
          ),
          // Image.asset(
          //   widget.actionButtonImage!,
          //   fit: BoxFit.contain,
          //   color: getIconColor(),
          // ),
        ),
      ),
    );
  }

  /// function that decide visibility between action and password visibility toggle widget
  // Widget getFirstIcon() {
  //   if (widget.obscureText && widget.hasActionButton) {
  //     if (_controller.text.isEmpty) {
  //       return actionButton();
  //     }
  //     return visibilityIcon();
  //   }
  //   if (widget.obscureText) {
  //     return visibilityIcon();
  //   }

  //   if (widget.hasActionButton) {
  //     return actionButton();
  //   }
  //   return const SizedBox();
  // }

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
                  /// lebel text
                  ExcludeSemantics(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20, bottom: 12.5.h, top: 0),
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
                      padding: const EdgeInsets.only(
                        left: 20,
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
                            textField: true,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: ExcludeSemantics(
                                          child: TextField(
                                            key: widget.textKey ??
                                                const Key('edittext_icons'),
                                            scrollPadding: widget
                                                        .scrollPadding !=
                                                    null
                                                ? EdgeInsets.only(
                                                    bottom:
                                                        widget.scrollPadding ??
                                                            100)
                                                : const EdgeInsets.all(20),
                                            textInputAction:
                                                widget.textInputAction,
                                            enableSuggestions:
                                                widget.enableSuggestions,
                                            autocorrect: widget.autocorrect,
                                            inputFormatters:
                                                widget.inputFormatters,
                                            obscureText: obscureText,
                                            enableInteractiveSelection: widget
                                                .enableInteractiveSelection,
                                            cursorColor: Colors.white,
                                            style: getInputTextStyle(),
                                            focusNode: _focus,
                                            controller: _controller,
                                            keyboardType: widget.keyboardType,
                                            toolbarOptions: ToolbarOptions(
                                                copy: widget
                                                    .enableInteractiveSelection,
                                                cut: widget
                                                    .enableInteractiveSelection,
                                                paste: widget
                                                    .enableInteractiveSelection,
                                                selectAll: widget
                                                    .enableInteractiveSelection),
                                            autofillHints: widget.autofillHints,
                                            //autovalidateMode: AutovalidateMode.disabled,
                                            decoration: getHintText(),
                                            onChanged: (value) {
                                              widget.onChange(value);
                                            },
                                            onSubmitted: (value) {
                                              widget.onSubmit(value);
                                            },
                                            onTap: () {
                                              if (widget.onTap != null) {
                                                widget.onTap!();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    //   children: [
                                    //     Padding(
                                    //       padding: EdgeInsets.only(
                                    //         right: _focus.hasFocus ? 10.w : 0,
                                    //       ),
                                    //       child: getFirstIcon(),
                                    //     ),
                                    //     toolTipActionButton(),
                                    //   ],
                                    // )
                                  ],
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

            /// error msg widget
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
