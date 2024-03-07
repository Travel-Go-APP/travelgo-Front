import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travel_go/Home/ui/dialog_location.dart';

class LatLngController extends GetxController {
  double mylatitude = 0.0; // 위도
  double mylongitude = 0.0; // 경도

  // 네이버 지도 Default
  NCameraPosition maplatlng = const NCameraPosition(
    target: NLatLng(37.5667, 126.9784), //위치 값 (default : 서울시청)
    zoom: 16.5, // 카메라 확대
    bearing: 12, // 방위각
    tilt: 0, // 기울기
  );
  late NaverMapController mapController; //카카오맵 컨트롤러

  // 위치 권한 및 현 위치 가져오기
  Future<void> checkLocation(BuildContext context) async {
    final locationStatus = await Permission.location.status; // 위치 권한 상태 확인

    // 권한 거부일때
    if (locationStatus.isDenied) {
      if (context.mounted) {
        dialogLocation(context); // 위치 동의 화면
      }
    } else {
      print('위치 권한 확인 완료');
      getMap(); // 위치 추적 모드
    }
  }

  // 현재 위치 가져오기
  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium, // 위치 정확도 수치
      forceAndroidLocationManager: true,
    );
    mylatitude = position.latitude; // 위도
    mylongitude = position.longitude; // 경도
  }

  // 위치 추적 모드
  Future<void> getMap() async {
    NLocationOverlay locationOverlay =
        await mapController.getLocationOverlay(); // 현위치 오버레이
    // locationOverlay.setIcon(const NOverlayImage.fromAssetImage('assets/images/user.png'));
    locationOverlay.setIconSize(const Size.fromRadius(60)); // 아이콘 사이즈
    locationOverlay.setCircleOutlineColor(Colors.black); // 테두리 색상
    locationOverlay.setCircleOutlineWidth(2); // 테두리 굵기
    locationOverlay
        .setCircleColor(const Color.fromARGB(119, 114, 255, 111)); // 원 색상
    locationOverlay.setCircleRadius(60); // 원 크기
    await mapController
        .setLocationTrackingMode(NLocationTrackingMode.follow); // 위치 추적 모드
    await getLocation(); // 현재 위치 가져오기 (위경도)
    print("위치 추적 모드 : follow");
    print("위도 : ${mylatitude}, 경도 : ${mylongitude}");
  }

  // 현재는 사용되지 않는다.
  // Future<void> getLocation() async {
  //   final cameraUpdate = NCameraUpdate.scrollAndZoomTo(
  //     target: NLatLng(mylatitude, mylongitude),
  //     zoom: 12,
  //   );
  //   final markers = NMarker(id: "mylocation", position: NLatLng(mylatitude, mylongitude));
  //   mapController.updateCamera(cameraUpdate);
  //   mapController.addOverlay(markers);
  // }
}
