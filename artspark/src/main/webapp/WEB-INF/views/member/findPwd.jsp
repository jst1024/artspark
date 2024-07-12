<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    
    <!-- 모달 트리거 버튼 -->
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-4 text-center">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#passwordModal">
                    비밀번호 찾기
                </button>
            </div>
        </div>
    </div>
    
    <!-- 모달 -->
    <div class="modal fade" id="passwordModal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="passwordModalLabel">비밀번호 찾기</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="passwordForm">
                        <div class="form-group">
                            <label for="memId">아이디</label>
                            <input type="text" class="form-control" id="memId" name="memId" required>
                        </div>
                        <div class="form-group">
                            <label for="memEmail">이메일</label>
                            <input type="email" class="form-control" id="memEmail" name="memEmail" required>
                        </div>
                        <div class="form-group">
                            <label for="newPwd">새 비밀번호</label>
                            <input type="password" class="form-control" id="newPwd" name="newPwd" required>
                        </div>
                        <div class="form-group">
                            <label for="confirmPwd">비밀번호 확인</label>
                            <input type="password" class="form-control" id="confirmPwd" name="confirmPwd" required>
                        </div>
                        <button type="submit" class="btn btn-primary">비밀번호 변경</button>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../common/footer.jsp"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
    $(document).ready(function() {
        $('#passwordForm').on('submit', function(e) {
            e.preventDefault();
            if($('#newPwd').val() !== $('#confirmPwd').val()) {
                alert('새 비밀번호와 확인 비밀번호가 일치하지 않습니다.');
                return;
            }
            $.ajax({
                url: 'findPwd',
                type: 'POST',
                data: {
                    memId: $('#memId').val(),
                    memEmail: $('#memEmail').val(),
                    newPwd: $('#newPwd').val()
                },
                success: function(response) {
                    if(response === "SUCCESS") {
                        alert('비밀번호가 성공적으로 변경되었습니다. 새 비밀번호로 로그인해주세요.');
                        $('#passwordModal').modal('hide');
                    } else if(response === "USER_NOT_FOUND") {
                        alert('해당 사용자를 찾을 수 없습니다.');
                    } else if(response === "UPDATE_FAILED") {
                        alert('비밀번호 변경에 실패했습니다. 다시 시도해주세요.');
                    } else {
                        alert('오류가 발생했습니다. 다시 시도해주세요.');
                    }
                },
                error: function() {
                    alert('서버와의 통신 중 오류가 발생했습니다.');
                }
            });
        });
    });
    </script>
</body>
</html>