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
    <jsp:include page="../common/header.jsp"/>
    <div class="container flex-grow-1">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="form-container mx-auto">
                    <h2 class="text-center mb-4">비밀번호 찾기</h2>
                   <form id="findPasswordForm">
					    <div class="mb-3">
					        <label for="memId" class="form-label">아이디</label>
					        <input type="text" class="form-control" id="memId" name="memId" placeholder="아이디를 입력해주세요" required>
					    </div>
					    <div class="mb-3">
					        <label for="memNickname" class="form-label">닉네임</label>
					        <input type="text" class="form-control" id="memNickname" name="memNickname" placeholder="닉네임을 입력해주세요" required>
					    </div>
					    <div class="mb-3">
					        <label for="memEmail" class="form-label">이메일</label>
					        <input type="email" class="form-control" id="memEmail" name="memEmail" placeholder="이메일을 입력해주세요" required>
					    </div>
					    <button type="submit" class="btn btn-primary w-100 mb-3">임시 비밀번호 발급</button>
					    <div class="d-flex justify-content-between">
					        <a href="joinPage" class="btn btn-link">회원가입</a>
					        <a href="loginPage" class="btn btn-link">로그인 하기</a>
					    </div>
					</form>
                </div>
            </div>
        </div>
    </div>
    <script>
		$(document).ready(function() {
		    $('#findPasswordForm').submit(function(e) {
		        e.preventDefault();
		        $.ajax({
		            url: 'auth-mail',
		            type: 'post',
		            data: {
		                memId: $('#memId').val(),
		                memNickname: $('#memNickname').val(),
		                memEmail: $('#memEmail').val()
		            },
		            success: function(response) {
		                if(response === "success") {
		                    alert('임시 비밀번호가 이메일로 발송되었습니다. 이메일을 확인해주세요.');
		                    window.location.href = 'loginPage';
		                } else {
		                    alert('입력하신 정보와 일치하는 계정을 찾을 수 없습니다.');
		                }
		            },
		            error: function() {
		                alert('오류가 발생했습니다.');
		            }
		        });
		    });
		});
	</script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <jsp:include page="../common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
