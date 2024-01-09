import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
// import 'package:kakao_map_plugin/kakao_map_plugin.dart';

const String kakaoMapKey = '650299c65a76b3e51646e390bc975691';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/env/.env');

  // AuthRepository.initialize(appKey: dotenv.env['APP_KEY'] ?? '');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapState();
}

class _MapState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: KakaoMapView(
        width: 400,
        height: 400,
        kakaoMapKey: kakaoMapKey,
        lat: 33.450701,
        lng: 126.570667,
        showMapTypeControl: true,
        showZoomControl: true,
        markerImageURL: 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
        onTapMarker: (message) {
          //event callback when the marker is tapped
        }
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Title'),
  //     ),
  //     body: KakaoMap(
  //       onMapTap: (latLng) {
  //         // ignore: avoid_print
  //         print(latLng);
  //       },
  //     ),
  //   );
  // }
}