🐥19년도 2학기 sw보안프로젝트 지문 인식 과제

메인 파일 : **run.m** (혹은 fingerprint_test.m)

### 1. 지문 이미지 추출하고 처리하기

![finger](https://user-images.githubusercontent.com/33231313/110630164-5dbd1280-81e8-11eb-9083-289818bd75e6.png)

- garbor filter & merge : **garborfilter.m** , **Mygabo.m**
- binarization : matlab 내장함수 im2bw 이용. 휘도가 level 보다 큰 픽셀은 1, 그 외에는 0으로 바꿔서 이진화 하기
- thinning : matlab 내장함수 bwmorph 이용. 객체가 선이 되도록 가늘게 만들기

### 2. 이미지에서 minutiae 추출하고 테두리 부분 minutiae 정보는 제거

![minutiae](https://user-images.githubusercontent.com/33231313/110631447-dec8d980-81e9-11eb-83cc-7921d35094a2.PNG)

minutiae 종류 2가지 : endpoint, bifurcation

- minutiae 추출 : **minutiae_ext.m**, **addition.m**, **bifur_filter.m**
- ROI(바깥부분 제거) : **MYROI.m**, **ROIAPPLY.m**

### 3. 각 minutiae에 방향성 정보 추가

![png](https://user-images.githubusercontent.com/33231313/110633711-70d1e180-81ec-11eb-91be-35d22c70b1b6.png)

- **my_direction_t.m**

### 4. matching score 계산하고 같은 사람인지 다른 사람인지 결론 내기
- alignment : 각도가 돌아갔거나 x축, y축 평행이동 한 이미지 변환하기. (두 이미지 비교하기 위한 전처리 작업)  **alignment.m** , **compare.m**
- matching score 계산 : **match.m**

