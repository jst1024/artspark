<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .artist-card {
            padding: 20px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .artist-info {
            flex-grow: 1;
            margin-left: 20px;
        }
        .artist-name {
            font-size: 24px;
            font-weight: bold;
        }
        .rating {
            color: gold;
            font-size: 18px;
        }
        .image-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-left: 10px;
        }
        .image-placeholder-wrapper {
            display: flex;
            justify-content: space-between;
            width: 500px;
        }
        .image-placeholder {
            width: 200px;
            height: 150px;
            background-color: #f8f8f8;
            border: 1px solid #ddd;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .image-caption {
            font-size: 12px;
            padding-right: 350px;
        }
        .remove-button {
            font-size: 24px;
            color: red;
            cursor: pointer;
            align-self: flex-start;
        }
        .profile-image {
            width: 60px;
            height: 60px;
            background-color: #ddd;
            border-radius: 50%;
        }
        .form-group.text-end {
            margin-bottom: 20px;
        }
        .form-group.text-end .form-control {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <div class="container my-5">
        <h1 class="mb-4">마이페이지</h1>
        
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item" role="presentation">
                <a href="${path2 }/myPage"><button class="nav-link" id="order-tab" data-bs-toggle="tab" data-bs-target="#order" type="button">문의 답변</button></a>
            </li>
            <li class="nav-item" role="presentation">
                <a href="${path2 }/orderHistory"><button class="nav-link" id="order-tab" data-bs-toggle="tab" data-bs-target="#order" type="button">주문 관리</button></a>
            </li>
            <li class="nav-item" role="presentation">
                 <a href="${path2 }/interestSeller"><button class="nav-link" id="seller-tab" data-bs-toggle="tab" data-bs-target="#seller" type="button" role="tab">관심 작가</button></a>
            </li>
            <c:if test="${ sessionScope.loginUser.memCategory == 'A' }">
             <li class="nav-item" role="presentation">
                <a href="${path2 }/updatePage"><button class="nav-link" id="order-tab" data-bs-toggle="tab" data-bs-target="#order" type="button">회원 정보</button></a>
            </li>
            </c:if>
            <c:if test="${ sessionScope.loginUser.memCategory != 'A' }">
             <li class="nav-item" role="presentation">
                <a href="${path2 }/updateProduct"><button class="nav-link" id="order-tab" data-bs-toggle="tab" data-bs-target="#order" type="button">회원 정보</button></a>
            </li>
            </c:if>
        </ul>
        
        <div class="tab-content mt-3" id="myTabContent">
            <div class="tab-pane fade show active my-4" id="qna" role="tabpanel">
                <h2>문의 및 답변</h2>
		<div class="mt-3">
		  <c:choose>
		  	<c:when test="${empty artistQna}"> 
                        <tr>
                            <th>조회된 결과가 존재하지 않습니다.</th>
                        </tr>
            </c:when>
            <c:otherwise>
		    <c:forEach var="qna" items="${artistQna}">
		        <div class="card mb-3">
		            <div class="card-body">
		                <h5 class="card-title">${qna.qnaTitle}</h5>
		                <p class="card-text">${qna.qnaContent}</p>
		                <p class="card-text">
		                    <small class="text-muted">${qna.qnaDate}</small>
		                </p>
		            </div>
		        </div>
		        </c:forEach>
		    </c:otherwise>
		   </c:choose>
		</div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="showDeleted">
                            <label class="form-check-label" for="showDeleted">삭제된 문의 보기</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="showAnswered">
                            <label class="form-check-label" for="showAnswered">내용검색</label>
                        </div>
                        <div class="input-group w-auto d-inline-flex align-middle">
                            <input type="text" class="form-control" placeholder="작성자/제목">
                            <button class="btn btn-primary" type="button">검색</button>
                        </div>
                    </div>
                </div>
            </div>
    <jsp:include page="../common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>