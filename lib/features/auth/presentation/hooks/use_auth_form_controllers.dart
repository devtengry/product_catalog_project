import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AuthFormControllers {
  final TextEditingController? name;
  final TextEditingController email;
  final TextEditingController password;
  final GlobalKey<FormState> formKey;

  AuthFormControllers({
    this.name,
    required this.email,
    required this.password,
    required this.formKey,
  });
}

AuthFormControllers useAuthFormControllers({bool includeName = false}) {
  final name = includeName ? useTextEditingController() : null;
  final email = useTextEditingController();
  final password = useTextEditingController();
  final formKey = useMemoized(() => GlobalKey<FormState>());

  return AuthFormControllers(
    name: name,
    email: email,
    password: password,
    formKey: formKey,
  );
}
