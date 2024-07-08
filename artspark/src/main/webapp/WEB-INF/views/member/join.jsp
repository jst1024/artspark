<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 5vh;
            padding-bottom: 5vh;
        }
        .form-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 40px;
        }
        .btn-group-full {
            display: flex;
            gap: 10px;
        }
        .btn-group-full .btn {
            flex: 1;
        }
        .container-fluid {
            margin-top: 5vh; /* 컨테이너를 아래로 내리기 위해 추가 */
        }
    </style>
</head>
<body>
    <jsp:include page="common/menubar.jsp"/>
    <div class="container-fluid">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                <div class="form-container">
                    <div class="btn-group-full mb-4">
                        <button class="btn btn-outline-primary">일반회원 가입하기</button>
                        <button class="btn btn-outline-primary">판매자 가입하기</button>
                    </div>
                    <p class="text-center mb-4">만 14세 이상만 가능하고 서비스를 이용하실 수 있습니다.</p>
                    <h4 class="text-center mb-4">일반회원 / 판매자 가입하기</h4>
                    <form>
                        <div class="mb-3">
                            <label for="userId" class="form-label">아이디</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="userId" placeholder="내용을 입력해주세요">
                                <button class="btn btn-dark" type="button">중복 확인</button>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="userPassword" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="userPassword" placeholder="내용을 입력해주세요">
                        </div>
                        <div class="mb-3">
                            <label for="userPasswordConfirm" class="form-label">비밀번호 확인</label>
                            <input type="password" class="form-control" id="userPasswordConfirm" placeholder="내용을 입력해주세요">
                        </div>
                        <div class="mb-3">
                            <label for="userName" class="form-label">이름</label>
                            <input type="text" class="form-control" id="userName" placeholder="이름을 입력해주세요">
                        </div>
                        <div class="mb-3">
                            <label for="userNickname" class="form-label">닉네임</label>
                            <input type="text" class="form-control" id="userNickname" placeholder="닉네임을 입력해주세요">
                        </div>
                        <div class="mb-3">
                            <label for="userEmail" class="form-label">이메일</label>
                            <input type="email" class="form-control" id="userEmail" placeholder="내용을 입력해주세요">
                        </div>
                        <div class="mb-4">
                            <label class="form-label d-block">성별</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="male" value="male">
                                <label class="form-check-label" for="male">남성</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="female" value="female">
                                <label class="form-check-label" for="female">여성</label>
                            </div>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="agreeTerms">
                            <label class="form-check-label" for="agreeTerms">이용 약관에 동의합니다.</label>
                        </div>
                        <div class="mb-4 form-check">
                            <input type="checkbox" class="form-check-input" id="agreePrivacy">
                            <label class="form-check-label" for="agreePrivacy">개인정보 수집,이용에 관한 사항에 동의합니다.</label>
                        </div>
                        <button type="submit" class="btn btn-dark w-100">회원가입</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>