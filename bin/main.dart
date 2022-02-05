// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:chaotic_helper/init.dart';
import 'package:chaotic_helper/backend.dart';

Future<void> main() async {
  Chaotic.applicationName = "memory_game";
  
  
  await Chaotic.clear();
}
