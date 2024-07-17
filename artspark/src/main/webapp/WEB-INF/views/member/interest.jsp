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
        /* ... (스타일 코드) ... */
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <div class="container my-5">
        <h1 class="mb-4">마이페이지</h1>
        
        
        <div class="tab-pane fade my-4" id="favorite" role="tabpanel">
            <h2 class="mb-4">관심 작가</h2>
            <div class="form-group text-end">
                <input type="text" class="form-control d-inline-block" placeholder="작가명" style="width: 200px;">
                <button type="button" class="btn btn-primary ml-2">검색</button>
            </div>

            <div class="artist-card">
                <div class="d-flex">
                    <div class="profile-image"></div>
                    <div class="artist-info ml-3">
                    <c:forEach items="${ interestThing }" var="seller">
                        <div class="artist-card">
                            <div class="d-flex">
                                <div class="profile-image">${ seller.artistPath }</div>
                                <div class="artist-info ml-3">
                                    <div class="artist-name">작가 이름 ${seller.memNickname}</div>
                                    <div class="rating">평점 ${seller.reviewStar}</div>
                                </div>
                            </div>
                            <div class="d-flex flex-column align-items-center">
                                <div class="image-placeholder-wrapper">
                                    <div class="image-placeholder">${seller.filePath}</div>
                                    <div class="image-placeholder">${seller.filePath}</div>
                                    <div class="image-placeholder">${seller.filePath}</div>
                                </div>
                                <div class="image-caption">${seller.productTitle}</div>
                            </div>
                            <div class="remove-button ml-3">X</div>
                        </div>
                    </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>