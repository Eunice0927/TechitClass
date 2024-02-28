# TechitClass
멋쟁이 사자처럼 iOS App School 3기 수업 코드

# Repository summary
|Repository|Date|Framework|Detail|
|:-:|:-:|:-:|:-|
|[ListNavDemo](/ListNavDemo)|2023.11.03|SwiftUI|- 이미지와 json 파일을 추가하고 리스트에 load|
|[TableViewStoryDemo](/TableViewStoryDemo)|2023.11.16|UIKit|- 리스트 삭제, 순서 바꾸기<br/>- 뷰가 나타나면 데이터를 다시 불러옴<br/>- 사용자 정의 셀을 추가하고 데이터 출력<br/>- 테이블 뷰에 데이터 소스와 이미지 파일 추가<br/>- 테이블 뷰 클릭시 상세보기 화면 연결<br/>- 네비게이션 컨트롤러 제목 크기 변경<br/>- UISearchController를 사용해 검색창 표시, 검색어에 따라 실시간으로 결과 표시<br/>- 검색 결과 클릭시 상세 화면 이동<br/>- UIKit에서 SwiftUI 사용하기|
|[FileExampleDemo](/FileExampleDemo)|2023.11.20 - 2023.11.21|UIKit|- mac의 특정 경로에 파일이 존재하는지 확인<br/>- 파일에 텍스트필드에 작성한 내용을 저장<br/>- 저장 성공시 Alert<br/>- 현재 폴더의 파일명과 크기를 출력<br/>- 폴더를 생성하고 특정 확장자의 파일만 복제<br/>- 특정 파일의 텍스트를 역순으로 바꾸어 저장<br/>- 숫자의 합계와 평균을 구하는 코드<br/>- 단어의 빈도수를 계산하고 저장하는 코드|
|[DocumentBrowserDemo](/DocumentBrowserDemo)|2023.11.21|UIKit|- "파일"앱에 새 파일을 추가, 수정할 수 있다.<br/>- 새 파일 추가할 때 탬플릿 적용|
|[DatabaseDemo](/DatabaseDemp)|2023.11.22|UIKit|- SQLite에 데이터 저장, 검색<br/>- 리팩토링|
|[CoreDataDemo](/CoreDataDemo)|2023.11.22 - 2023.11.23|UIKit|- CoreData에 저장, 삭제|
|[CameraDemo](/CameraDemo)|2023.11.24|UIKit|- 카메라 사용<br/>- 이미지 선택(ImagePickerController)<br/>- 동영상 재상(AVPlayer)|
|[UITestingDemo](/UITestingDemo)|2023.12.18|UIKit|- 모델(ObservableObject)을 사용해 유저 로그인 데이터 저장<br/>- 로그인 폼 제작<br/>- 로그인 실패 테스트<br/>- 로그인 성공 후 ContentView 업데이트|
|[DrawDemo](/DrawDemo)|2023.12.19 - 2023.12.21|SwiftUI|- 선으로 도형과 곡선 그리기<br/>- 애니메이션과 상태 바인딩<br/>- 자동으로 애니메이션 실행<br/>- 전환 효과<br/>- 색상 그라데이트 애니메이션<br/>- multi-step 애니메이션<br/>- 키 프레임을 사용한 애니메이션<br/>- symbolEffect 애니메이션<br/>- 탭바에서 탭을 전환할 때 애니메이션|
|[GestureDemo](/GestureDemo)|2023.12.21|SwiftUI|- 터치하여 이미지 크기 변경<br/>- 여러 제스처를 결합: simultaneously, sequenced<br/>- drag, longPress|
|[ProgressViewDemo](/ProgressViewDemo)|2023.12.21 - 2023.12.26|SwiftUI|- 다양한 프로그레스 뷰<br/>- 프로그레스 뷰 스타일을 만들고 적용<br/>- label과 매개변수 사용<br/>- 강조 색상과 그림자 사용<br/>- 색상과 높이 적용 및 진행률 라벨 표시|
|[ChartDemo](/ChartDemo)|2023.12.22 - 2023.12.26|SwiftUI|- 여러가지 스타일의 차트 그리기<br/>- 데이터를 불러와 차트 그리기<br/>- 차트 축 custom<br/>- 원형 차트를 그리고 영역을 선택하면 애니메이션 적용|
|[CoreDataDemo2](/CoreDataDemo2)|2023.12.27|SwiftUI|- 데이터 추가, 삭제, 검색<br/>- MVVM|
|[ImageDocDemo](/ImageDocDemo)|2023.12.27|SwiftUI|- 이미지를 선택하고 필터 적용(CIImage)|
|[SwiftDataDemo](/SwiftDataDemo)|2023.12.28|SwiftUI|- 데이터 모델 생성<br/>- 데이터 모델을 스키마에 추가<br/>- 항목 추가, 삭제<br/>- 미리보기용 모델 컨테이너 제작|
|[WidgetCoreDataDemo](/WidgetCoreDataDemo)|2023.12.28|SwiftUI|- 위젯에서 코어데이터 연동<br/>- 코어데이터 변경 사항을 위젯에 바로 반영|
|[WidgetDemo](/WidgetDemo)|2023.12.28 - 2023.12.29|SwiftUI|- 위젯 익스텐션 추가하기<br/>- 날씨 목록을 생성하고 클릭하면 상세화면으로 연결<br/>- 위젯 데이터 추가<br/>- 위젯에서 앱 딥링크 사용<br/>- 위젯에서 보여지는 내용의 옵션 변경(도시 변경)|
|[FirebaseDemo](/FirebaseDemo)|2024.01.04|SwiftUI|- Firebase Realtime Database와 Cloud Firestore 시작<br/>- Cloud Firestore로 실시간 업데이트 가져오기 모델과 화면<br/>- Firebase의 listAll() 메서드를 사용하여 저장소의 모든 항목을 나열<br/>- 항목(Storage 파일) 삭제<br/>- FirebaseAuth 간단 로그인 확인<br/>- 로그아웃과 탈퇴 처리 확인<br/>- Firebase Auth signIn(가입) 사용자 추가<br/>- Firestore 위도,경도 저장하고 가져오기 샘플<br/>- Firestore를 이용한 채팅 예제 추가|
|[MapDemo](/MapDemo)|2024.01.02|SwiftUI|- MapKit으로 지도에 marker 추가<br/>- CoreLocation으로 현재 위치 가져오기|
|[ARDemo](/ARDemo)|2024.01.10|SwiftUI|- 텍스처에 사용될 그림 그리기 기능 추가<br/>- 3D 모델 추가하여 화면 구성<br/>- 탭하면 FocusEntity 위치에 3D 엔티티를 배치<br/>- 시선 추적과 얼굴과의 거리를 표시하는 예제|
|[ShortcutDemo](/ShortcutDemo)|2024.01.12|SwiftUI|- 시리로 단축어 작업 수행|
|[SpriteKitSwiftUIDemo](/SpriteKitSwiftUIDemo)|2024.01.18|SwiftUI|- 탭할 때마다 떨어지는 상자가 생성되고 부딪히는 물리 효과 추가|
|[NaverMapDemo](/NaverMapDemo)|2024.01.17|SwiftUI|- 사용자의 현재 위치를 나타내는 위치 오버레이 표시<br/>- CoreLocation을 이용한 현재 위치를 지속적으로 가져와서 지도에 표시하기<br/>- 정보 창(마커의 위 또는 지도의 특정 지점에 부가적인 정보를 나타내기 위한 오버레이) 추가<br/>- 이동경로 그리기(경로선 오버레이)|
|[CombineDemo](/CombineDemo)|2024.01.15 - 2024.01.16|SwiftUI|- Combine과 Publisher, Subscriber 소개<br/>- Operator, Subject, Cancellable 소개<br/>- 네트워크에 Combine 이용 예제를 위한 날씨 API 호출<br/>- API 호출 네트워크에 Combine 이용 예제 추가|

# How to use
- [레포지토리 내부의 한 개 폴더만 clone하고 싶을 경우](https://think-tech.tistory.com/22)
- [하나의 레포지토리에 여러 레포지토리 올리기](https://velog.io/@049494/%ED%95%98%EB%82%98%EC%9D%98-%EB%A6%AC%ED%8F%AC%EC%A7%80%ED%86%A0%EB%A6%AC%EC%97%90-%EC%97%AC%EB%9F%AC-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EC%98%AC%EB%A6%AC%EA%B8%B0)
