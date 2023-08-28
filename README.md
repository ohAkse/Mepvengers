## 프로젝트 소개
프로젝트 인원 : 1인  

개발 기간 : 6월16일~7월3일 및 7월 14(무한스크롤링 관련 API 추가 수정) 및 아이콘추가(8월 23일)로 **총 21일 소요**  

만든 목적 : Swift / UIKit을 입문하면서 다양한 기능을 확인 및 구현하면서 이해도를 높이고자 진행하였으며, 평소 MVC/MVVM은 많이 사용하는 디자인패턴인 반면 MVP는 자료가 많이 없어 직접 구현하면서 경험하고자 본 프로젝트를 개발하였습니다.  

프로젝트 소개 : 본 프로젝트는 매운음식과 관련된 Contents(이미지, 블로그 글, 유튜브 영상 등)를 앱으로 조회 및 관리하는 프로그램으로써 처음 Swift를 접하면서 언어 및 GUI프레임워크(UIKit) 활용한 IOS 전반적인 앱의 흐름을 파악하고자 만든 앱입니다.  

프로젝트 구조는 Clean Architecture MVP 구조를 참고하였으며, 각 Layer에 속하는 기능들을 분리하고자 노력하였습니다.  


## 시연영상
1. 로그인 영상 - [SMTP](https://drive.google.com/file/d/1uUWimWbzT2hAxA-EKrmXWcTHci48VSnM/view?usp=drive_link)

2. 블로그 영상 - [Blog](https://drive.google.com/file/d/1ZDZatRelbRNYwKvnjk4q8bazHhoMFoE3/view?usp=drive_link)
   - 2-1. 블로그 검색 영상 -[Search](https://drive.google.com/file/d/1QWtG92Ti8MXP4JfMw5jNZmIGqRzbRFCa/view?usp=drive_link)

3. 유튜브 영상 - [Youtube](https://drive.google.com/file/d/1DLKz8rfS4Kpu3IqNwuqnHb9jWTdNoxaI/view?usp=drive_link)

4. Like(북마크) 영상 -[Bookmark(Like)](https://drive.google.com/file/d/1cx4hz9qbRO8vEFsm2-NkzCQL9piVK2EL/view?usp=drive_link)


*용량의 문제로 인해 링크로 대체합니다.

## 사용한 기술 스택 (Tech Stack)
개발언어 언어 : <img src="https://img.shields.io/badge/Swift-F26B00?style=for-the-badge&logo=Swift&logoColor=white">  

외부 라이브러리 : <img src="https://img.shields.io/badge/YoutubeiOSPlayerHelper-D6001C?style=for-the-badge&logo=Youtube&logoColor=white">
<img src="https://img.shields.io/badge/RealmSwift-F26B00?style=for-the-badge&logo=Realm&logoColor=white">
<img src="https://img.shields.io/badge/Alamofire-FF6C37?style=for-the-badge&logo=Framework7&logoColor=white">
<img src="https://img.shields.io/badge/SwiftSMTP-68B604?style=for-the-badge&logo=Swiggy&logoColor=white">
<img src="https://img.shields.io/badge/Tabman-3776AB?style=for-the-badge&logo=Swiper&logoColor=white">


## 프로젝트 구성  
![스크린샷 2023-08-28 오후 10 22 18](https://github.com/ohAkse/Mepvengers/assets/49290883/47c09a13-557e-40c6-99d3-0d290626ce67)  
[앱 아키텍쳐 다이어그램]
  
    
![스크린샷 2023-08-28 오후 6 40 43](https://github.com/ohAkse/Mepvengers/assets/49290883/26258c6a-6dea-409c-8659-ff4ad5cc025d)  
[개발 프로젝트구조]  


# View Lyaer, Domain Layer, Data Layer

**View Laye**r : 화면을 담당하는 View를 담당하는 Layer로써, 사용자에게 보여지는 화면인 View를 관리하게 되며, User Action이 일어 났을때 Domain Layer에 있는 해당 화면의 Presenter에게 데이터를 전달후 Presenter에서 데이터를 가공 및 처리하여 View에게 다시 데이터를 전달받습니다. 전달 받은 데이터를 토대로  View에서 화면을 처리합니다. 이 계층에는 View와 관련된 Custom Components 및 UIController/NavigationController Base를 관리합니다.

**Domain Layer** : 각 View에 해당하는 Presenter와 API의 Model 그리고 사용자가 UserAction을 했을때 API통신과 관련된 처리를 담당합니다. API 통신을 통해 얻은 결과를 토대로 View에게 알려주고 Data Layer에 있는 RemoteRepository클래스에게 스크롤링할때마다 새로운 페이지로 갱신될수 있게 pageNumber를 새롭게 요청하여 새로운 데이터를 갱신하게 하는 역할을 하여 View에게 전달하는 역할을합니다.

**Data Layer** : Rest API 통신을 통해 얻은 결과를 토대로 새로운 pageNumber를 갱신 및 Realm으로 저장(Like/Like 해제) 그리고 pagenumber를 저장(userdefaults)하는 역할을 합니다.


## 보완해야할점 및 느낀점

1)UI/UX : Autolayout 및 콜렉션뷰를 사용하여 출시되어 사용중인 App을 기준으로 참고하였지만 디자인측면에서 일관적이지 않고 리소스를 응용하지 못해 번잡하다는점을 깨달았습니다. "Simple is Best"라는 말처럼 다음 프로젝트 UI 구성은 심플하게 구성할 예정이며, UI의 일관성이 중요하다는 점을 깨달았습니다.

2)코드 리팩토링 : 처음 개발 당시 Swift와 UIKit에 대한 이해도가 부족한 상태로 결과만을 향해 만들다보니 코드적인 부분에서 부족한점을 많이 깨달았습니다.(변수 네이밍 컨벤션, 고차함수의 부재, 불명확한 함수이름, Custom UI Components의 불명확한 설계 등)  
다음 프로젝트에서는 이부분을 인지하고 Swift언어의 장점을 최대한 살리고자 하는 방향으로 설계 할 예정입니다.(옵셔널, 프로토콜 지향, 코드 컨벤션 등)

3)Generic한 타입의 잘못된 설계 : 핵심 기능 중 하나인 Kakao API와 Google API 통신과 UI를 Generic하게 설계를 하려고 했으나 개발을 하다보니 완성도가 높게 Generic한 타입으로 코드를 설계하지 못한걸 깨달았습니다.  
다음 프로젝트에서는 응용프로그램 개발 방식에서 사용했던 방식 외에 강력한 extension을 이용하여 코드의 가독성을 올리고자 설계하여 개발할 예정입니다.

4)강한참조 : 처음 프로젝트를 개발 당시 이론적인 ARC의 흐름은 알고 있었으나 기능 완료에만 Focus를 두어 강한참조를 방조하는 Weak에 대한 처리가 안돼있고 강한참조를 쉽게 확인할 수 있는 XCode의 기능을 늦게 깨달았습니다. 따라서 현재 메모리 관련하여 누수가 안일어날수 있게 처리하도록 하였습니다.  
(우측 링크에서 메모리 누수 관련하여 처리 하는 부분 확인 가능 : https://github.com/ohAkse/TodoList) 


## 향후 계획
본 프로젝트는 개발 당시 Swift 및 IOS UIKit에 대한 지식이 부족한 상태로 개발을 진행하다보니 전반적으로 코드 퀄리티나 완성도는 낮다고 생각합니다.  
하지만 현재(약 Swift/IOS 공부한지 2달이 지난 지금(8.28) IOS 개발 IDE인 Xcode도 익숙해지고, Swift와 UIKit의 흐름도를 어느정도 파악한 지금 댜음 프로젝트를 통해 느꼈었던 점을 보완하여 완성도가 있는 프로젝트를 만들고자 공부하고 있습니다.

목표 계획은 다음과 같습니다.  
1)MVVM 패턴  
2)RxSwift/Combine(RxSwift를 기반으로 공부 및 이해를 한후 익숙해지면 Combine으로 진행 예정입니다.)  
3)SwiftUI  
4)TCA  
5)Tuist  
