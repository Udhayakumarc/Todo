//------------------------------------------------------------------------------
//  File:          numeric_keyboard_overlay.dart
//  Author(s):     Bread Financial
//  Date:          27 July 2022
//
//  Descriptions:  This is Bread Financial Mobile App
//  that allows customers to service their credit account
//
//  © 2022 Bread Financial
//------------------------------------------------------------------------------

import 'package:flutter/cupertino.dart';

class NumericKeyboardOverlay {
  static OverlayEntry? _overlayEntry;

  static void showOverlay(BuildContext context,
      {isBottomNavigationBar = false}) {
    if (_overlayEntry != null) {
      return;
    }

    var overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(builder: (context) {
      double bottomPosition;
      if (isBottomNavigationBar) {
        bottomPosition = MediaQuery.of(context).viewInsets.bottom - 50;
      } else {
        bottomPosition = MediaQuery.of(context).viewInsets.bottom;
      }
      return bottomPosition == 0
          ? const SizedBox()
          : Positioned(
              bottom: bottomPosition,
              right: 0.0,
              left: 0.0,
              child: const DoneButtonWidget());
    });

    if (overlayState != null) {
      overlayState.insert(_overlayEntry!);
    }
  }

  static void removeOverlay() {
    /// throwing null exception, which was causing unit test to fail
    if (_overlayEntry?.mounted ?? false) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }
}

class DoneButtonWidget extends StatelessWidget {
  const DoneButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: CupertinoColors.extraLightBackgroundGray,
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: CupertinoButton(
              key: const Key('tapToClose'),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: const Text('Done',
                  style: TextStyle(
                      color: CupertinoColors.activeBlue,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ));
  }
}
