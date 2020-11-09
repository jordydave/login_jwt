import 'package:flutter/material.dart';
import 'package:login/app.dart';
import 'package:login/injector/injector.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    runApp(App());
  } catch (error, stacktrace) {
    print('$error & $stacktrace');
  }
}
