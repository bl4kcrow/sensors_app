import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionsProvider =
    NotifierProvider<PermissionsNotifier, PermisssionsState>(
      PermissionsNotifier.new,
    );

class PermissionsNotifier extends Notifier<PermisssionsState> {
  @override
  PermisssionsState build() {
    return PermisssionsState();
  }

  Future<void> _checkPermissionState(PermissionStatus status) async {
    if (status.isPermanentlyDenied) {
      await openSettingsScreen();
    }
  }

  Future<void> checkPermissions() async {
    final permissionsArray = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);

    state = state.copyWith(
      camera: permissionsArray[0],
      photos: permissionsArray[1],
      sensors: permissionsArray[2],
      location: permissionsArray[3],
      locationAlways: permissionsArray[4],
      locationWhenInUse: permissionsArray[5],
    );
  }

  Future<void> openSettingsScreen() async {
    await openAppSettings();
  }

  Future<void> requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);

    _checkPermissionState(status);
  }

  Future<void> requestPhotosAccess() async {
    final status = await Permission.photos.request();
    state = state.copyWith(photos: status);

    _checkPermissionState(status);
  }

  Future<void> requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensors: status);

    _checkPermissionState(status);
  }

  Future<void> requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);

    _checkPermissionState(status);
  }
}

class PermisssionsState {
  PermisssionsState({
    this.camera = PermissionStatus.denied,
    this.photos = PermissionStatus.denied,
    this.sensors = PermissionStatus.denied,
    this.location = PermissionStatus.denied,
    this.locationAlways = PermissionStatus.denied,
    this.locationWhenInUse = PermissionStatus.denied,
  });

  final PermissionStatus camera;
  final PermissionStatus photos;
  final PermissionStatus sensors;
  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  get cameraGranted {
    return camera == PermissionStatus.granted;
  }

  get photosGranted {
    return photos == PermissionStatus.granted;
  }

  get sensorsGranted {
    return sensors == PermissionStatus.granted;
  }

  get locationGranted {
    return location == PermissionStatus.granted;
  }

  get locationWhenInUseGranted {
    return locationAlways == PermissionStatus.granted;
  }

  get locationAlwaysGranted {
    return locationWhenInUse == PermissionStatus.granted;
  }

  PermisssionsState copyWith({
    PermissionStatus? camera,
    PermissionStatus? photos,
    PermissionStatus? sensors,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) => PermisssionsState(
    camera: camera ?? this.camera,
    photos: photos ?? this.photos,
    sensors: sensors ?? this.sensors,
    location: location ?? this.location,
    locationAlways: locationAlways ?? this.locationAlways,
    locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
  );
}
