# MovieSearchProject


## 🔥  앱소개

#### 네이버 영화검색 API를 활용해 영화를 검색하고 즐겨찾기 기능을 통해 찜한 영화들을 확인할 수 있는 프로젝트

* iOS 14.0
* Code-Based UI
* 가로모드 지원
* 다크모드 미지원

### 실행영상

| 검색 | 상세화면 | 즐겨찾기 |
|:---|:---:|:---:|
| ![Simulator Screen Recording - iPhone 8 - 2022-06-13 at 22 49 13](https://user-images.githubusercontent.com/88618825/173369082-2039140e-be0a-46e5-a98c-2e6374c78c15.gif) | ![Simulator Screen Recording - iPhone 8 - 2022-06-13 at 22 49 39](https://user-images.githubusercontent.com/88618825/173369092-951f284c-72b8-48f0-882d-cb6a37a9e13d.gif)| ![Simulator Screen Recording - iPhone 8 - 2022-06-13 at 22 52 34](https://user-images.githubusercontent.com/88618825/173369109-b80df972-6846-4ae6-859b-d154f30de5ae.gif) |

<br>

## 📅  개발기간

#### 22.06.07 ~ 22.06.13

<br>

## 📎  사용 라이브러리

* Snapkit

<br>

## 🤦 회고

해당 프로젝트를 다양한 라이브러리를 이용해서 리팩토링 해 볼 목적으로 초기 구현시에 최대한 외부 라이브러리 사용을 지양하는 방식으로 구현했다.

#### 1) DB

> 사용자가 Star 버튼을 누른 영화들을 모아서 볼 수 있는 즐겨찾기 기능을 위해서 `Realm` 과 `UserDefaults` 를 고민하다가 `UserDefaults` 를 이용해서 구현했다.
> 
> 현재 앱에서 즐겨찾기에 추가된 영화의 데이터를 수정하는 로직이 필요없고 추가하거나 삭제하는 로직만 필요하기 때문에 `HashMap`을 사용하는 딕셔너리 타입으로 UserDefaults를 구성하면 
> O(1)의 시간복잡도로 추가, 삭제로직을 구현할 수 있다고 생각해 `UserDefaults`를 이용해서 구현했다.

#### 2) Pagination

> Pagination 을 구현하면서 데이터를 로딩해서 TableView 를 Reload 를 완료하기 전에 Pagination이 한번 더 호출 되어서 사용자는 실제 스크롤을 한번만 내렸는데 
> 추가로 1page 가 아닌 2page가 추가되는 문제가 발생했다. isLoading 과 같은 Bool 변수를 이용해 데이터가 로딩중인 경우에 Pagination 관련 메서드가 호출되면 
> return 되도록 수정이 필요한 상태이다. `(수정 예정)`

#### 3) Image Cache

> 네트워크 통신을 통해서 이미지를 불러올 때 처음으로 `Kingfisher` 라이브러리를 사용하지 않고 직접 이전에 네트워크 통신을 통해 이미지를 불러온 적이 있다고 Cache 메모리에서 가져 올 수 있도록
> 구현했다. 현재 프로젝트에서는 이미지의 크기가 크지 않아서 성능차이가 별로 나지 않을것으로 예상했었는데 사용하지 않을때와 비교하면 성능차이를 체감할 수 있었던 것 같다.

***

이 프로젝트는 여기서 종료하지 않고 `RxSwift` 를 학습하면서 계속해서 리팩토링을 진행할 예정이다.

