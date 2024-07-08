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
    <title>판매자 페이지</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .dashboard-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .card {
            padding: 20px;
            background-color: lightgray;
            border-radius: 10px;
        }
        .order-status, .review-claim, .sales-statistics, .product, .inquiry {
            flex: 1 1 calc(33.333% - 20px);
        }
        .sales-statistics {
            flex: 1 1 100%;
        }
    </style>
</head>
<body>
    <div class="container">
        <jsp:include page="../common/sidebar.jsp"/>
            <div class="col-md-10">
                <div class="dashboard-container">
                    <div class="card order-status">
                        <h5>주문 / 정산</h5>
                        <p>결제대기 0건</p>
                        <p>신규주문 0건</p>
                        <p>구매확정 0건</p>
                        <p>오늘 정산 0건</p>
                        <p>환불 예정 0건</p>
                    </div>
                    <div class="card review-claim">
                        <h5>리뷰 / 클레임</h5>
                        <p>새로 작성된 리뷰 0건</p>
                        <p>평점 낮은 리뷰 0건</p>
                        <p>취소요청 0건</p>
                    </div>
                    <div class="card product">
                        <h5>상품</h5>
                        <img src="path/to/product-image.png" alt="Product" class="img-fluid">
                        <div class="d-flex mt-2">
                            <img src="path/to/star-icon.png" alt="Rating" class="img-fluid" style="width: 20px;">
                            <img src="path/to/star-icon.png" alt="Rating" class="img-fluid" style="width: 20px;">
                            <img src="path/to/star-icon.png" alt="Rating" class="img-fluid" style="width: 20px;">
                            <img src="path/to/star-icon.png" alt="Rating" class="img-fluid" style="width: 20px;">
                            <img src="path/to/star-icon.png" alt="Rating" class="img-fluid" style="width: 20px;">
                        </div>
                    </div>
                    <div class="card inquiry">
                        <h5>문의</h5>
                        <div class="nav nav-tabs">
                            <a class="nav-item nav-link active" href="#">상품 문의</a>
                            <a class="nav-item nav-link" href="#">고객 문의</a>
                        </div>
                        <div class="tab-content mt-2">
                            <div class="tab-pane fade show active">
                                <p>상품 문의 내용</p>
                            </div>
                            <div class="tab-pane fade">
                                <p>고객 문의 내용</p>
                            </div>
                        </div>
                    </div>
                    <div class="card sales-statistics">
                        <h5>매출통계</h5>
                        <img src="path/to/sales-graph.png" alt="Sales Statistics" class="img-fluid">
                    </div>
                </div>
            </div>
        </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
