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
    <title>주문 관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 기존 스타일 유지 */
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <div class="container my-5">
        <h1 class="mb-4">주문 관리</h1>
        
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>주문 번호</th>
                        <th>작가 이미지</th>
                        <th>작가 닉네임</th>
                        <th>주문 내용</th>
                        <th>결제 금액</th>
                        <th>주문 상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orderBuyOptions}" var="order">
                        <tr>
                            <td>${order.buyNo}</td>
                            <td><img src="${ path2 }${order.artistPath}" alt="작가 이미지" style="width: 90px; height: 100px;"></td>
                            <td>${order.memNickname}</td>
                            
                            <td>
                            	${ order.productPurpose } / ${ order.productTitle }<br>
                            	<c:forEach items="${order.buyOptionList }" var="buyOptionList">
                            		${ buyOptionList.buyOptionName}/${buyOptionList.buyDetailOptionName}/${ buyOptionList.buyOptionPrice }/${ buyOptionList.buyOptionAmount }<br>
                            	</c:forEach>
                            </td>
                            <td><fmt:formatNumber value="${order.totalAmount }" type="currency" currencySymbol="₩" /></td>
                            
                            <td>
                                <button class="btn btn-sm btn-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#detailsCollapse${order.buyNo}" aria-expanded="false" aria-controls="detailsCollapse${order.buyNo}">
                                    자세히
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <div class="collapse" id="detailsCollapse${order.buyNo}">
                                    <div class="card card-body bg-light">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <p><strong>결제일 : </strong><fmt:formatDate value="${order.paymentDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                                                <p><strong>원본제작일 : </strong>${order.detailWorkdate}</p>
                                                <p><strong>제출 파일 유형 : </strong>${order.detailType}</p>
                                                <p><strong>해상도 : </strong>${order.detailPixel}dpi</p>
                                            </div>
                                            <div class="col-md-6">
                                                <p><strong>기본 사이즈 : </strong>${order.detailSize}</p>
                                                <p><strong>수정 횟수 : </strong>${order.updateCount}회</p>
                                                <p><strong>작업 기간 : </strong>${order.detailWorkdate}일</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>