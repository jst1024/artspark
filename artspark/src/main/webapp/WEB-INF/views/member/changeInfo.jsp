<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 정보 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-container {
            max-width: 500px;
            margin: 10vh auto;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .left-buttons {
            display: flex;
            gap: 10px; /* 버튼 사이의 간격 */
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <div class="container">
        <div class="form-container">
            <h2 class="mb-4">회원 정보 수정</h2>
            <form>
                <div class="mb-3">
                    <label for="userId" class="form-label">아이디</label>
                    <input type="text" class="form-control" id="userId" readonly>
                </div>
                <div class="mb-3">
                    <label for="userName" class="form-label">이름</label>
                    <input type="text" class="form-control" id="userName" placeholder="이름을 입력해주세요">
                </div>
                <div class="mb-3">
                    <label for="userEmail" class="form-label">닉네임</label>
                    <input type="email" class="form-control" id="userNickName" placeholder="닉네임을 입력해주세요">
                </div>
                <div class="mb-3">
                    <label for="userEmail" class="form-label">이메일</label>
                    <input type="email" class="form-control" id="userEmail" placeholder="이메일을 입력해주세요">
                </div>
                <div class="mb-3">
                    <label for="userPassword" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="userPassword" placeholder="비밀번호를 입력해주세요">
                </div>
                <div class="mb-3">
                    <label class="form-label">성별</label>
                    <div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" id="male" value="male">
                            <label class="form-check-label" for="male">남성</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="gender" id="female" value="female">
                            <label class="form-check-label" for="female">여성</label>
                        </div>
                    </div>
                </div>
                <div class="button-group">
                    <div class="left-buttons">
                        <button type="button" class="btn btn-secondary">회원탈퇴</button>
                        <button type="button" class="btn btn-info">판매자로 변경</button>
                    </div>
                    <button type="submit" class="btn btn-primary">저장</button>
                </div>
            </form>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>