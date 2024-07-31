<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문의 글 상세보기</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .container-main {
            max-width: 1200px;
            margin: 0 auto;
        }
        .qna-content {
            margin: 20px 0;
        }
        .qna-file {
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
        .secret-icon {
            color: red;
            margin-right: 5px;
        }
        .non-secret-icon {
            color: green;
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    <div class="container-fluid" style="max-width: 1920px;">
        <div class="container-main">
            <h2 class="mt-5">질문 글 상세보기</h2>
            <table class="table table-bordered">
                <tbody>
                    <tr>
 						<th>비밀 글 여부</th>
                        <td>
                            <c:choose>
                                <c:when test="${qna.secret == 'Y'}" >
                                    <i class="fas fa-lock secret-icon"></i>비밀글
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-unlock non-secret-icon"></i>일반글
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <th scope="row">글 번호</th>
                        <td>${qna.qnaNo}</td>
                        <th scope="row">작성일</th>
                        <td>${qna.qnaDate}</td>
                    </tr>
                    <tr>
                        <th scope='row'>문의 목적</th>
                        <td colspan="6">${qna.qnaCategory }</td>
                    </tr>
                    <tr>
                        <th scope="row">제목</th>
                        <td colspan="6">${qna.qnaTitle}</td>
                    </tr>
                    <tr>
                        <td colspan="6" class="qna-content">
                            <div class="mb-3 text-center">
                                <c:if test="${imgFile != null}">
                                    <img src="${imgFile.imgFilePath}" alt="첨부 이미지" class="img-fluid img-fixed">
                                </c:if>
                                <c:if test="${imgFile == null}">
                                    <span></span>
                                </c:if>
                            </div>
                            <p>${qna.qnaContent}</p>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">첨부파일</th>
                        <td colspan="6">
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
                <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우나 관리자만 보여져야 함 -->
                <c:choose>
                	<c:when test="${sessionScope.loginUser != null && sessionScope.loginUser.memId eq qna.memId}">
                    	<a class="btn btn-primary" onclick="postSubmit(this.innerHTML);">수정하기</a>
                    	<a class="btn btn-danger" onclick="postSubmit(this.innerHTML);">삭제하기</a>
                    	<button type="button" class="btn btn-secondary" onclick="history.back()">뒤로가기</button>
                	</c:when>
                	<c:when test="${sessionScop.loginUser != null || sessionScope.loginUser.memId eq 'admin' }">
	                	<a class="btn btn-danger" onclick="postSubmit(this.innerHTML);">삭제하기</a>
	                	<button type="button" class="btn btn-success" onclick="location.href='answerInsert?qnaNo=${qna.qnaNo}'">답변하기</button>
                	</c:when>
                	<c:otherwise>
               			<button type="button" class="btn btn-secondary" onclick="history.back()">뒤로가기</button>
                	</c:otherwise>
                </c:choose>
                
                <form method="post" action="" id="QnaPostForm">
                    <input type="hidden" name="qnaNo" value="${qna.qnaNo }" />
                    <input type="hidden" name="filePath" value="${imgFile.imgFilePath}">
                </form>
                <script>
                    function postSubmit(el) {
                        const attrValue = '수정하기' === el ? 'updateQna' : 'deleteQna';
                        $('#QnaPostForm').attr('action', attrValue).submit();
                    }
                </script>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp" />

</body>
</html>