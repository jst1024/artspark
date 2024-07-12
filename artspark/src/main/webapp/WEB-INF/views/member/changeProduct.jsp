<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <div class="row">
          <div class="col-md-6">
            <h2 class="mb-4">회원 정보 수정</h2>
            <form>
              <div class="mb-3">
                <label for="userid" class="form-label">아이디</label>
                <input type="text" class="form-control" id="memId" readonly>
              </div>
              <div class="mb-3">
                <label for="nickName" class="form-label">닉네임</label>
                <input type="text" class="form-control" id="memNickname">
              </div>
              <div class="mb-3">
                <label for="email" class="form-label">이메일</label>
                <input type="email" class="form-control" id="memEmail">
              </div>
              <div class="mb-3">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="memPwd">
              </div>
            </form>
          </div>
          <div class="col-md-6">
            <h2 class="mb-4">내 프로필</h2>
            <div class="card">
              <div class="card-body">
                <div class="text-center mb-3">
                  <img src="https://via.placeholder.com/100" class="rounded-circle mb-2" alt="프로필 이미지">
                  <div>
                    <button class="btn btn-primary btn-sm">사진</button>
                  </div>
                </div>
                <div class="mb-3">
                  <label for="introduction" class="form-label">소개글</label>
                  <textarea class="form-control" id="introduction" rows="3" placeholder="소개글을 작성하세요"></textarea>
                </div>
                <div class="mb-3">
                  <label for="phone" class="form-label">연락처</label>
                  <input type="tel" class="form-control" id="phone" value="01000000000">
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row mt-4">
          <div class="col-12">
            <button type="button" class="btn btn-secondary">회원탈퇴</button>
            <button type="submit" class="btn btn-primary float-end">저장</button>
          </div>
        </div>
      </div>  
      <jsp:include page="../common/footer.jsp"/>
</body>
</html>