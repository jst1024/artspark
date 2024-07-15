<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매자 정보 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <div class="container mt-5 pt-5 mb-5">
        <form action="${pageContext.request.contextPath}/productUpdate" method="post" enctype="multipart/form-data">
            <div class="row">
                <div class="col-md-6">
                    <h2 class="mb-4">회원 정보 수정</h2>
                    <div class="mb-3">
                        <label for="memId" class="form-label">아이디</label>
                        <input type="text" class="form-control" id="memId" name="memId" value="${loginUser.memId}" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="memNickname" class="form-label">닉네임</label>
                        <input type="text" class="form-control" id="memNickname" name="memNickname" value="${loginUser.memNickname}">
                    </div>
                    <div class="mb-3">
                        <label for="memEmail" class="form-label">이메일</label>
                        <input type="email" class="form-control" id="memEmail" name="memEmail" value="${loginUser.memEmail}">
                    </div>
                    <div class="mb-3">
                        <label for="memPwd" class="form-label">비밀번호</label>
                        <input type="password" class="form-control" id="memPwd" name="memPwd" value="${loginUser.memPwd}" readonly>
                    </div>
                </div>
                <div class="col-md-6">
                
                    <h2 class="mb-4">판매자 프로필</h2>
                    <div class="card">
                        <div class="card-body">
                            <div class="text-center mb-3">
                                <img src="${pageContext.request.contextPath}${artist.artistPath}" 
                                     class="rounded-circle mb-2" alt="프로필 이미지" style="width: 100px; height: 100px;">
                                <input type="hidden" id="artistOriginName" name="artistOriginName" value="${artist.artistOriginName}">
                                <input type="hidden" id="artistChangeName" name="artistChangeName" value="${artist.artistChangeName}">
                                <div>
                                    <input type="file" id="profileImage" name="profileImage" style="display: none;">
                                    <button type="button" class="btn btn-primary btn-sm" onclick="document.getElementById('profileImage').click();">사진 변경</button>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="artistIntro" class="form-label">소개글</label>
                                <textarea class="form-control" id="artistIntro" name="artistIntro" rows="3">${artist.artistIntro}</textarea>
                            </div>
                            <div class="mb-3">
                                <label for="artistPhone" class="form-label">연락처</label>
                                <input type="tel" class="form-control" id="artistPhone" name="artistPhone" value="${artist.artistPhone}">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-4">
                <div class="col-12">
                    <button type="button" class="btn btn-secondary" onclick="confirmDelete()">회원탈퇴</button>
                    <button type="submit" class="btn btn-primary float-end">저장</button>
                </div>
            </div>
        </form>
    </div>  
    <jsp:include page="../common/footer.jsp"/>

    <script>
    function confirmDelete() {
        if (confirm("정말로 탈퇴하시겠습니까?")) {
            // 회원 탈퇴 처리를 위한 서버 요청
            window.location.href = "${pageContext.request.contextPath}/memberDelete";
        }
    }

    document.getElementById('profileImage').addEventListener('change', function(e) {
        if (e.target.files && e.target.files[0]) {
            let reader = new FileReader();
            reader.onload = function(e {
                document.querySelector('.rounded-circle').setAttribute('src', e.target.result);
            }
            reader.readAsDataURL(e.target.files[0]);
        }
    });
    </script>
</body>
</html>