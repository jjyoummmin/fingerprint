๐ฅ19๋๋ 2ํ๊ธฐ sw๋ณด์ํ๋ก์ ํธ ์ง๋ฌธ ์ธ์ ๊ณผ์ 

๋ฉ์ธ ํ์ผ : **run.m** (ํน์ fingerprint_test.m)

### 1. ์ง๋ฌธ ์ด๋ฏธ์ง ์ถ์ถํ๊ณ  ์ฒ๋ฆฌํ๊ธฐ

![finger](https://user-images.githubusercontent.com/33231313/110630164-5dbd1280-81e8-11eb-9083-289818bd75e6.png)

- garbor filter & merge : **garborfilter.m** , **Mygabo.m**
- binarization : matlab ๋ด์ฅํจ์ im2bw ์ด์ฉ. ํ๋๊ฐ level ๋ณด๋ค ํฐ ํฝ์์ 1, ๊ทธ ์ธ์๋ 0์ผ๋ก ๋ฐ๊ฟ์ ์ด์งํ ํ๊ธฐ
- thinning : matlab ๋ด์ฅํจ์ bwmorph ์ด์ฉ. ๊ฐ์ฒด๊ฐ ์ ์ด ๋๋๋ก ๊ฐ๋๊ฒ ๋ง๋ค๊ธฐ

### 2. ์ด๋ฏธ์ง์์ minutiae ์ถ์ถํ๊ณ  ํ๋๋ฆฌ ๋ถ๋ถ minutiae ์ ๋ณด๋ ์ ๊ฑฐ

![minutiae](https://user-images.githubusercontent.com/33231313/110631447-dec8d980-81e9-11eb-83cc-7921d35094a2.PNG)

minutiae ์ข๋ฅ 2๊ฐ์ง : endpoint, bifurcation

- minutiae ์ถ์ถ : **minutiae_ext.m**, **addition.m**, **bifur_filter.m**
- ROI(๋ฐ๊นฅ๋ถ๋ถ ์ ๊ฑฐ) : **MYROI.m**, **ROIAPPLY.m**

### 3. ๊ฐ minutiae์ ๋ฐฉํฅ์ฑ ์ ๋ณด ์ถ๊ฐ

![png](https://user-images.githubusercontent.com/33231313/110633711-70d1e180-81ec-11eb-91be-35d22c70b1b6.png)

- **my_direction_t.m**

### 4. matching score ๊ณ์ฐํ๊ณ  ๊ฐ์ ์ฌ๋์ธ์ง ๋ค๋ฅธ ์ฌ๋์ธ์ง ๊ฒฐ๋ก  ๋ด๊ธฐ
- alignment : ๊ฐ๋๊ฐ ๋์๊ฐ๊ฑฐ๋ x์ถ, y์ถ ํํ์ด๋ ํ ์ด๋ฏธ์ง ๋ณํํ๊ธฐ. (๋ ์ด๋ฏธ์ง ๋น๊ตํ๊ธฐ ์ํ ์ ์ฒ๋ฆฌ ์์)  **alignment.m** , **compare.m**
- matching score ๊ณ์ฐ : **match.m**

