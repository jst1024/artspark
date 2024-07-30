<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>답변 글 등록</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@naver/wysiwyg@1.0.0/dist/ndt.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/naver-editor/css/smart_editor2.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/naver-editor/js/HuskyEZCreator.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/naver-editor/js/SE2BasicCreator.js" charset="utf-8"></script>
    <style>
        .dropdown-custom {
            width: 50%;
        }
        .file-input-wrapper {
            display: flex;
            align-items: center;
        }
        .file-input-wrapper input[type="file"] {
            display: none;
        }
        .file-input-wrapper label {
            margin: 0;
            cursor: pointer;
            display: inline-block;
        }
        .form-group {
            position: relative;
        }
        .form-group .btn-primary {
            position: absolute;
            right: 0;
            bottom: 0;
        }
        .file-name {
            margin-left: 10px;
        }
        .form-check-input {
            width: 20px;
            height: 20px;
            margin-right: 10px;
        }
        .form-check-label {
            margin-bottom: 0;
        }
        .title-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="container mt-5">
        <h2>답변 글 등록(Answer)</h2>
        <form action="insertAnswer" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this)">
            <input type="hidden" name="qnaNo" value="${param.qnaNo}">
            <input type="hidden" name="secret" value="${qna.secret}">
            <input type="hidden" name="answerNo" value="${param.answerNo}">
            <div class="form-group">
                <label for="title">제목</label>
                <input type="hidden" value="${sessionScope.loginUser.memId}" name="memId">
                <input type="text" class="form-control" id="answerTitle" name="answerTitle" placeholder="내용을 입력해주세요">
            </div>
            <div class="form-group">
                <label for="editorTxt">내용</label>
                <textarea class="form-control" id="editorTxt" name="answerContent" rows="10">
                </textarea>
            </div>
            <div class="form-group">
                <label for="file">첨부파일</label>
                <div class="file-input-wrapper">
                    <label class="btn btn-secondary" for="file">파일 선택</label>
                    <input type="file" id="file" name="upfile" onchange="updateFileName(this)">
                    <span id="file-name" class="file-name">선택된 파일 없음</span>
                </div>
                <small class="form-text text-muted">업로드 가능 파일 (pdf 등) 최대 업로드 파일 크기 (50MB)</small>
            </div>
            <button type="submit" class="btn btn-primary" style="float: right;">등록하기</button>
        </form>
    </div>
    
    <script type="text/javascript">
        var oEditors = [];
        
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "editorTxt",
            sSkinURI: "${pageContext.request.contextPath}/resources/naver-editor/SmartEditor2Skin.html",
            fCreator: "createSEditor2"
        });
        
        function submitContents(e) {
            oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);
            
            var title = document.getElementById("answerTitle").value;
            if (title.trim() === "") {
                alert("제목을 입력해주세요.");
                return false;
            }
            
            try {
                e.form.submit();
            } catch (e) {
                console.log(e);
            }
        }
    </script>        
                
    <script>
        function updateFileName(input) {
            var fileName = input.files[0].name;
            document.getElementById('file-name').textContent = fileName;
        }
    </script>
     
    <jsp:include page="../common/footer.jsp" />
</body>
</html>