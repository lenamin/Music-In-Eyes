<div align="center">

![App_MockupPage_forReadMe](https://user-images.githubusercontent.com/99120199/188602061-f49edeb2-a116-4c2e-85f3-95844418e9e7.png)

<img width="100" alt="image" src="https://user-images.githubusercontent.com/99120199/188601934-07606634-de5d-4207-ad2a-e12a5e9dff4e.png">

**청각장애인의 뮤직 플레이어**<br>
**Music in Eyes**<br>
앱스토어: https://apps.apple.com/kr/app/music-in-eyes/id1643402478
</div>

<br><br>
## App statement
주변의 음악을 감지해 happy, relax, sad, angry 네 가지 분위기를 다양한 이미지를 통해 감상할 수 있는 앱 

### 개발기간
2022.8.26 ~ 2022.9.4

## Screen Shot  
|Main View|ImageView|
|---|---|
|<img width="200" alt="image" src="https://user-images.githubusercontent.com/99120199/188604115-2f3b45ed-0b09-4d99-ba76-4df7e9414dac.png">|<img width="200" alt="image" src="https://user-images.githubusercontent.com/99120199/188604187-5a91fdab-f45e-4e40-86f0-4553ee7cd788.png">|

## 주요 기능 
- 헤드폰 버튼을 누르면 주변의 소리 감지 시작 
- 음악인 경우 4가지 분위기를 감지 (happy, relax, sad, angry) 
- 감지한 분위기를 키워드로 unsplash에서 검색하여 해당 이미지를 호출 
- 음악이 나오지 않는 경우, 다시 안내문구로 변경
- 분위기가 계속 동일하더라도, 같은 키워드의 random 이미지로 실시간 변경 기능 

### 추후 추가 예정 기능
- SoundWave 라이브러리를 이용한 Sound Visualizer 

## Skills & Tech Stack
- UIKit (Codebase)
- CreateML > Sound Classification 
- Sound Analysis
- Unsplash API
- Github
- Figma

## Git Commit Message
|Type|Subject|
|---|---|
|**[FEAT]**|새로운 기능 구현|
|**[ADD]**|새로운 뷰, 부수적인 코드 추가, 에셋, 파일, 데이터 등 추가|
|**[FIX]**|버그 수정|
|**[CHORE]**|내부 파일 수정, 세팅 파일 수정|
|**[DEL]**|코드 삭제|
|**[DOCS]**|리드미 등 문서 수정|
|**[MOD]**|Storyboard 파일만 수정하는 경우|
|**[REFACTOR]**|코드 리팩토링, 전면 수정이 있을 때| 
|**[MERGE]**|머지|
|**[MOVE/RENAME]**|프로젝트 내 파일, 코드 이동 및 이름 변경|
