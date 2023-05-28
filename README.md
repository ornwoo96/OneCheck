# OneCheck

안녕하세요.

원체크를 지원한 김동우입니다.

<br/>

제가 선택한 과제는

> 과제1) Geofence 를 임의로 1개 등록하고 (본인 집 근처), 그 바운더리에 들어 오거나 나거거나 할때 이벤트를 받아서 alert를 띄우는 (간단)앱으로 구성. 단, 앱이 kill 되어도 가능 하도록 개발 바랍니다. 

이였습니다.
<br/>

<img src = "https://github.com/ornwoo96/OneCheck/assets/73861795/a084294a-21fd-4473-9fdc-c03082f4649f" width="150" height="150"/>

다음 과제앱에 대한 설명을 하겠습니다.

<br/>

## 💡기능 설명
### 1. 임의로 1개 등록하는 것이지만 편의상 사용자의 터치로 Geofence를 등록하도록 하였습니다.

https://github.com/ornwoo96/OneCheck/assets/73861795/e84cc0a1-1824-4f7b-9d1b-ae3a138d681b


<br/>
<br/>


### 2. 여러개의 Overlay를 등록할 수 있으며 만들어져 있는 Overlay를 클릭하면 삭제할 수 도 있습니다.


https://github.com/ornwoo96/OneCheck/assets/73861795/c928f527-defb-4e89-8adb-9ef1d33e9675



<br/>
<br/>


### 3. 바운더리 안에 들어오게 되면 알림이 뜨게되고, 그안에 있는 동안 1번만 알림이 불리게 되어 있습니다.

https://github.com/ornwoo96/OneCheck/assets/73861795/0441c055-59e0-4607-8c51-07bf1434745f


<br/>
<br/>


### 4. 백그라운드 상태에서도 알림을 받을 수 있게 해놓았습니다.

https://github.com/ornwoo96/OneCheck/assets/73861795/58201927-12ac-49d2-a9f2-364bc8b46804


<br/>
<br/>


## 🛠️구조 설명

![무제](https://github.com/ornwoo96/OneCheck/assets/73861795/3aa61ba5-beb3-4460-abb3-569bd18f35aa)

>### MVVM
- 비즈니스 로직을 보호하기 위한 클린 아키텍처 MVVM을 적용하였습니다.
- 클린 아키텍처는 비즈니스 로직을 보호하기 위한 아키텍처입니다. (원체크에서는 비즈니스 로직 및 iOS 네이티브한 기능을 깊게 다룬다고 들었습니다. 그런 경우에 매우 적합한 구조입니다.)
- view는 UI를 생성 및 업데이트만 하고 그 외에 로직들은 ViewModel이 관리하도록 하였습니다.
- 비동기 처리는 Combine, async/await 으로 하였습니다. (async/await은 네트워크 통신에만 쓰이는데 네트워크 통신을 구현할 일이 없어서 구현하지 않았습니다.)
- Action/Event 패턴을 통해 뷰에서 일어나는 일들을 관리하였습니다.

<br/>
<br/>

### 이상 읽어주셔서 감사합니다. 🙇🏻‍♂️🙇🏻‍♂️🙇🏻‍♂️




