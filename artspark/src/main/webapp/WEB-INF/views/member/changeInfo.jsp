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
            <form action="join" method="post">
                <div class="mb-3">
                    <label for="userId" class="form-label">아이디</label>
                    <input type="text" class="form-control" id="memId" name="memId" value="${ sessionScope.loginUser.memId }" readonly>
                </div>
                <div class="mb-3">
                    <label for="userNickname" class="form-label">닉네임</label>
                    <input type="text" class="form-control" id="memNickName" name="memNickname" value="${ sessionScope.loginUser.memNickname }" >
                </div>
                <div class="mb-3">
                    <label for="userEmail" class="form-label">이메일</label>
                    <input type="email" class="form-control" id="memEmail" name="memEmail"  value="${ sessionScope.loginUser.memEmail }">
                </div>
              	<div class="mb-3" style="display: flex; align-items: center;">
				    <label for="userPassword" class="form-label" style="margin-right: 10px;">비밀번호</label>
				    <input type="password" class="form-control" id="memPwd" name="memPwd" value="${ sessionScope.loginUser.memPwd }" readonly style="flex-grow: 1;">
				    <a class="btn btn-outline-success" href="#" data-bs-toggle="modal" data-bs-target="#changePasswordModal" style="margin-left: 10px;">비밀번호 변경</a>
				</div>
                <div class="button-group">
                    <div class="left-buttons">
                        <a class="btn btn-success" href="changeProduct">판매자로 변경</a>
                        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#idCheckModal">회원탈퇴</button>
                    </div>
                    <button type="submit" class="btn btn-primary">저장</button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- 모달로 회원 탈퇴 부분 -->
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
                        <input type="hidden" value="${ sessionScope.loginUser.memPwd }" name="memId"/>
                        <div class="modal-body">
                            <div align="center">
                                탈퇴 후 복구가 불가능합니다. <br>
                                정말로 탈퇴 하시겠습니까? <br>
                            </div>
                            <br>
                            <label for="memPwd" class="mr-sm-2">비밀번호</label>
                            <input type="password" class="form-control mb-2 mr-sm-2" placeholder="비밀번호를 입력하세요" id="memPwd" name="memPwd"> <br>
                        </div>
                        <!-- Modal footer -->
                        <div class="modal-footer" align="center">
                            <button type="submit" class="btn btn-danger">탈퇴하기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 비밀번호 버튼 클릭시 보여질 Modal -->
	 <!-- Modal Header -->
               <!-- 비밀번호 변경 Modal -->
					<div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
					    <div class="modal-dialog">
					        <div class="modal-content">
					            <div class="modal-header">
					                <h4 class="modal-title" id="changePasswordModalLabel">비밀번호 변경</h4>
					                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					            </div>
					            <div class="modal-body pass-form">
					                <label for="userPwd" class="mr-sm-2">기존 비밀번호 : </label>
					                <input type="password" class="form-control mb-2 mr-sm-2" placeholder="기존 비밀번호 입력" id="memPwd" name="memPwd"> <br>
					                <label for="changePwd" class="mr-sm-2">변경 비밀번호 : </label>
					                <input type="password" class="form-control mb-2 mr-sm-2" placeholder="변경할 비밀번호 입력" id="changePwd" name="changePwd"> <br>
					                <label for="checkPwd" class="mr-sm-2">변경 비밀번호 재확인 : </label>
					                <input type="password" class="form-control mb-2 mr-sm-2" placeholder="비밀번호 재확인" id="checkPwd" name="checkPwd"> <br>
					            </div>
					            <div class="modal-footer" align="center">
					                <div align="center" style="display:none;" id="check-msg"></div>
					                <button type="button" class="btn btn-danger" id="changeBtn" disabled>변경하기</button>
					            </div>
					        </div>
					    </div>
					</div>
                     <script>
						$(document).ready(function() {
						    const $memId = $('#memId'); // 로그인 유저 아이디
						    const $memPwd = $('#memPwd'); // 기존 비밀번호 입력 
						    const $changePwd = $('#changePwd'); // 변경할 비밀번호 입력 
						    const $checkPwd = $('#checkPwd'); // 변경 비밀번호 재확인 입력 
						    const $changeBtn = $('#changeBtn'); // 변경 버튼
						
						    $checkPwd.keyup(function() {
						        if($changePwd.val() === $checkPwd.val()) {
						            $changeBtn.attr('disabled', false); 
						            $('#check-msg').hide();
						        } else { 
						            $('#check-msg').show().html('변경할 비밀번호를 다시 확인해주세요.<br>');
						            $changeBtn.attr('disabled', true);
						        }
						    });
						    
						    $changeBtn.click(function() {     
						        $.ajax({
						            url:'findPwd', 
						            type:'post',
						            data:{
						                memId : $memId.val(),
						                memPwd : $memPwd.val(),
						                changePwd : $changePwd.val()
						            },
						            success: response => {
						            	console.log(response);
						                if(response === "SUCCESS") {
						                    alert('비밀번호가 변경되었습니다. 다시 로그인 해주세요.');
						                    location.href = 'logout';
						                } else if(response === "WrongPwd") {
						                	console.log(response);
						                    $('#check-msg').show().html('기존 비밀번호가 올바르지 않습니다.<br>');
						                } else {
						                	console.log(response);
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


    <jsp:include page="../common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
