# 팀프로젝트 시작시

- Projects / bookshop에 Todo에서 Add item 클릭후 해야할일을 적고 엔터를 눌러서 이슈를 생성하고

- 생성된 이슈에 마우스를 올리면 점 세개가 뜨는데 클릭 후 Convert to issue 클릭해서 bookshop을 선택한다

- 다시 이슈에 마우스를 올려서 점 세개를 누르고 Open in new tab 클릭 우측 Development 탭에 Create a branch 클릭 

- Branch 이름은 Feature-\<기능\>과 같이 설정 후 Change branch source 클릭 해서

- 해당 브랜치 소스를 develop으로 변경하여 생성

- 모든 브랜치를 다 가져오고 싶을때

- $ git clone url복사해서넣고

- 그리고 꼭 클론해온 디렉토리에 들어가서 뒤에 나올 명령어를 사용하자. 

- $ git branch -r 을 입력하면 가져온 프로젝트의 모든 브랜치를 볼수 있다.

- $ git checkout -b \<branch\> 브랜치로 이동하는 명령어이다

- 항상 작업은 feature-브랜치에서 push까지 해야한다.

- 만약 내작업이 끝나지 않았어도 develop브랜치에 변경사항이 있으면 하던 작업을 임시저장하고

- $ git stash 임시저장 명령어

- $ git checkout develop 으로 이동한 뒤

- $ git pull origin develop 으로 변경사항을 받아오고

- $ git checkout \<branch\> 로 이동해서

- $ git merge develop 으로 내가 작업하고있는 브랜치에 devolop브랜치를 병합시키고

- $ git stash pop 을 사용해서 임시저장한 작업을 가져온다.





  


 # 브랜치 정의

- master : 제품으로 유저들이 사용하는 브랜치

- develop : 공통으로 쓰는 개발을 위한 브랜치

- feature : 기능을 개발하는 개인 브랜치




# 브랜치 사용규칙

- 하나의 기능은 하나의 커밋으로 합니다.

- 자신의 PullRequest는 스스로 merge 합니다.

- develop 브랜치에 변경사항이 생길경우 pull 합니다.

- 꼭 리뷰를 받습니다.



# 커밋 메세지 규칙

- 유의미한 코드 단위 / 기능 완료 시에 커밋

- 커밋 메세지 작성시 첫 줄엔 제목 작성, 추가 설명이 필요할 경우 줄을 바꿔서 작성

커밋 메세지 첫 시작은 

- Add : 파일 추가 / 기능 및 함수 추가

- Delete : 파일 삭제 / 기능 및 함수 삭제

- Fix : 버그 수정, 에러 해결 등

- Refactor : 기존 파일 개선 / 보안

- Move : 파일 위치 or 이름 변경 등 실제 코드내용이 변경없을때


# 개발시 유의해야 할점

- 공통적으로 사용될 style.css 파일을 변경하지 않는다.

- 각 페이지에 추가로 들어가야할 css는 css파일을 만들어서 사용하거나 각 jsp파일에 style태그를 사용한다.

- 개발할때 같은 페이지를 여러명이서 작업하지 않도록 조심한다.

- develop 브랜치에 변동이 있을시 항상 pull 먼저 한다.

- github에 projects를 활용해서 해야 할 일을 확인 또는 추가 한다.


# 상황별 해야할 일


- Projects / teamProject에 Todo에서 자신이 해야 할 일을 확인 후

- Open in new tab 클릭 우측 Development 탭에 Create a branch 클릭 

- Branch 이름은 Feature-기능과 같이 설정 후 Change branch source 클릭 해서

- 해당 브랜치 소스를 develop으로 변경하여 생성


# git에 익숙하지 않은 우리들을 위해 작성한 git command 및 조작 방법

- 새로운 feature 개발: 최신 develop의 변경사항을 local에 반영시킨 후, 새로운 브랜치를 생성하여 작업한다.

- $ git checkout develop : develop 브랜치로 변경

- $ git checkout -b \<feature branch 명\> 명령어를 통해  브랜치가 없다면 브랜치 생성 후 브랜치로 이동한다.

- $ git remote update : 원격 저장소의 모든 브랜치에 대한 최신 이력 정보를 확인하는 명령어입니다.

- $ git fetch --all : 모든 원격 저장소 변경사항을 로컬 저장소에 FETCH_HEAD브랜치로 가져온다. 이 명령어 이후 merge 까지 해야 변경된 내용이 합쳐진다.

- $ git fetch origin develop : 원격 저장소의 develop 브랜치의 변경사항을 로컬 저장소에 FETCH_HEAD브랜치로 가져온다. 꼭 이후에  merge 하자.

- $ git merge origin develop : develop 브랜치에 병합한다.

- $ git pull origin develop : 원격 저장소 develop 브랜치의 최신 변경사항을 로컬로 가져온다.

- $ git push origin develop : 로컬 저장소 develop 브랜치의 최신 변경사항을 원격으로로 업데이트 한다.  

- $ git stash : 원격 저장소에 변경사항이 있을시 현재 하고있는 작업을 임시 저장하는 명령어

- $ git stash apply : 임시저장했던 작업을 불러오는 명령

# 코드작성

- $ git add \<file 명\>: git add . 를 통해 모든 파일을 staging area에 추가할 수 있다. 

- $ git commit -m "커밋메세지" 

- $ git push origin \<feature branch\>: origin(원격 저장소)의 feature branch로 로컬 변경 내역을 push

github에서 develop branch <- feature branch 방향으로  Pull Request 진행

리뷰가 종료되고 모두 Approve 된다면 Merge한다. 


# 자주 사용할만한 깃 명령어

git clone [URL]:  원격 저장소의 코드를 로컬로 복제합니다.

git pull: 원격 저장소에서 최신 변경 내용을 가져와 로컬 저장소를 업데이트합니다.

git pull origin [브랜치명] : 그 브랜치로 원격저장소에서 로컬저장소로 변경데이터를 업데이트 합니다.

git add [파일]: 변경된 파일을 스테이징 영역에 추가합니다.

git commit -m "메시지":  스테이징 영역의 변경 내용을 커밋하여 로컬 저장소에 저장합니다.

git push: 로컬 저장소의 변경 내용을 원격 저장소로 푸시하여 업데이트합니다.

git push origin [브랜치명] : 로컬 저장소의 특정 브랜치의 변경 내용을 원격 저장소로 업데이트 합니다.

git branch: 브랜치 목록을 보여줍니다.

git checkout -b [브랜치명]: 다른 브랜치로 전환합니다.

git merge [브랜치명]: 다른 브랜치를 현재 브랜치로 병합합니다.

git remote -v: 현재 연결된 원격 저장소 목록과 URL을 보여줍니다.

git diff: 작업 디렉토리의 변경 내용을 확인합니다.

git status: 작업 디렉토리의 상태를 확인합니다.

git log: 커밋 로그를 확인합니다.

git log --oneline: 간략한 커밋 로그를 확인합니다.

git diff [브랜치1] [브랜치2]: 두 브랜치 간의 차이를 확인합니다.

git checkout -b [새로운_브랜치명]: 새로운 브랜치를 만들고 해당 브랜치로 전환합니다.

git tag [태그명]: 커밋에 태그를 추가합니다.

git tag -a [태그명] -m "메시지": 주석을 포함한 태그를 추가합니다.

git fetch: 원격 저장소의 변경 내용을 가져오지만 로컬에는 반영하지 않습니다.

git stash: 현재 변경 내용을 임시로 보관합니다.
( 작업도중에 develop 브랜치가 변경될시 작업했던 파일을 이 명령어로 임시 보관하고 pull을 사용해서 먼저 develop브랜치를 최신화 한다음 다시 작업을 이어가야합니다.)

git stash list : 저장한 stash 목록

git stash apply [이름]: 이름 다시 가져오기 ([이름]을 붙이지 않으면 가장 최신의 stash)

git stash apply --index : staged상태까지 복원한다.

git stash drop [이름] : stash 삭제

git stash pop : apply + drop

git stash show -p | git apply -R : 실수로 잘못 stash 적용한걸 되돌리고 싶을때

git clean -f:  작업 디렉토리에서 추적되지 않는 파일을 삭제합니다.

rm -r .git : git init 제거



  
