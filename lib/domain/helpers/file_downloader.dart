import 'package:common_models/common_models.dart';

abstract class FileDownloader {
  Future<Either<FetchFailure, Unit>> download(String url);
}
