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
            width: 150px;
            height: 150px;
            background-color: #f8f8f8;
            border: 1px solid #ddd;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
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
            overflow: hidden;
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
                <button class="nav-link" id="inquiry-tab" data-bs-toggle="tab" data-bs-target="#inquiry" type="button" role="tab">문의 및 답변</button>
            </li>
            <li class="nav-item" role="presentation">
                <a href="${path2 }/orderHistory"><button class="nav-link" id="order-tab" data-bs-toggle="tab" data-bs-target="#order" type="button">주문 관리</button></a>
            </li>
            <li class="nav-item" role="presentation">
                 <a href="${path2 }/interestSeller"><button class="nav-link active" id="seller-tab" data-bs-toggle="tab" data-bs-target="#seller" type="button" role="tab">관심 작가</button></a>
            </li>
        </ul>
        
        <div class="tab-content mt-3" id="myTabContent">
            <div class="tab-pane fade show active my-4" id="seller" role="tabpanel">
                <h2 class="mb-4">관심 작가</h2>
                <div class="form-group text-end">
                    <input type="text" class="form-control d-inline-block" placeholder="작가명" style="width: 200px;">
                    <button type="button" class="btn btn-primary ml-2">검색</button>
                </div>
                <c:forEach items="${interestThing}" var="seller" varStatus="status" step="3">
                    <div class="artist-card">
                        <div class="d-flex">
                            <div class="profile-image">
                                <img src="${seller.artistPath}"  style="width: 100%; height: 100%; object-fit: cover;">
                            </div>
                            <div class="artist-info ml-3">
                                <div class="artist-name">작가 이름: ${seller.memNickname}</div>
                                <div class="rating">평점: ${seller.reviewStar}</div>
                            </div>
                        </div>
                        <div class="d-flex flex-column align-items-center">
                            <div class="image-placeholder-wrapper">
                                <c:forEach begin="${status.index}" end="${status.index + 2}" items="${interestThing}" var="image">
                                    <div class="image-placeholder">
                                        <img src="${image.filePath}" alt="작품 이미지" style="width: 100%; height: 100%; object-fit: cover;">
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="image-caption">${seller.productTitle}</div>
                        </div>
                        <div class="remove-button ml-3">X</div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>