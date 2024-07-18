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
                    <div class="mb-3" style="display: flex; align-items: center;">
                        <label for="memPwd" class="form-label" style="margin-right: 10px;">비밀번호</label>
                        <input type="password" class="form-control" id="memPwd" name="memPwd" value="${loginUser.memPwd}" readonly style="flex-grow: 1;">
                        <a class="btn btn-outline-success" href="#" data-bs-toggle="modal" data-bs-target="#changePasswordModal" style="margin-left: 10px;">비밀번호 변경</a>
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
                    <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#idCheckModal">회원탈퇴</button>
                    <button type="submit" class="btn btn-primary float-end">저장</button>
                </div>
            </div>
        </form>
    </div>  

    <!-- 회원탈퇴 모달 -->
    <div class="modal fade" id="idCheckModal" tabindex="-1" aria-labelledby="idCheckModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="idCheckModalLabel">회원탈퇴</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h4 class="text-center mb-4">회원탈퇴를 진행하겠습니다.</h4>
                    <form action="delete" method="post">
                        <input type="hidden" value="${loginUser.memPwd}" name="memPwd"/>
                        <div class="modal-body">
                            <div align="center">
                                탈퇴 후 복구가 불가능합니다. <br>
                                정말로 탈퇴 하시겠습니까? <br>
                            </div>
                            <br>
                            <label for="memPwd" class="mr-sm-2">비밀번호</label>
                            <input type="password" class="form-control mb-2 mr-sm-2" placeholder="비밀번호를 입력하세요" id="memPwd" name="memPwd"> <br>
                        </div>
                        <div class="modal-footer" align="center">
                            <button type="submit" class="btn btn-danger">탈퇴하기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- 비밀번호 변경 모달 -->
    <div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="changePasswordModalLabel">비밀번호 변경</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body pass-form">
                    <label for="changePwd" class="mr-sm-2">새 비밀번호 : </label>
                    <input type="password" class="form-control mb-2 mr-sm-2" placeholder="새 비밀번호 입력" id="changePwd" name="changePwd"> <br>
                    <label for="checkPwd" class="mr-sm-2">새 비밀번호 확인 : </label>
                    <input type="password" class="form-control mb-2 mr-sm-2" placeholder="새 비밀번호 확인" id="checkPwd" name="checkPwd"> <br>
                </div>
                <div class="modal-footer" align="center">
                    <div align="center" style="display:none;" id="check-msg"></div>
                    <button type="button" class="btn btn-danger" id="changeBtn" disabled>변경하기</button>
                </div>
            </div>
        </div>
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
            reader.onload = function(e) {
                document.querySelector('.rounded-circle').setAttribute('src', e.target.result);
            }
            reader.readAsDataURL(e.target.files[0]);
        }
    });

    $(document).ready(function() {
        const $memId = $('#memId');
        const $changePwd = $('#changePwd');
        const $checkPwd = $('#checkPwd');
        const $changeBtn = $('#changeBtn');

        $checkPwd.keyup(function() {
            if($changePwd.val() === $checkPwd.val()) {
                $changeBtn.attr('disabled', false); 
                $('#check-msg').hide();
            } else { 
                $('#check-msg').show().html('새 비밀번호를 다시 확인해주세요.<br>');
                $changeBtn.attr('disabled', true);
            }
        });
        
        $changeBtn.click(function() {     
            $.ajax({
                url:'changePwd', 
                type:'post',
                data:{
                    memId : $memId.val(),
                    changePwd : $changePwd.val()
                },
                success: response => {
                    console.log(response);
                    if(response === "SUCCESS") {
                        alert('비밀번호가 변경되었습니다. 다시 로그인 해주세요.');
                        location.href = 'logout';
                    } else {
                        alert('비밀번호 변경 중 오류가 발생했습니다. 다시 시도해주세요.');
                    }
                },
                error : function() {
                    alert('비밀번호 변경 중 오류가 발생했습니다. 다시 시도해주세요.');
                }
            });
        });
    });
    </script>
</body>
</html>