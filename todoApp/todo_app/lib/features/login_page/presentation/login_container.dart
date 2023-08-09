import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/common_widgets/button.dart';
import 'package:todo_app/core/locale/local_constant.dart';
import 'package:todo_app/core/textform_field_widget/edit_field_with_icon.dart';
import 'package:todo_app/core/textform_field_widget/edit_field_without_icon.dart';
import 'package:todo_app/features/login_page/login_screen_notifier.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({Key? key}) : super(key: key);

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeUserName = FocusNode();
  @override
  void dispose() {
    _focusNodeUserName.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<LoginScreenNotifier>(builder: (context, data, _) {
      return AnimatedPositioned(
          duration: const Duration(milliseconds: 350),
          top: 284.h,
          left: 0,
          right: 0,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              child: SizedBox(
                // height: 330,
                width: size.width,
                child:

                    ///Replacing Material to Container as TextField inline error message not focused in accessibility.
                    Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.h),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutofillGroup(
                        onDisposeAction: AutofillContextAction.commit,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),

                            /// username input widget
                            EditTextFieldWithoutIcon(
                              accessibilityFocusNode: _focusNodeUserName,
                              componentName: '',
                              controller: data.usernameController,
                              onChange: data.onUserInPutChange,
                              onSubmit: data.onUsernameSubmitted,
                              errorMsg: data.usernameError,
                              keyboardType: TextInputType.text,
                              decoration:
                                  const InputDecoration(labelText: 'Username'),
                              autofillHints: const [AutofillHints.username],
                              textInputAction: TextInputAction.next,
                              floatingLabelText:
                                  LocalStrings.loginContainerUserName,
                              inputTextStyleFont: 20.0,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-zA-Z0-9.]')),
                              ],
                            ),

                            SizedBox(
                              height: 5.h,
                            ),

                            /// password input widget
                            EditTextFieldWithIcons(
                              accessibilityFocusNode: _focusNodePassword,
                              textFieldSemanticLabel: '',
                              actionButtonSemanticLabel: '',
                              controller: data.passController,
                              errorMsg: data.passwordError,
                              onChange: data.onPasswordInputChange,
                              onSubmit: data.onPasswordSubmitted,
                              keyboardType: TextInputType.visiblePassword,
                              decoration:
                                  const InputDecoration(labelText: 'Password'),
                              autofillHints: const [AutofillHints.password],
                              textInputAction: TextInputAction.done,
                              floatingLabelText:
                                  LocalStrings.loginContainerPassword,
                              hasToolTip: false,
                              obscureText: true,
                              inputTextStyleFont: 20.0,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(64),
                              ],
                              hasActionButton: false,
                              onActionButtonTap: () {},
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        ),
                      ),

                      /// CTA log in
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20.h, right: 20.h, bottom: 20.h, top: 10.h),
                        child: Button(
                          title: LocalStrings.login,
                          width: 320.w,
                          buttonKey: const Key('loginContainerKey'),
                          onPressed: () {},
                          buttonWidgetStyle: ButtonWidgetStyle.primary,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
