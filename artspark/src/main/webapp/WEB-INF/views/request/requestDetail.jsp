<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>의뢰게시판 상세보기</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .container-main {
            max-width: 1200px;
            margin: 0 auto;
        }
        .req-content {
            margin: 20px 0;
        }
        .req-file {
            margin-top: 10px;
        }
        .memId-actions {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        .btn {
            width: 100%;
            max-width: 200px;
        }
        .img-fixed {
            width: 500px;
            height: 500px;
            object-fit: cover;
        }
        @media (max-width: 1200px) {
            .container-main {
                padding: 0 15px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    <div class="container-fluid" style="max-width: 1920px;">
        <div class="container-main">
            <h2 class="mt-5">의뢰글 상세보기</h2>
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th scope="row">글 번호</th>
                        <td>${request.reqNo}</td>
                        <th scope="row">작성일</th>
                        <td>${request.reqDate}</td>
                        <th scope="row">작성자</th>
                        <td>${request.memId}</td>
                        <th scope="row">조회수</th>
                        <td>${request.reqCount}</td>
                    </tr>
                    <tr>
                        <th scope="row">제목</th>
                        <td colspan="7">${request.reqTitle}</td>
                    </tr>
                    <tr>
                        <td colspan="8" class="req-content">
                            <div class="mb-7 text-center">
                                <c:if test="${imgFile != null}">
                                    <img src="${imgFile.imgFilePath}" alt="첨부 이미지" class="img-fluid img-fixed">
                                </c:if>
                                <c:if test="${imgFile == null}">
                                    <span></span>
                                </c:if>
                            </div>
                            <p>${request.reqContent}</p>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">첨부파일</th>
                        <td colspan="7">
                            <c:if test="${imgFile != null}">
                                <strong>첨부파일: </strong><a href="${imgFile.imgFilePath}" target="_blank">${imgFile.originName}</a>
                            </c:if>
                            <c:if test="${imgFile == null}">
                                <span>첨부파일 없음</span>
                            </c:if>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="memId-actions">
                <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
                <c:if test="${ sessionScope.loginUser.memId eq requestScope.request.memId }">
               <!--   <form action="boardupdate.do" method="post">
	                <input type="hidden" name="boardNo" value="${board.boardNo }" />--> <!-- 요청시 전달값 안보이게 -->
	                <a class="btn btn-primary" onclick="postSubmit(this.innerHTML);">수정하기</a>
              
                <!--  <form test="boarddelete.do" method="post">
                	<input type="hidden" name="boardNo" value="${board.boardNo }" />--> <!-- 요청시 전달값 안보이게 -->
	                <a class="btn btn-danger" onclick="postSubmit(this.innerHTML);">삭제하기</a>
            	</c:if>
            	<!-- 코드가 같고 action속성만 변경되면 될것같다. -->
            	<form method="post" action="" id="postForm">
            		<input type="hidden" name="reqNo" value="${request.reqNo }" />
            		<input type="hidden" name="filePath" value="${imgFile.imgFilePath}">
            		
            	</form>
            	<script>
            		function postSubmit(el) {

            			const attrValue = '수정하기' === el ? 'updateRequest' : 'deleteRequest';
            			
            			$('#postForm').attr('action', attrValue).submit();
            		
            		}
            	</script>
                    <button type="button" class="btn btn-secondary" onclick="history.back()">뒤로가기</button>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp" />

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>