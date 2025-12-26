import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/constants/text_strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DoNotHaveAnAccountAndSignUpWidget extends StatelessWidget {
  final void Function()? onTapSignUp;
  const DoNotHaveAnAccountAndSignUpWidget({super.key, this.onTapSignUp});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: IAppText.doNotHaveAnAccount,
            style: context.theme.titleMedium,
          ),
          const WidgetSpan(child: SizedBox(width: 6)),
          TextSpan(
            text: IAppText.signUp,
            recognizer: TapGestureRecognizer()..onTap = onTapSignUp,
            style: context.theme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              decoration: TextDecoration.underline,
              decorationColor: context.colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
