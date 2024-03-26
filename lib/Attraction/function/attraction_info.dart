import 'package:countries_world_map/data/maps/countries/south_korea.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class attractInfo extends GetxController {
  RxBool _openCheck = false.obs; // 힌트 오픈 했는지
  RxBool get openCheck => _openCheck;
  RxInt allCountry = 0.obs; // 명소 전체 수
  RxInt nowCountry = 0.obs; // 현재 획득한 전체 명소 수
  RxDouble percentValue = 0.0.obs; // 명소 전체 수집률

  // 지역별 리스트
  List<String> country = <String>[
    '서울',
    '부산',
    '대구',
    '인천',
    '광주',
    '대전',
    '울산',
    '세종',
    '경기',
    '강원',
    '충청북도',
    '충청남도',
    '전라북도',
    '전라남도',
    '경상북도',
    '경상남도',
    '제주',
  ];

  // 지역별 명소 개수
  List<int> countryCount = <int>[
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
  ];

  // 지역별 획득한 명소 개수
  List<int> countryGet = <int>[
    0,
    0,
    0,
    1,
    1,
    2,
    2,
    3,
    4,
    5,
    7,
    8,
    10,
    11,
    12,
    13,
    17,
  ];

  // attractInfos.countryGet.where((element) => element != 0).length

  // 전체 수집률 초기화
  Future<void> ResetValue() async {
    percentValue.value = 0.0;
  }

  // 전체 수집률 업데이트
  Future<void> updateHint() async {
    _openCheck.value = !_openCheck.value;
    print("힌트가 ${openCheck}되었습니다.");
  }

  Future<void> updateCountry() async {
    allCountry.value = countryCount.reduce((value, element) => value + element); // 전체 명소 수
    nowCountry.value = countryGet.reduce((value, element) => value + element); // 현재 획득 명소 수
    percentValue.value = (nowCountry.value / allCountry.value); // 명소 획득 평균 값

    print("전체 수집률 : ${percentValue.value}%  ${nowCountry.value}/${allCountry.value}");
  }

  // 지도 색상 업데이트
  SMapSouthKoreaColors Mapcolor() {
  int seoul = country.indexOf('서울');
  int busan = country.indexOf('부산');
  int daegu = country.indexOf('대구');
  int incheon = country.indexOf('인천');
  int gwangju = country.indexOf('광주');
  int daejeon = country.indexOf('대전');
  int ulsan = country.indexOf('울산');
  int sejong = country.indexOf('세종');
  int gyeonggi = country.indexOf('경기');
  int gangwon = country.indexOf('강원');
  int chungcheongNorth = country.indexOf('충청북도');
  int chungcheongSouth = country.indexOf('충청남도');
  int jeollaNorth = country.indexOf('전라북도');
  int jeollaSouth = country.indexOf('전라남도');
  int gyeongsangNorth = country.indexOf('경상북도');
  int gyeongsangSouth = country.indexOf('경상남도');
  int jeju = country.indexOf('제주');

  print("지도 색상 업데이트");

  return SMapSouthKoreaColors(
    kr11: changeMapColor(seoul), // 서울
    kr26: changeMapColor(busan), // 부산
    kr27: changeMapColor(daegu), // 대구
    kr28: changeMapColor(incheon), // 인천
    kr29: changeMapColor(gwangju), // 광주
    kr30: changeMapColor(daejeon), // 대전
    kr31: changeMapColor(ulsan), // 울산
    kr41: changeMapColor(gyeonggi), // 경기
    kr42: changeMapColor(gangwon), // 강원
    kr43: changeMapColor(chungcheongNorth), // 충청북도
    kr44: changeMapColor(chungcheongSouth), // 충청남도
    kr45: changeMapColor(jeollaNorth), // 전라북도
    kr46: changeMapColor(jeollaSouth), // 전라남도
    kr47: changeMapColor(gyeongsangNorth), // 경상북도
    kr48: changeMapColor(gyeongsangSouth), // 경상남도
    kr49: changeMapColor(jeju), // 제주
    kr50: changeMapColor(sejong), // 세종
  );
}

// 진행률 별 색상 강도 조절
Color? changeMapColor(int index) {
  int percent = (countryGet[index] / countryCount[index] * 100).toInt();
  Color? colorValue;

  if (percent < 10) {
    colorValue = Colors.white;
  } else if (10 <= percent && percent < 20) {
    colorValue = Colors.green[100];
  } else if (20 <= percent && percent < 30) {
    colorValue = Colors.green[100];
  } else if (30 <= percent && percent < 40) {
    colorValue = Colors.green[200];
  } else if (40 <= percent && percent < 50) {
    colorValue = Colors.green[200];
  } else if (50 <= percent && percent < 60) {
    colorValue = Colors.green[300];
  } else if (60 <= percent && percent < 70) {
    colorValue = Colors.green[400];
  } else if (70 <= percent && percent < 80) {
    colorValue = Colors.green[500];
  } else if (80 <= percent && percent < 90) {
    colorValue = Colors.green[500];
  } else if (90 <= percent && percent < 100) {
    colorValue = Colors.green[600];
  } else if (percent == 100) {
    colorValue = Colors.green[800];
  } else {
    colorValue = Colors.white;
  }

  return colorValue;
}

Color? attractChageColor(int percent) {
  Color? colorValue;

  if (percent < 10) {
    colorValue = Colors.grey;
  } else if (10 <= percent && percent < 20) {
    colorValue = Colors.red[700];
  } else if (20 <= percent && percent < 30) {
    colorValue = Colors.red[500];
  } else if (30 <= percent && percent < 40) {
    colorValue = Colors.orange[700];
  } else if (40 <= percent && percent < 50) {
    colorValue = Colors.orange[500];
  } else if (50 <= percent && percent < 60) {
    colorValue = Colors.blue[300];
  } else if (60 <= percent && percent < 70) {
    colorValue = Colors.blue[500];
  } else if (70 <= percent && percent < 80) {
    colorValue = Colors.blue[700];
  } else if (80 <= percent && percent < 90) {
    colorValue = Colors.green[300];
  } else if (90 <= percent && percent < 100) {
    colorValue = Colors.green[500];
  } else if (percent == 100) {
    colorValue = Colors.green;
  } else {
    colorValue = Colors.purple;
  }

  return colorValue;
}

}
