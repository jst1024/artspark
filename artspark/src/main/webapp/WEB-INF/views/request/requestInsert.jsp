<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>의뢰 글 등록</title>
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
        <h2>의뢰 글 등록(Request)</h2>
        <form action="requestInsert" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this)">
            <div class="form-group">
                <label for="usage">사용용도</label>
                <select class="form-control dropdown-custom" name="reqPurpose">
                    <option value="상업용">상업용</option>
                    <option value="비상업용">비상업용</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="category">카테고리</label>
                <select class="form-control dropdown-custom" name="reqCategory">
                    <option value="일러스트">일러스트</option>
                    <option value="디자인">디자인</option>
                    <option value="영상">영상</option>
                    <option value="웹툰">웹툰</option>
                </select>
            </div>
		     <div class="form-group">
		         <label for="title">제목</label>
		         <input type="hidden" value="${sessionScope.loginUser.memId}" name="memId">
		         <input type="text" class="form-control" name="reqTitle" placeholder="내용을 입력해주세요">
		     </div>
		     
		     <div class="form-group">
		         <label for="editorTxt">내용</label>
		         <textarea class="form-control" id="editorTxt" name="reqContent" rows="10" placeholder="내용을 입력해주세요"></textarea>
		     </div>
		     <div id="content-guidelines" class="mt-2">
		         <small class="form-text text-muted">
		                 - 작가의 게시물 임금만 받을 수 있습니다.<br>
		                 - 사용 용도를 꼭 기입 바랍니다.<br>
		                 - 이미지를 등록할 경우 출처를 기입해 주셔야 합니다.<br>
		                 - 성인물 의뢰는 등록하실 수 없습니다.<br>
		                 - 개인 연락이 가능한 연락처, SNS, 사이트 주소 등을 기입하실 수 없습니다.<br>
		                 - 저작권이 금지되어 있으며, 연락처 교환은 결제 이후에만 가능합니다.
		         </small>
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