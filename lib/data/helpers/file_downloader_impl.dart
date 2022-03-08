import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:common_models/common_models.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/helpers/file_downloader.dart';
import '../../main.dart';

@LazySingleton(as: FileDownloader)
class FileDownloaderImpl implements FileDownloader {
  FileDownloaderImpl(
    this._dio,
  );

  final Dio _dio;

  @override
  Future<Either<FetchFailure, Unit>> download(String url) async {
    final String fileName = url.split(Platform.pathSeparator).lastOrNull ?? 'file.bin';
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String savePath = '${appDir.path}$fileName';

    try {
      final Response<dynamic> response = await _dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );
      final File file = File(savePath);
      final RandomAccessFile raf = file.openSync(mode: FileMode.write);
      if (response.data is! Uint8List) {
        return left(const FetchFailure.unknownError());
      }
      raf.writeFromSync(response.data! as Uint8List);
      await raf.close();
      return right(unit);
    } catch (e) {
      logger.e(e);
    }

    return left(const FetchFailure.unknownError());
  }
}
