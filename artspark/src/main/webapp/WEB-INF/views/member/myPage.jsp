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
        .btn-orange {
            background-color: orange;
            color: white;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <div class="container my-5">
        <h1 class="mb-4">마이페이지</h1>
        
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item" role="presentation">
                <a href="${path2 }/myPage"><button class="nav-link active" id="qna-tab" data-bs-toggle="tab" data-bs-target="#qna" type="button">문의 답변</button></a>
            </li>
            <li class="nav-item" role="presentation">
                <a href="${path2 }/orderHistory"><button class="nav-link" id="order-tab" data-bs-toggle="tab" data-bs-target="#order" type="button">주문 관리</button></a>
            </li>
            <li class="nav-item" role="presentation">
                <a href="${path2 }/interestSeller"><button class="nav-link" id="seller-tab" data-bs-toggle="tab" data-bs-target="#seller" type="button">관심 작가</button></a>
            </li>
        </ul>
        
        <div class="tab-content mt-3" id="myTabContent">
            <div class="tab-pane fade show active my-4" id="qna" role="tabpanel">
                <ul class="nav nav-tabs" id="innerTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="adminQuestions-tab" data-bs-toggle="tab" data-bs-target="#adminQuestions" type="button">관리자 문의</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="productQuestions-tab" data-bs-toggle="tab" data-bs-target="#productQuestions" type="button">판매자 문의</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="receivedQuestions-tab" data-bs-toggle="tab" data-bs-target="#receivedQuestions" type="button">내 상품에 대한 문의</button>
                    </li>
                </ul>
                
                <div class="tab-content mt-3" id="innerTabContent">
                    <!-- 관리자 문의 탭 -->
                    <div class="tab-pane fade show active" id="adminQuestions" role="tabpanel">
                        <h2>관리자에게 문의한 내용</h2>
                        <div class="mt-3">
                            <c:choose>
                                <c:when test="${empty myQna}">
                                    <div>조회된 결과가 존재하지 않습니다.</div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="qna" items="${myQna}">
                                        <div class="card mb-3">
                                            <div class="card-body">
                                                <h5 class="card-title">${qna.qnaTitle}</h5>
                                                <p class="card-text">${qna.qnaContent}</p>
                                                <p class="card-text">
                                                    <small class="text-muted">${qna.qnaDate}</small>
                                                </p>
                                                <c:if test="${qna.answerNo != null}">
                                                    <span class="badge bg-success">답변완료</span>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <!-- 판매자 문의 탭 -->
                    <div class="tab-pane fade" id="productQuestions" role="tabpanel">
                        <h2>판매자에게 문의한 내용</h2>
                        <div class="mt-3">
                            <c:choose>
                                <c:when test="${empty myProductQna}">
                                    <div>조회된 결과가 존재하지 않습니다.</div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="productQna" items="${myProductQna}">
                                        <div class="card mb-3">
                                            <div class="card-body">
                                                <h5 class="card-title">${productQna.qnaTitle}</h5>
                                                <p class="card-text">${productQna.qnaContent}</p>
                                                <p class="card-text">
                                                    <small class="text-muted">${productQna.qnaDate}</small>
                                                </p>
                                                <c:if test="${productQna.answer != null}">
                                                    <span class="badge bg-success">답변완료</span>
                                                </c:if>
                                                <a href="${path2}/product/${productQna.productNo}" class="btn btn-primary mt-2">해당 상품 페이지로 이동</a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <!-- 내 상품에 대한 문의 탭 -->
                    <div class="tab-pane fade" id="receivedQuestions" role="tabpanel">
                        <h2>내 상품에 대한 문의</h2>
                        <div class="mt-3">
                            <c:choose>
                                <c:when test="${empty receivedProductQna}">
                                    <div>조회된 결과가 존재하지 않습니다.</div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="productQna" items="${receivedProductQna}">
                                        <div class="card mb-3" style="cursor: pointer;" onclick="location.href='${path2}/product/${productQna.productNo}'">
                                            <div class="card-body">
                                                <h5 class="card-title">${productQna.qnaTitle}</h5>
                                                <p class="card-text">${productQna.qnaContent}</p>
                                                <p class="card-text">
                                                    <small class="text-muted">${productQna.qnaDate}</small>
                                                </p>
                                                <c:if test="${productQna.answer != null}">
                                                    <span class="badge bg-success">답변완료</span>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
