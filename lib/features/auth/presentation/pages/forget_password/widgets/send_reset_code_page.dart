import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/helper/app_validator.dart';
import 'package:flower_app/core/widgets/custom_text_form_field.dart';
import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_cubit.dart';
import 'package:flower_app/features/auth/presentation/cubit/forget_password/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendResetCodePage extends StatefulWidget {
  final void Function()? onPressed;
  final TextEditingController emailController;
  final GlobalKey<FormState>? formKey;

  const SendResetCodePage({
    super.key,
    this.onPressed,
    required this.emailController,
    this.formKey,
  });

  @override
  State<SendResetCodePage> createState() => _SendResetCodePageState();
}

class _SendResetCodePageState extends State<SendResetCodePage> {
  late Cubit<ForgetPasswordState> cubit;

  @override
  void initState() {
    cubit = context.read<ForgetPasswordCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Form(
      key: widget.formKey,
      child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
        builder: (context, state) {
          return Column(
            children: [
              context.h(40),
              Text(
                "enterEmail".tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              context.h(16),
              Text(
                'enterEmailDescription'.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              context.h(32),
              CustomTextFormField(
                labelText: "enterEmail".tr(),
                hintText: 'email'.tr(),
                controller: widget.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => AppValidator.validateEmail(value),
              ),
              context.h(48),
              state.isLoading == true
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: widget.onPressed,
                      child: Text('continueText'.tr()),
                    ),
            ],
          );
        },
      ),
    ),
  );
}
