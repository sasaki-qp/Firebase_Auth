// ignore_for_file: use_key_in_widget_constructors

import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_auth_demo/provider/auth_provider.dart';

class AuthScreen extends ConsumerWidget {
  late AuthStateNotifier notifier;
  @override
  build(BuildContext context, WidgetRef ref) {
    notifier = ref.watch(authProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SNS Sign In'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: notifier.items.map<Widget>(
            (elm) {
              return Column(
                children: [
                  const Gap(30),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () async {
                        await notifier.filterSignIn(
                          authType: elm['authType'],
                        );
                      },
                      child: Text(
                        elm['title'],
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
