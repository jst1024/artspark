<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>login</title>
<link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="../common/header.jsp"/>
  <section class="py-3 py-md-5 py-xl-8">
  <div class="container">
    <div class="row">
      <div class="col-12">
        <div class="mb-5">
          <h2 class="display-5 fw-bold text-center">로그인</h2>
          <p class="text-center m-0">아직 회원이 아니신가요? <a href="join">회원가입</a></p>
        </div>
      </div>
    </div>
    <div class="row justify-content-center">
      <div class="col-12 col-lg-10 col-xl-8">
        <div class="row gy-5 justify-content-center">
          <div class="col-12 col-lg-5">
            <form action="login" method="post">
              <div class="row gy-3 overflow-hidden">
                <div class="col-12">
                  <div class="form-floating mb-2">
                    <input type="text" class="form-control border-1 border-bottom rounded-10" name="memId" id="userId" placeholder="아이디를 입력해주세요" required>
                    <label for="userId" class="form-label">아이디</label>
                  </div>
                </div>
                <div class="col-12 mt-0">
                  <div class="form-floating mb-3">
                    <input type="password" class="form-control border-1 border-bottom rounded-10" name="memPwd" id="memPwd" value="" placeholder="Password" required>
                    <label for="password" class="form-label">비밀번호</label>
                  </div>
                </div>
                <div class="col-12 mt-0">
                  <div class="row justify-content-between">
                    <div class="col-6">
                      <div class="form-check">
                        <a href="lostId" class="link-secondary text-decoration-none" style="font-size:0.8rem;">아이디 찾기</a>
                      </div>
                    </div>
                    <div class="col-6">
                      <div class="text-center">
                        <a href="lostPwd" class="link-secondary text-decoration-none" style="font-size:0.8rem;">비밀번호 찾기</a>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-12">
                  <div class="d-grid">
                    <button class="btn btn-primary btn-lg" type="submit">로그인</button>
                  </div>
                </div>
              </div>
            </form>
          </div>
          <div class="col-12 col-lg-2 d-flex align-items-center justify-content-center gap-3 flex-lg-column">
            <div class="bg-dark h-100 d-none d-lg-block" style="width: 1px; --bs-bg-opacity: .1;"></div>
            <div class="bg-dark w-100 d-lg-none" style="height: 1px; --bs-bg-opacity: .1;"></div>
            <div>or</div>
            <div class="bg-dark h-100 d-none d-lg-block" style="width: 1px; --bs-bg-opacity: .1;"></div>
            <div class="bg-dark w-100 d-lg-none" style="height: 1px; --bs-bg-opacity: .1;"></div>
          </div>
          <div class="col-12 col-lg-5 d-flex align-items-center">
            <div class="d-flex gap-3 flex-column w-100 ">
              <a id="kakao-login-btn">
              	<img alt="로그인" src="resources/images/kakao_login_button.png">
              		<img src="${loginUser.thumbnailImg }"/>
              		<button id="logout">로그아웃</button>
              </a>
			    </div>
            </div>
          </div>
        </div>
      </div>
    </div>
</section>
<script>
	document.getElementById('kakao-login-btn').onclick= () =>{
		
		location.href = 'https://kauth.kakao.com/auth/authorize'
					  + '?client_id=846ba63b2ad75ed4e03f10ca3ab1ef91'
		              + '&redirect_uri=http://localhost/artspark/oauth'
		              + '&response_type=code'
		              + '&scope=profile_nickname,profile_image';
	};
	document.getElementById('logout').onclick = () =>{
		location.href='logout';
	}
</script>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>