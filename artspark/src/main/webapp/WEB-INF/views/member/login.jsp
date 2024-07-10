<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Art Spark Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px 0;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <main>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-4">
                    <div class="text-center mb-5">
                        <h2>Art Spark</h2>
                    </div>
                    <form action="login" method="post">
                        <div class="mb-3">
                            <input type="text" class="form-control" name="memId" placeholder="아이디를 입력하세요">
                        </div>
                        <div class="mb-3">
                            <input type="password" class="form-control" name="memPwd" placeholder="비밀번호를 입력해주세요">
                        </div>
                        <button type="submit" class="btn btn-primary w-100 mb-3">로그인</button>
                        <div class="d-flex justify-content-between">
                            <a href="#" class="text-decoration-none">아이디 찾기</a>
                            <a href="#" class="text-decoration-none">비밀번호 찾기</a>
                        </div>
                        <div class="text-center mt-3">
                            <a href="#" class="text-decoration-none">간편 로그인</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
    
    <jsp:include page="../common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>