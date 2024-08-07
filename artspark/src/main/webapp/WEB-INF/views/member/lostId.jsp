<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        .form-container {
            width: 100%;
            max-width: 400px;
            padding: 15px;
            margin-top: 50px;
        }
        .flex-grow-1 {
            flex-grow: 1;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <div class="container flex-grow-1">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="form-container mx-auto">
                    <h2 class="text-center mb-4">아이디 찾기</h2>
                    <form action="findId" method="post">
                        <div class="mb-3">
                            <label for="userNickname" class="form-label">닉네임</label>
                            <input type="text" class="form-control" id="memNickname" name="memNickname" placeholder="닉네임를 입력해주세요">
                        </div>
                         <div class="mb-3">
                            <label for="userEmail" class="form-label">이메일</label>
                            <input type="email" class="form-control" id="memEmail" name="memEmail"placeholder="이메일을 입력해주세요">
                        </div>
                        <button type="submit" class="btn btn-primary w-100 mb-3">아이디 찾기</button>
                        <div class="d-flex justify-content-between">
                            <a href="joinPage" class="btn btn-link">회원가입</a>
                            <a href="loginPage" class="btn btn-link">로그인 하기</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
