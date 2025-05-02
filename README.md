# 프로젝트 개요

# 학습 목표

# 주요 기능
### 텍스트 필드 포커스 효과
텍스트 필드를 선택하면 테두리 색상을 변경하는 시각적인 효과 제공  
<img src="https://github.com/user-attachments/assets/2c53c62b-c8c7-46c6-a58a-6c1737292462" style="width: 70%; height: auto;">

## 자동 포커스 기능
텍스트 필드가 비어있는 상태에서 버튼을 클릭하면 비어있는 필드로 이동  
![ezgif-726ecf402e94f6](https://github.com/user-attachments/assets/bc42f6c5-2695-47a0-8bb9-9f86284c808d)

### 텍스트 필드 흔들림 효과
입력값에 오류가 발생하면 텍스트 필드를 흔드는 효과를 통해 시각적인 피드백 제공  
![ezgif-71d1d6c472387d](https://github.com/user-attachments/assets/787c21ae-e993-4f61-8b0c-2ff4ee108481)

### 실시간 입력 검증
사용자가 입력할 떄 실시간으로 입력값을 검증하여 입력 유효성 안내  
![ezgif-75729bef9f2cd0](https://github.com/user-attachments/assets/9f3aee78-7f6c-4a9b-86fb-a0c403f2f86c)

### 로그인 화면 애니메이션
1. 아이디 입력 시 캐릭터의 시선이 사용자의 입력 위치를 따라 움직임
2. 비밀번호 입력 시 캐릭터가 눈을 가림
3. 비밀번호 표시 버튼을 클릭하면 캐릭터가 비밀번호를 살짝 엿봄
4. 로그인 성공/실패에 따라 캐릭터의 행동 변화  

![ezgif-73340b1b5c3982](https://github.com/user-attachments/assets/547631b2-6590-4999-a58d-9117dfdf94d5)

### 계정 기억하기 및 자동 로그인
앱 실행 시 계정 정보를 미리 입력하거나 자동으로 로그인  
![ezgif-7b23b1cef76ba9](https://github.com/user-attachments/assets/63c9fb9d-0713-4b77-94f4-c4a842ffb3e4)

### 로그아웃
로그아웃과 함께 계정 기억하기 및 자동 로그인 해제  
![ezgif-86e20f6ace9428](https://github.com/user-attachments/assets/7763407a-e48f-4dfa-8aec-0e98ea3be152)

### 현재 시간에 기반한 인사 메시지
아침, 오후, 저녁에 따라 다른 인사말 표시  
<img src="https://github.com/user-attachments/assets/4d0c5925-02ff-4c29-adf3-4bd0b7813e60" style="width: 70%; height: auto;">
<img src="https://github.com/user-attachments/assets/5f810c68-b6a4-4db0-9490-40041fc25a9a" style="width: 70%; height: auto;">
<img src="https://github.com/user-attachments/assets/a4d84444-4b31-4673-8b8d-fbf6fe5e0748" style="width: 70%; height: auto;">

### 킥보드 모델 및 배터리 상태 선택
원하는 킥보드 모델과 배터리 상태 선택 가능  
![ezgif-80ae6817c1a54b](https://github.com/user-attachments/assets/2bdb8f38-6209-4878-9a73-6b62c02fafbb)

### 킥보드 추가 애니메이션
킥보드를 추가하면 킥보드 이미지가 탭바의 지도 위치에 들어가는 듯한 효과  
![ezgif-824334f1a2b75b](https://github.com/user-attachments/assets/a35ab512-571d-4660-b9fa-2261e6ce5a6d)

### 킥보드 커스텀 마커
킥보드 위치를 시각적으로 표시하기 위해 마커에 킥보드 이미지를 사용  
![ezgif-8d1f1c097a00e0](https://github.com/user-attachments/assets/4117460c-d361-4b78-a2c1-92cd55d3ec7a)

### 커스텀 콜아웃을 통한 킥보드 예약
지도에 표시된 마커를 선택하면 콜아웃을 통해 킥보드 예약 가능  
![ezgif-822a8cc6b772a2](https://github.com/user-attachments/assets/1200cb64-d9f3-4f98-9111-560c78914a6a)

### 이용시간 실시간 확인
마이페이지를 통해 현재 예약중인 킥보드의 이용시간을 실시간으로 확인 가능  
![ezgif-82d9d4e8ae1002](https://github.com/user-attachments/assets/7b7d4fa0-7c72-41a2-a627-9ff747a53995)

### 킥보드 반납 시 현재 위치에 킥보드 마커 표시
킥보드가 반납되면 현재 위치에 킥보드를 다시 추가하여 다른 사용자가 이용 가능  
![ezgif-8e15082dfd6df5](https://github.com/user-attachments/assets/ef986922-fa6e-4685-90e2-7d3353a52137)

### 중복 예약 방지
이미 킥보드를 예약중인 상황일 때 예약 버튼을 비활성화  
![ezgif-8098f989c6b3bf](https://github.com/user-attachments/assets/4b800079-8587-4cfb-859d-e79aef4ba5d2)

### 이용 내역
킥보드를 이용한 내역(출발지/도착지, 이용 시간 등)을 컬렉션뷰로 구현  
![ezgif-80bef0d4715e80](https://github.com/user-attachments/assets/8f3f83d9-9119-4c26-aae1-7f0255d57b75)

### 현재 위치 찾기 버튼
지도를 이동했을 때 버튼을 통해 현재 위치로 이동  
![ezgif-8d7ff933c5a69a](https://github.com/user-attachments/assets/f273550a-b4e6-4c38-961c-75ff1d9a1c8f)

### 마커 토글 버튼
킥보드 이미지를 보여주거나 숨기는 토글 기능  
![ezgif-84d902e10d7d2d](https://github.com/user-attachments/assets/af0476f7-e188-4777-96db-37184b5de272)

### 마커 표시 범위 설정
현재 위치 기준 반경 1km 이내의 마커만 지도에 보여주도록 구현  
![ezgif-8550a989b6e3e8](https://github.com/user-attachments/assets/d27eda56-21d0-43ea-aa21-e9ad6c3ab5bf)

### 주소 검색
셀 개수가 적으면 셀 개수만큼 보이고, 셀 개수가 일정량 이상이면 스크롤이 되도록 구현  
![ezgif-883ad7a5ec3041](https://github.com/user-attachments/assets/262bcb7c-3c1c-4893-bf9d-9c8ecc741c5c)

# 사용 방법
`KickScooter/Application/AppAPIKeys.swift` 파일에 본인의 Kakao API 키를 넣고 빌드

# 역할
<table>
  <tr align="center">
    <td><a href="https://github.com/amazingDove367"><img width="100" src="https://github.com/amazingDove367.png" alt="amazingDove367"/><br/>amazingDove367</a></td>
    <td><a href="https://github.com/meowbutlerdev"><img width="100" src="https://github.com/meowbutlerdev.png" alt="meowbutlerdev"/><br/>meowbutlerdev</a></td>
    <td><a href="https://github.com/Sn8Ch0"><img width="100" src="https://github.com/Sn8Ch0.png" alt="Sn8Ch0"/><br/>Sn8Ch0</a></td>
  </tr>
  <tr>
    <td>역할</td>
    <td>역할</td>
    <td>역할</td>
  </tr>
</table>
