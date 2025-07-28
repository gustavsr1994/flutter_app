import 'package:flutter/material.dart';

class LoginEntity {
  bool statusObsecure;
  TextEditingController nameField;
  TextEditingController passwordField;
  LoginEntity(this.statusObsecure, this.nameField, this.passwordField);
}
