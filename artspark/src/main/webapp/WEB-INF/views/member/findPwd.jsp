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
                <div class="modal-body centered-container">
                    <h2 class="text-primary">회원님의 임시 비밀번호 입니다</h2>
                    <div class="temporary-password">iSP2ulKMFN</div>
                    <div class="warning-text">※안전을 위해 비밀번호를 변경해 주세요.</div>
                    <button type="button" class="btn btn-primary login-button">로그인</button>
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
</body>
</html>
