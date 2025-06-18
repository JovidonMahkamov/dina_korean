import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'bloc_provider.dart';
import 'core/di/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final box = await Hive.openBox("authBox");
  await setup();

  runApp(
    ProviderScope(
      child: MyBlocProvider(
        child: MyApp(box: box),
      ),
    ),
  );
}
