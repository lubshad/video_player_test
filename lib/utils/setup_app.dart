import 'package:basic_template/basic_template.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import '../di.dart';


setupApp() async {
  // setUrlStrategy(PathUrlStrategy());
  setupLogger();
  DependencyInjection.inject();
  
}
