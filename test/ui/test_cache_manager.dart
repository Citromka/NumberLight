import 'package:flutter_cache_manager/flutter_cache_manager.dart' as FCM;
import 'package:mockito/mockito.dart';
import 'package:file/local.dart';

class MockCacheManager extends Mock implements FCM.DefaultCacheManager {
  static const fileSystem = LocalFileSystem();

  @override
  Stream<FCM.FileResponse> getImageFile(
      String url, {
        String? key,
        Map<String, String>? headers,
        bool withProgress = false,
        int? maxHeight,
        int? maxWidth,
      }) async* {
    yield FCM.FileInfo(
      fileSystem
          .file('./test/assets/images.jpeg'), // Return your image file path
      FCM.FileSource.Cache,
      DateTime(2050),
      url,
    );
  }
}