# 👩🏻‍💻 둘리의 개발일기

DAY 1

참고영상 :

[https://www.youtube.com/watch?v=YnP1VPnNM9c&list=PLKi37YIxs-7taJns3l65dDOKjgsN1upi9](https://www.youtube.com/watch?v=YnP1VPnNM9c&list=PLKi37YIxs-7taJns3l65dDOKjgsN1upi9)

### 기획서의 변동사항

소셜로그인부터 진행을 해야하는데, 구현한적이 있으므로 앱의 기본적인 틀을 먼저 잡기로했다.

### 진행사항

메인페이지의 로고, 검색바를 배치하였고, 아래 PagingKit 을 사용하여 탭을 나누도록 하였다.

네비게이션 컨트롤러와 탭바 컨트롤러를 이용해서 페이지를 큰 틀로 구성하였다.

앱 내 필요한 이미지 리소스들은 전부 따놓은 상태이다.

### 에러사항

PagingKit 을 이용해 탭을 구현중에 있는데, 원하는데로 커스텀 하는것에서 막혔다.

Cell이 총 세개로 화면의 젤 왼쪽, 중간, 젤 오른쪽 이렇게 배치되어야 하는데, 중앙 정렬된 채로 세개가 가운데 배치된다.

Focus 된 cell 의 색깔을 바꿔야하는데 어떻게 바꿔야할지 감이잡히지 않는다.
