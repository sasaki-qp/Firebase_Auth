// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:sns_auth_demo/storage/storage.dart';

class SuccessScreen extends ConsumerWidget {
  final GetIt getit = GetIt.I;
  late Storage storage;
  @override
  build(BuildContext context, WidgetRef ref) {
    storage = getit.get<Storage>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth Type: ${storage.readAuthType()}'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'uid: ${storage.readUid()}',
            ),
          )
        ],
      ),
    );
  }
}
