<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
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
    <jsp:include page="common/menubar.jsp"/>
    <div class="container flex-grow-1">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="form-container mx-auto">
                    <h2 class="text-center mb-4">비밀번호 찾기</h2>
                    <form>
                        <div class="mb-3">
                            <label for="username" class="form-label">아이디</label>
                            <input type="text" class="form-control" id="username" placeholder="내용을 입력해주세요">
                        </div>
                        <div class="mb-3">
                            <label for="name" class="form-label">이름</label>
                            <input type="text" class="form-control" id="name" placeholder="내용을 입력해주세요">
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">이메일</label>
                            <input type="email" class="form-control" id="email" placeholder="내용을 입력해주세요">
                        </div>
                        <button type="submit" class="btn btn-primary w-100 mb-3">비밀번호 찾기</button>
                        <div class="d-flex justify-content-between">
                            <a href="#" class="btn btn-link">회원가입</a>
                            <a href="#" class="btn btn-link">로그인 하기</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
