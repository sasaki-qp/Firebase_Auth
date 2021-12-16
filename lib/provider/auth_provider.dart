// ignore_for_file: constant_identifier_names

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:sns_auth_demo/helper/global_context.dart';
import 'package:sns_auth_demo/service/auth_service.dart';
import 'package:sns_auth_demo/storage/storage.dart';
import 'package:sns_auth_demo/view/screens/success_screen.dart';
import 'package:sns_auth_demo/view/widgets/dialog.dart';

enum AuthType {
  Google,
  GitHub,
  Twitter,
  Facebook,
}

final AutoDisposeStateNotifierProvider<AuthStateNotifier, AuthType?>
    authProvider =
    StateNotifierProvider.autoDispose<AuthStateNotifier, AuthType?>(
  (ref) => AuthStateNotifier(),
);

class AuthStateNotifier extends StateNotifier<AuthType?> {
  final GetIt getit = GetIt.I;
  late Storage storage;
  late AuthService authService;

  final List<Map<String, dynamic>> items = [
    {'title': 'Googleサインイン', 'authType': AuthType.Google},
    {'title': 'GitHubサインイン', 'authType': AuthType.GitHub},
    {'title': 'Twitterサインイン', 'authType': AuthType.Twitter},
    {'title': 'Facebookサインイン', 'authType': AuthType.Facebook},
  ];

  AuthStateNotifier() : super(null) {
    storage = getit.get<Storage>();
    authService = getit.get<AuthService>();
  }

  Future<void> filterSignIn({
    required AuthType authType,
  }) async {
    BotToast.showLoading();
    UserCredential? userCredential;
    switch (authType) {
      case AuthType.Google:
        userCredential = await authService.signInWithGoogle();
        break;

      case AuthType.GitHub:
        userCredential = await authService.signInWithGitHub();
        break;

      case AuthType.Twitter:
        userCredential = await authService.signInWithTwitter();
        break;

      case AuthType.Facebook:
        userCredential = await authService.signInWithFacebook();
        break;
    }

    if (userCredential == null) {
      await showBarrierAlert(
        title: 'SNS認証に失敗しました',
        content: 'もう一度やり直してください',
        buttonText: 'はい',
      );
    }

    storage.writeUid(uid: userCredential!.user!.uid);
    storage.writeAuthType(authType: authType);

    BotToast.closeAllLoading();

    Navigator.pushAndRemoveUntil(
      globalContext,
      MaterialPageRoute(
        builder: (_) => SuccessScreen(),
      ),
      (_) => false,
    );
  }
}
