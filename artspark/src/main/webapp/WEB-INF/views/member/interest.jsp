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
        .star-rating {
            display: inline-block;
            font-size: 0;
            position: relative;
            width: 100px;
            height: 20px; 
            background: url('${path2}/resources/images/star-empty.png') repeat-x;
        }
        .star-rating::before {
            content: '';
            display: block;
            width: 0;
            height: 100%;
            background: url('${path2}/resources/images/star-full.png') repeat-x;
            position: absolute;
            top: 0;
            left: 0;
        }
        .star-rating[data-rating="0"]::before { width: 0%; }
        .star-rating[data-rating="0.1"]::before { width: 2%; }
        .star-rating[data-rating="0.2"]::before { width: 4%; }
        .star-rating[data-rating="0.3"]::before { width: 6%; }
        .star-rating[data-rating="0.4"]::before { width: 8%; }
        .star-rating[data-rating="0.5"]::before { width: 10%; }
        .star-rating[data-rating="0.6"]::before { width: 12%; }
        .star-rating[data-rating="0.7"]::before { width: 14%; }
        .star-rating[data-rating="0.8"]::before { width: 16%; }
        .star-rating[data-rating="0.9"]::before { width: 18%; }
        .star-rating[data-rating="1"]::before { width: 20%; }
        .star-rating[data-rating="1.1"]::before { width: 22%; }
        .star-rating[data-rating="1.2"]::before { width: 24%; }
        .star-rating[data-rating="1.3"]::before { width: 26%; }
        .star-rating[data-rating="1.4"]::before { width: 28%; }
        .star-rating[data-rating="1.5"]::before { width: 30%; }
        .star-rating[data-rating="1.6"]::before { width: 32%; }
        .star-rating[data-rating="1.7"]::before { width: 34%; }
        .star-rating[data-rating="1.8"]::before { width: 36%; }
        .star-rating[data-rating="1.9"]::before { width: 38%; }
        .star-rating[data-rating="2"]::before { width: 40%; }
        .star-rating[data-rating="2.1"]::before { width: 42%; }
        .star-rating[data-rating="2.2"]::before { width: 44%; }
        .star-rating[data-rating="2.3"]::before { width: 46%; }
        .star-rating[data-rating="2.4"]::before { width: 48%; }
        .star-rating[data-rating="2.5"]::before { width: 50%; }
        .star-rating[data-rating="2.6"]::before { width: 52%; }
        .star-rating[data-rating="2.7"]::before { width: 54%; }
        .star-rating[data-rating="2.8"]::before { width: 56%; }
        .star-rating[data-rating="2.9"]::before { width: 58%; }
        .star-rating[data-rating="3"]::before { width: 60%; }
        .star-rating[data-rating="3.1"]::before { width: 62%; }
        .star-rating[data-rating="3.2"]::before { width: 64%; }
        .star-rating[data-rating="3.3"]::before { width: 66%; }
        .star-rating[data-rating="3.4"]::before { width: 68%; }
        .star-rating[data-rating="3.5"]::before { width: 70%; }
        .star-rating[data-rating="3.6"]::before { width: 72%; }
        .star-rating[data-rating="3.7"]::before { width: 74%; }
        .star-rating[data-rating="3.8"]::before { width: 76%; }
        .star-rating[data-rating="3.9"]::before { width: 78%; }
        .star-rating[data-rating="4"]::before { width: 80%; }
        .star-rating[data-rating="4.1"]::before { width: 82%; }
        .star-rating[data-rating="4.2"]::before { width: 84%; }
        .star-rating[data-rating="4.3"]::before { width: 86%; }
        .star-rating[data-rating="4.4"]::before { width: 88%; }
        .star-rating[data-rating="4.5"]::before { width: 90%; }
        .star-rating[data-rating="4.6"]::before { width: 92%; }
        .star-rating[data-rating="4.7"]::before { width: 94%; }
        .star-rating[data-rating="4.8"]::before { width: 96%; }
        .star-rating[data-rating="4.9"]::before { width: 98%; }
        .star-rating[data-rating="5"]::before { width: 100%; }
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
              <c:forEach items="${interestThing}" var="seller" varStatus="status">
                  <div class="artist-card">
                      <div class="d-flex">
                          <div class="profile-image">
                              <img src="${seller.artistPath}" alt="작가 프로필" style="width: 100%; height: 100%; object-fit: cover;">
                              <input type="hidden" value="${seller.productNo }" id="pno"/> 
                          </div>
                          <div class="artist-info ml-3">
                              <div class="artist-name">작가 이름: ${seller.memNickname}</div>
                              <div class="star-rating" data-rating="${ seller.avgStar }"></div>
                          </div>
                      </div>
                      <div class="d-flex flex-column align-items-center">
                          <div class="image-placeholder-wrapper">
                                <c:forEach var="filePath" items="${seller.filePaths}" varStatus="status">
					        <c:if test="${status.index < 3}">
					            <div class="image-placeholder">
					            <a href="${path2}/product/${seller.productNo}" style="display: block; width: 100%; height: 100%;">
			                    <img src="${filePath}" alt="작품 이미지" style="width: 100%; height: 100%; object-fit: cover;">
			               		</a>
					            </div>
					        </c:if>
					    </c:forEach>
                          </div>
                          <div class="image-caption">${seller.productTitle}</div>
                      </div>
                      <div class="remove-button ml-3" onclick="remove('${seller.productNo}');">X</div>
                  </div>
              </c:forEach>
            </div>
        </div>
    <jsp:include page="../common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
	    function remove(productNo) {
	 		console.log(productNo);

	        $.ajax({
	            url: '${path2}/removeInterest',
	            type: 'POST',
	            data: {
	                productNo : productNo
	            },
	            success: response => {
	            	location.href="${path2 }/interestSeller";
	               
	            }
	        });
	    };
	</script>
</body>
</html>