import 'package:basic_template/basic_template.dart';
import 'package:video_player_test/presentation/screens/downloads_listing/downloads_listing_controller.dart';
import 'package:video_player_test/presentation/screens/login_screen/auth_controller.dart';
import 'package:video_player_test/presentation/screens/settings_screen/settings_controller.dart';

import 'data/core/api_constants.dart';
import 'data/data_sources/remote_data_source.dart';
import 'data/repositories/data_repository_implementation.dart';
import 'domain/repositories/data_repository.dart';

class DependencyInjection {
  static inject() {
    Get.lazyPut(() => ApiClient(Client(), baseUrl: ApiConstants.baseUrl));
    Get.lazyPut<RemoteDataSource>(
        () => RemoteDataSourceImplementation(Get.find()));
    Get.lazyPut<DataRepository>(() => DataRepositoryImplementation(Get.find()));
    Get.lazyPut(() => DownloadsListingController());
    Get.lazyPut(() => SettingsController());
    Get.lazyPut(() => AuthController());
  }
}
