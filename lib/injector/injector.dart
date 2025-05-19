import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';

@InjectableInit(initializerName: "initialize")
Future<void> initializeDependencies() async => await GetIt.I.initialize();
