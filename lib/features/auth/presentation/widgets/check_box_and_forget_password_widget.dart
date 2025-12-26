import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/constants/text_strings.dart';
import 'package:flower_app/core/helper/local_keys.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/app_local_storage.dart';

class CheckBoxAndForgetPasswordWidget extends StatefulWidget {
  final void Function()? onTapForgetPassword;
  const CheckBoxAndForgetPasswordWidget({super.key, this.onTapForgetPassword});

  @override
  State<CheckBoxAndForgetPasswordWidget> createState() =>
      _CheckBoxAndForgetPasswordWidgetState();
}

class _CheckBoxAndForgetPasswordWidgetState
    extends State<CheckBoxAndForgetPasswordWidget> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: isCheck,
              onChanged: (value) async {
                setState(() {
                  isCheck = value!;
                });
                await AppLocalStorage.setData(LocalKeys.rememberMe, isCheck);
              },
            ),
            Text(IAppText.rememberMe, style: context.theme.bodyMedium),
          ],
        ),
        GestureDetector(
          onTap: widget.onTapForgetPassword,
          child: Text(
            IAppText.forgetPassword,
            style: context.theme.bodySmall?.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
