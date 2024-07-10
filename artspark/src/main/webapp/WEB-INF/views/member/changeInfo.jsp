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
            <form action="" method="">
                <div class="mb-3">
                    <label for="userId" class="form-label">아이디</label>
                    <input type="text" class="form-control" id="memId" name="memId" readonly>
                </div>
                <div class="mb-3">
                    <label for="userEmail" class="form-label">닉네임</label>
                    <input type="email" class="form-control" id="memNickName" name="memNickname" >
                </div>
                <div class="mb-3">
                    <label for="userEmail" class="form-label">이메일</label>
                    <input type="email" class="form-control" id="memEmail" name="memEmail">
                </div>
                <div class="mb-3">
                    <label for="userPassword" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="memPwd" name="memPwd">
                </div>
                <div class="button-group">
                    <div class="left-buttons">
                        <button type="submit" class="btn btn-secondary">회원탈퇴</button>
                        <a class="btn btn-info" href="changeProduct">판매자로 변경</a>
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