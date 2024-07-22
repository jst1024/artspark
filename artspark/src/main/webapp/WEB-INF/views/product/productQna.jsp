<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작가 문의</title>
    <jsp:include page="../common/head.jsp"></jsp:include>
    <script src="https://cdn.jsdelivr.net/npm/@naver/wysiwyg@1.0.0/dist/ndt.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/naver-editor/css/smart_editor2.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/naver-editor/js/HuskyEZCreator.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/naver-editor/js/SE2BasicCreator.js" charset="utf-8"></script>
    <style>
        #white-board {
            width: 100%;
            height: 600px;
            padding: 30px;
            border: 1px solid #333;
        }

        #editor {
            width: 100%;
            height: 600px;
            padding: 30px;
            border: 1px solid #333;
        }

        .btn-group {
            width: 100%;
            margin: auto;
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }

        .btn-group button {
            margin: 0 10px;
        }

        .big-btn {
            width: 308px;
            height: 60px;
            margin-bottom: 20px;
            border: none;
            color: white;
        }

        #send-btn {
            background-color: #14213d;
        }

        #send-btn:hover {
            background-image: linear-gradient(rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0.2));
        }

        #cancle-btn {
            background-color: #ff5e26;
        }

        #cancle-btn:hover {
            background-image: linear-gradient(rgba(0, 0, 0, 0.2), rgba(0, 0, 0, 0.2));
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <form action="artistQna" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this)">
        <div class="container container-custom mt-5">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group col-md-12">
                        <label for="title">제목</label>
                        <input type="hidden" value="${sessionScope.loginUser.memId}" name="memId">
                    	<input type="hidden" value="${product.productNo}" name="productNo">
                        <input type="text" class="form-control" name="qnaTitle" placeholder="내용을 입력해주세요">
                    </div>

                    <div class="form-group col-md-12">
                        <label for="editorTxt">내용</label>
                        <textarea class="form-control" id="editorTxt" name="qnaContent" rows="15"></textarea>
                    </div>

                    <div class="form-group col-md-12">
                        <label for="file">첨부파일</label>
                        <div class="file-input-wrapper">
                            <input type="file" id="file" name="upfile" onchange="updateFileName(this)">
                        </div>
                        <small class="form-text text-muted">업로드 가능 파일 (pdf 등) 최대 업로드 파일 크기 (50MB)</small>
                    </div>
                </div>
                <div class="col-md-6">
                    <div id="white-board">
                        <h2>화이트보드 들어갈 자리</h2>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12" style="text-align:center;">
                    <p><small style="color: red;"><i class="fas fa-exclamation-circle"></i> 글을 작성하면 판매자에게 알람이 전송됩니다.</small></p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="btn-group">
                        <button type="submit" class="big-btn" id="send-btn">보내기</button>
                        <button type="button" class="big-btn" id="cancle-btn" onclick="backpage();">취소</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        function backpage() {
            location.href = "productDetail";
        }
    </script>

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
