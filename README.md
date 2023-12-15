# FlutterForecast 앱 ⛅️

FlutterForecast는 날씨에 따라 배경 이미지가 동적으로 변경되며, 현재 온도와 날씨 설명을 표시하는 Flutter 기반의 모바일 앱입니다.

## 주요 기능

- 실시간으로 변하는 날씨에 따라 배경 이미지 업데이트
- 현재 위치의 온도 및 날씨 설명 표시


## 사용된 패키지
- [geolocator](https://pub.dev/packages/geolocator): 위치 정보 획득
- [http](https://pub.dev/packages/http): OpenWeatherMap API 호출
- [dotenv](https://pub.dev/packages/flutter_dotenv): 환경 변수 관리

## 설정

1. OpenWeatherMap API Key 획득(회원 가입 필요)
2. 프로젝트 루트 디렉터리에 `.env` 파일 생성
3. `.env. sample` 파일을 참고하여 api key 추가
   
## 사용법

1. 앱을 실행하면 현재 위치의 날씨 정보가 표시됩니다.
2. 앱에서 배경 이미지와 현재 날씨 정보를 확인하세요.

## 주의사항

- 안정적인 인터넷 연결이 필요합니다.
- 위치 권한을 허용해야 정확한 날씨 정보를 받아올 수 있습니다.


