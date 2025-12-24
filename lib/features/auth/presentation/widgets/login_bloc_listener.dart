import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginViewModel,LoginStates>(
      listener: (context, state) {
      if(state.login.isLoaded){
        Toast.showToast(context, state.login.data?.message??"");
        }else if(state.login.isError){
        Toast.showToast(context,state.login.errorMessage??"",isError: true);
       }
    },
    child: const SizedBox.shrink());
  }
}
