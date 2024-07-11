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
                    <form id="findIdForm" method="get">
                        <div class="mb-3">
                            <label for="email" class="form-label">이메일</label>
                            <input type="email" class="form-control" id="email" placeholder="이메일을 입력해주세요" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 mb-3">아이디 찾기</button>
                        <div class="d-flex justify-content-between">
                            <a href="join" class="btn btn-link">회원가입</a>
                            <a href="login" class="btn btn-link">로그인 하기</a>
                        </div>
                    </form>
                    <div id="result" class="mt-3"></div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#findIdForm').submit(function(event) {
                event.preventDefault();
                const email = $('#email').val();
                const resultDiv = $('#result');

                $.ajax({
                    url: 'findId',
                    type: 'GET',
                    data: { email: memEmail },
                    dataType: 'json',
                    success: function(data) {
                        if (data.success) {
                            resultDiv.html('<div class="alert alert-success">아이디: ' + data.id + '</div>');
                        } else {
                            resultDiv.html('<div class="alert alert-danger">' + data.errorMsg + '</div>');
                        }
                    },
                    error: function() {
                        resultDiv.html('<div class="alert alert-danger">오류가 발생했습니다.</div>');
                    }
                });
            });
        });
    </script>
</body>
</html>