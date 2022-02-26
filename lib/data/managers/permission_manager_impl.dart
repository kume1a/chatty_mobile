import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/managers/permission_manager.dart';

@LazySingleton(as: PermissionManager)
class PermissionManagerImpl implements PermissionManager {
  @override
  Future<bool> isStoragePermissionGranted() async => Permission.storage.isGranted;

  @override
  Future<PermissionStatus> requestStoragePermission() async => Permission.storage.request();

  @override
  Future<bool> isCameraPermissionGranted() async => Permission.camera.isGranted;

  @override
  Future<PermissionStatus> requestCameraPermission() async => Permission.camera.request();

  @override
  Future<bool> isMicrophonePermissionGranted() => Permission.microphone.isGranted;

  @override
  Future<PermissionStatus> requestMicrophonePermission() => Permission.microphone.request();

  @override
  Future<void> openPermissionSettings() => openAppSettings();
}
