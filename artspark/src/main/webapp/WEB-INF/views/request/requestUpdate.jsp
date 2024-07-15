<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>의뢰 글 수정</title>
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
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="container mt-5" >
        <h2>의뢰 글 수정(Request)</h2>
        <form action="requestUpdate" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this)">
            <div class="form-group">
                <label for="usage">사용용도</label>
                <select class="form-control dropdown-custom" name="reqPurpose">
 					<option value="상업용" <c:if test="${request.reqPurpose == '상업용'}">selected</c:if>>상업용</option>
                    <option value="비상업용" <c:if test="${request.reqPurpose == '비상업용'}">selected</c:if>>비상업용</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="category">카테고리</label>
                <select class="form-control dropdown-custom" name="reqCategory">
					<option value="일러스트" <c:if test="${request.reqCategory == '일러스트'}">selected</c:if>>일러스트</option>
                    <option value="디자인" <c:if test="${request.reqCategory == '디자인'}">selected</c:if>>디자인</option>
                    <option value="영상" <c:if test="${request.reqCategory == '영상'}">selected</c:if>>영상</option>
                    <option value="웹툰" <c:if test="${request.reqCategory == '웹툰'}">selected</c:if>>웹툰</option>
                </select>
             </div>
		     <div class="form-group">
		         <label for="title">제목</label>
		         <input type="hidden" value="${sessionScope.loginUser.memId}" name="memId">
		         <input type="hidden" value="${request.reqNo}" name="reqNo">
		         
		         <input type="text" class="form-control" name="reqTitle" value="${ request.reqTitle }">
		     </div>
		     
		     <div class="form-group">
		         <label for="editorTxt">내용</label>
		         <textarea class="form-control" id="editorTxt" name="reqContent" rows="10">${ request.reqContent }</textarea>
		     </div>
		     
            <div class="form-group">
                 <label for="file">첨부파일</label>
                 <div class="file-input-wrapper">
                     <label class="btn btn-secondary" for="file">파일 선택</label>
                     <input type="file" id="file" name="reUpFile" onchange="updateFileName(this)">
                     <span id="file-name" class="file-name">
                         <c:if test="${not empty imgFile}">
                             현재 파일: ${imgFile.changeName}
                         </c:if>
                         <c:if test="${empty imgFile}">
                             선택된 파일 없음
                         </c:if>
                     </span>
                 </div>
                 <small class="form-text text-muted">업로드 가능 파일 (pdf 등) 최대 업로드 파일 크기 (50MB)</small>
            </div>
			<button type="submit" class="btn btn-primary" style="float: right;">수정하기</button>
		</form>
	</div> 
    <script type="text/javascript">
		        var oEditors = [];
		
		        // 스마트에디터를 초기화
		        nhn.husky.EZCreator.createInIFrame({
		            oAppRef: oEditors,
		            elPlaceHolder: "editorTxt",
		            sSkinURI: "${pageContext.request.contextPath}/resources/naver-editor/SmartEditor2Skin.html",
		            fCreator: "createSEditor2"
		        });
		
		        // 폼 전송 버튼 클릭 시 스마트에디터의 내용을 텍스트에어리어로 동기화
		        function submitContents(e) {
		            oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);
		
		            // 실제 form submit
		            try {
		                e.form.submit();
		            } catch (e) {
		                console.log(e);
		            }
		        }
     </script>        
	            
    <script>
        // 파일 선택 시 파일명을 업데이트
        function updateFileName(input) {
            var fileName = input.files[0].name;
            document.getElementById('file-name').textContent = fileName;
        }
    </script>
	     
     	 <jsp:include page="../common/footer.jsp" />
</body>
</html>