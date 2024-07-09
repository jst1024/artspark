<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@naver/wysiwyg@1.0.0/dist/ndt.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .container-custom {
            width: 1200px;
            margin: 0 auto;
        }
        body {
            width: 1920px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <div id="header">
      <jsp:include page="../common/header.jsp" />
    </div>

<div class="container-main">
    <h2>공지사항 등록</h2>
    <form action="noticeInsert" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="title">제목</label>
            <input type="hidden" value="${sessionScope.loginUser.memId }" name="memId" >
            <input type="text" class="form-control" id="title" name="noticeTitle" placeholder="내용을 입력해주세요">
        </div>
        <div class="form-group">
            <label for="content">내용</label>
            <textarea class="form-control" id="content" name="noticeContent" rows="10" placeholder="내용을 입력해주세요"></textarea>
        </div>
        <div class="form-group">
            <label for="file">첨부파일</label>
            <input type="file" class="form-control-file" id="file" name="upfile">
            <small class="form-text text-muted">업로드가능파일 (pdf 등) 최대업로드파일크기(50mb)</small>
        </div>
        <button type="submit" class="btn btn-primary">등록하기</button>
    </form>
</div>

    <div id="footer">
      <jsp:include page="../common/footer.jsp" />
    </div>
<script>
    $(document).ready(function() {
        $('#content').ndt();
    });
</script>
</body>
</html>