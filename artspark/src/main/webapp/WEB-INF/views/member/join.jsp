<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 5vh;
            padding-bottom: 5vh;
        }
        .form-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 40px;
            margin-top: 5vh;
        }
        .error-message {
            color: crimson;
            font-size: 0.7em;
            display: none;
        }
        .btn-group-full {
            display: flex;
            gap: 10px;
        }
        .btn-group-full .btn {
            flex: 1;
        }
        .container-fluid {
            margin-top: 5vh; /* 컨테이너를 아래로 내리기 위해 추가 */
        }
    </style>
</head>
<body>

    <jsp:include page="../common/header.jsp" />

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="form-container">
                    <h2 class="text-center mb-4">회원가입</h2>
                    <form action="join" method="post">
                <div class="form-group">
                    <label for="userId">아이디: </label>
                    <input type="text" class="form-control" id="userId" placeholder="아이디를 입력해주세요." name="memId" required> <br>
					<div id="checkResult" style= "display:none; font-size:0.7em;"></div><br/>
                    <label for="userPwd">비밀번호: </label>
                    <input type="password" class="form-control" id="userPwd" placeholder="비밀번호를 입력해주세요." name="memPwd" required> <br>

                    <label for="checkPwd">비밀번호 확인: </label>
                    <input type="password" class="form-control" id="checkPwd" placeholder="비밀번호 확인" required> <br>
                    
                     <label for="userNickName">닉네임: </label>
                    <input type="text" class="form-control" id="memNickname" name="memNickname" placeholder="닉네임을 입력해주세요." required> <br>

                    <label for="email">이메일: </label>
                    <input type="text" class="form-control" id="userEmail" placeholder="이메일을 입력해주세요." name="memEmail"> <br>
                </div> 
                <br>
                <div class="btns" align="center">
                    <button type="submit" id="joinBtn" class="btn btn-primary">회원가입</button>
                    <button type="reset" class="btn btn-danger">초기화</button>
                </div>
            </form>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                   <script>
	            	$(() => {
	            		const $idInput = $('.form-group #userId');
	            		const $checkResult = $('#checkResult');
	            		const $joinSubmit = $('#joinBtn');
	            		
	            		$idInput.keyup(() =>{
	            			
	            			//console.log($idInput.val());
	            			
	            			//불필요한 DV접근을 제한하기 위해 다섯글자 이상으로 입력했을 때만 AJAX요청을 보내서 체크
	            			if($idInput.val().length >= 5){
	            				
	            				$.ajax({
	            					url:'idcheck',
	            					type: 'get',
	            					data: {
	            						checkId: $idInput.val()
	            					},
	            					success: response =>{
	            				
	            						if(response === 'ERROR'){ //증복이다!!
	            							$checkResult.show().css('color','red').text('중복입니다!');
	            							$joinSubmit.attr('disabled',true);
	   
	            						}else{//중복이 아니다
	            							$checkResult.show().css('color','green').text('사용 가능합니다!');
	            							$joinSubmit.removeAttr('disabled');
	            						
	            						}
	            					},
	            					error: ()=>{
	            						console.log('아이디 중복체크용 AJAX통신 실패.. ㅠ');
	            					}
	            				});
	            				
	            			}
	            			else{
	            				$checkResult.hide();
	            				$joinSubmit.attr('disabled',true);
	            			}	
	            		});
	            	});
           		</script>
           		 </div>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>