import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';
import '../main.dart';
import '../utils/app_theme.dart';

class ReusableWidgets {
  static Widget createSVG({required String assetName, double height = 64.0, double width = 64.0, double? size}) {
    return SvgPicture.asset(
      assetName,
      height: size ?? height,
      width: size ?? width,
    );
  }

  static AppBar buildAppBar(String titleStr, BuildContext ctx, {List<Widget> actions = const []}) {
    return AppBar(
      actions: actions,
      toolbarHeight: 60,
      elevation: 0,
      title: Text(titleStr, style: AppTheme.getInstance().textStyle18(color: AppTheme.whiteColor)),
    );
  }

  void createBottomSheet({required BuildContext context, dynamic content}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return content;
      },
    );
  }

  static Widget formFieldContainer({required Widget body}) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.borderGreyColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: body,
      ),
    );
  }

  static Widget createTextField(Function onTap,
      {required BehaviorSubject<String> textStream, required String leadingIconPath, bool isDropDown = false}) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: ReusableWidgets.formFieldContainer(
        body: Row(
          children: [
            ReusableWidgets.createSVG(assetName: leadingIconPath, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: StreamBuilder<String>(
                stream: textStream,
                builder: (context, snapshot) {
                  return Visibility(
                    visible: textStream.value.contains('Select') || textStream.value.contains('No'),
                    replacement: Container(
                      child: ReusableWidgets.buildDefaultTextWidget(
                        textStream.value,
                        textStyle: AppTheme.getInstance().textStyle16Light(),
                      ),
                    ),
                    child: Container(
                      child: ReusableWidgets.buildDefaultTextWidget(
                        textStream.value,
                        textStyle: AppTheme.getInstance().textStyle16Light(color: AppTheme.greyTextColor),
                      ),
                    ),
                  );
                },
              ),
            ),
            Visibility(visible: isDropDown, child: const Icon(Icons.arrow_drop_down, color: Colors.blue)),
          ],
        ),
      ),
    );
  }

  static Widget bottomNavBar(Function() function) {
    return SizedBox(
      height: 64,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                appTextButton(() => navigatorKey.currentState?.pop()),
                const SizedBox(width: 16),
                appTextButton(function,
                    title: 'Save', backGroundColor: AppTheme.darkBlueColor, titleColor: AppTheme.whiteColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget appTextButton(Function fn,
      {String title = 'Cancel',
      Color backGroundColor = AppTheme.lightBlueColor,
      Color titleColor = AppTheme.darkBlueColor}) {
    return TextButton(
      onPressed: () => fn.call(),
      style: TextButton.styleFrom(backgroundColor: backGroundColor),
      child: ReusableWidgets.buildDefaultTextWidget(
        title,
        textStyle: AppTheme.getInstance().textStyle14(color: titleColor),
      ),
    );
  }

  static Widget buildDefaultTextWidget(String text,
      {TextStyle? textStyle, TextAlign textAlign = TextAlign.start, int? maxLine}) {
    return Text(
      text,
      textAlign: textAlign,
      style: textStyle,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }

  static Widget buildRoundedButton(void Function()? func, {Icon? icon, Color? color}) {
    return GestureDetector(
      onTap: () {
        if (func != null) {
          func.call();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppTheme.blackColor.withOpacity(0.10),
                blurRadius: 3,
                spreadRadius: 2,
                offset: const Offset(1, 1),
              )
            ],
            borderRadius: BorderRadius.circular(30),
            color: color,
            border: Border.all(color: AppTheme.blackColor.withOpacity(0.5))),
        height: 48,
        width: 78,
        child: Center(child: icon),
      ),
    );
  }
}
