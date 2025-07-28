import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_entity.dart';

class LoginControllerBloc extends Cubit<LoginEntity> {
  LoginControllerBloc() : super(LoginEntity(true, TextEditingController(), TextEditingController()));

  void actionHidePassword() => emit(LoginEntity(!state.statusObsecure, state.nameField, state.passwordField));
}