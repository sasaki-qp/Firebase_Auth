import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sns_auth_demo/helper/global_context.dart';
import 'package:sns_auth_demo/view/widgets/dialog.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        BotToast.closeAllLoading();
        throw showBarrierAlert(
          title: '同じメールアドレスですでに登録しているユーザーが存在します',
          content: 'もう一度やり直してください',
          buttonText: 'はい',
        );
      }
    } catch (err) {
      print("DEBUG: google auth error === $err");
      BotToast.closeAllLoading();
      return null;
    }
  }

  Future<UserCredential?> signInWithTwitter() async {
    try {
      final TwitterLogin twitterLogin = TwitterLogin(
        apiKey: dotenv.env['TW_APIKEY'].toString(),
        apiSecretKey: dotenv.env['TW_APISECRETKEY'].toString(),
        redirectURI: dotenv
            .env[Platform.isIOS ? 'TW_iOS_URL' : 'TW_Android_URL']
            .toString(),
      );
      final AuthResult result = await twitterLogin.loginV2();
      final OAuthCredential credential = TwitterAuthProvider.credential(
        accessToken: result.authToken!,
        secret: result.authTokenSecret!,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        BotToast.closeAllLoading();
        throw showBarrierAlert(
          title: '同じメールアドレスですでに登録しているユーザーが存在します',
          content: 'もう一度やり直してください',
          buttonText: 'はい',
        );
      }
    } catch (err) {
      print("DEBUG: twitter auth error === $err");
      BotToast.closeAllLoading();
      return null;
    }
  }

  Future<UserCredential?> signInWithGitHub() async {
    try {
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: dotenv.env['GitHub_APIKEY'].toString(),
        clientSecret: dotenv.env['GitHub_SECRET_KEY'].toString(),
        redirectUrl: dotenv.env['GitHub_URL'].toString(),
      );
      final GitHubSignInResult result =
          await gitHubSignIn.signIn(globalContext);

      final OAuthCredential githubAuthCredential =
          GithubAuthProvider.credential(result.token!);

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(githubAuthCredential);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        BotToast.closeAllLoading();
        throw showBarrierAlert(
          title: '同じメールアドレスですでに登録しているユーザーが存在します',
          content: 'もう一度やり直してください',
          buttonText: 'はい',
        );
      }
    } catch (err) {
      print("DEBUG: github auth error === $err");
      BotToast.closeAllLoading();
      return null;
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(
        loginResult.accessToken!.token,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        BotToast.closeAllLoading();
        throw showBarrierAlert(
          title: '同じメールアドレスですでに登録しているユーザーが存在します',
          content: 'もう一度やり直してください',
          buttonText: 'はい',
        );
      }
    } catch (err) {
      print("DEBUG: facebook auth error === $err");
      BotToast.closeAllLoading();
      return null;
    }
  }
}
