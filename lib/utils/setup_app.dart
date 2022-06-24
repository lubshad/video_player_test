import 'package:basic_template/basic_template.dart';
import '../di.dart';


setupApp() async {
  // setUrlStrategy(PathUrlStrategy());
  setupLogger();
  DependencyInjection.inject();
  
}
