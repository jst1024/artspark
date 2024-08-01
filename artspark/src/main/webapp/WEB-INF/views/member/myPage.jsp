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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .badge {
            display: inline-block;
            padding: 0.5em 0.75em;
            font-size: 75%;
            font-weight: 700;
            line-height: 1;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
            border-radius: 0.375rem;
        }
        .collapse.show {
            display: block;
            animation: slide-down 0.3s ease-out;
        }
        @keyframes slide-down {
            0% {
                opacity: 0;
                transform: translateY(-10%);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }
        table {
            table-layout: fixed;
            width: 100%;
        }
        th, td {
            word-wrap: break-word;
        }
        .thumbnail {
            width: 100px;
            height: 100px;
        }
        .modal-img {
            width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <div class="container my-5">
        <h1 class="mb-4">마이페이지</h1>
        
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item" role="presentation">
                <a href="${path2}/myPage"><button class="nav-link active" id="qna-tab" data-bs-toggle="tab" data-bs-target="#qna" type="button">문의 답변</button></a>
            </li>
            <li class="nav-item" role="presentation">
                <a href="${path2}/orderHistory"><button class="nav-link" id="order-tab" data-bs-toggle="tab" data-bs-target="#order" type="button">주문 관리</button></a>
            </li>
            <li class="nav-item" role="presentation">
                <a href="${path2}/interestSeller"><button class="nav-link" id="seller-tab" data-bs-toggle="tab" data-bs-target="#seller" type="button">관심 작가</button></a>
            </li>
            <c:if test="${sessionScope.loginUser.memCategory == 'A'}">
                <li class="nav-item" role="presentation">
                    <a href="${path2}/updatePage"><button class="nav-link" id="order-tab" data-bs-toggle="tab" data-bs-target="#order" type="button">회원 정보</button></a>
                </li>
            </c:if>
            <c:if test="${sessionScope.loginUser.memCategory != 'A'}">
                <li class="nav-item" role="presentation">
                    <a href="${path2}/updateProduct"><button class="nav-link" id="order-tab" data-bs-toggle="tab" data-bs-target="#order" type="button">회원 정보</button></a>
                </li>
            </c:if>
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
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>제목</th>
                                        <th>내용</th>
                                        <th>날짜</th>
                                        <th>답변 상태</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty myQna}">
                                            <tr>
                                                <td colspan="5">조회된 결과가 존재하지 않습니다.</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="qna" items="${myQna}">
                                                <tr>
                                                    <td>${qna.qnaNo}</td>
                                                    <td>${qna.qnaTitle}</td>
                                                    <td>${qna.qnaContent}</td>
                                                    <td>${qna.qnaDate}</td>
                                                    <td>
                                                        <c:if test="${qna.answerContent != null}">
                                                            <span class="badge bg-success">답변완료</span>
                                                            <button class="btn btn-sm btn-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#answerCollapse${qna.qnaNo}" aria-expanded="false" aria-controls="answerCollapse${qna.qnaNo}">
                                                                답변 보기
                                                            </button>
                                                            <div class="collapse" id="answerCollapse${qna.qnaNo}">
                                                                <div class="card card-body bg-light">
                                                                    ${qna.answerContent}
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${qna.answerContent == null}">
                                                            <span class="badge bg-warning">답변미등록</span>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <!-- 판매자 문의 탭 -->
                    <div class="tab-pane fade" id="productQuestions" role="tabpanel">
                        <h2>판매자에게 문의한 내용</h2>
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>제목</th>
                                        <th>내용</th>
                                        <th>이미지</th>
                                        <th>날짜</th>
                                        <th>답변 상태</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty myProductQna}">
                                            <tr>
                                                <td colspan="6">조회된 결과가 존재하지 않습니다.</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="productQna" items="${myProductQna}">
                                                <tr>
                                                    <td>${productQna.qnaNo}</td>
                                                    <td>${productQna.qnaTitle}</td>
                                                    <td>${productQna.qnaContent}</td>
                                                    <td>
                                                        <c:if test="${productQna.qnaFilePath != null}">
                                                            <img src="${path2 }/${productQna.qnaFilePath}" class="thumbnail" alt="첨부 이미지" data-bs-toggle="modal" data-bs-target="#imageModal${productQna.qnaNo}">
                                                        </c:if>
                                                    </td>
                                                    <td>${productQna.qnaDate}</td>
                                                    <td>
                                                        <c:if test="${productQna.productAnswer != null}">
                                                            <span class="badge bg-success">답변완료</span>
                                                            <button class="btn btn-sm btn-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#answerCollapse${productQna.qnaNo}" aria-expanded="false" aria-controls="answerCollapse${productQna.qnaNo}">
                                                                답변 보기
                                                            </button>
                                                        </c:if>
                                                        <c:if test="${productQna.productAnswer == null}">
                                                            <span class="badge bg-warning">답변미등록</span>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6">
                                                        <div class="collapse" id="answerCollapse${productQna.qnaNo}">
                                                            <div class="card card-body bg-light">
                                                                <div class="row">
                                                                    <div class="col-md-3">
                                                                        <h5>${productQna.productAnswer.answerTitle}</h5>
                                                                    </div>
                                                                    <div class="col-md-4">
                                                                        <p>${productQna.productAnswer.answerContent}</p>
                                                                        <p class="text-muted">답변 작성자: ${productQna.productAnswer.memId}</p>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <c:if test="${productQna.productAnswer.answerFilePath != null}">
                                                                            <img src="${path2 }/${productQna.productAnswer.answerFilePath}" class="thumbnail" alt="첨부 이미지" data-bs-toggle="modal" data-bs-target="#imageModal${productQna.qnaNo}Answer">
                                                                        </c:if>
                                                                    </div>
                                                                    <div class="col-md-2">
                                                                        <p class="text-muted">${productQna.productAnswer.answerDate}</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>

                                                <!-- 문의 이미지 모달 -->
                                                <div class="modal fade" id="imageModal${productQna.qnaNo}" tabindex="-1" aria-labelledby="imageModalLabel${productQna.qnaNo}" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="imageModalLabel${productQna.qnaNo}">첨부 이미지</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <img src="${path2 }/${productQna.qnaFilePath}" class="modal-img" alt="첨부 이미지">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- 답변 이미지 모달 -->
                                                <div class="modal fade" id="imageModal${productQna.qnaNo}Answer" tabindex="-1" aria-labelledby="imageModalLabel${productQna.qnaNo}Answer" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="imageModalLabel${productQna.qnaNo}Answer">첨부 이미지</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <img src="${path2 }/${productQna.productAnswer.answerFilePath}" class="modal-img" alt="첨부 이미지">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- 내 상품에 대한 문의 탭 -->
                    <div class="tab-pane fade" id="receivedQuestions" role="tabpanel">
                        <h2>내 상품에 대한 문의</h2>
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>제목</th>
                                        <th>내용</th>
                                        <th>날짜</th>
                                        <th>답변 상태</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty receivedProductQna}">
                                            <tr>
                                                <td colspan="5">조회된 결과가 존재하지 않습니다.</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="productQna" items="${receivedProductQna}">
                                                <tr>
                                                    <td>${productQna.qnaNo}</td>
                                                    <td>${productQna.qnaTitle}</td>
                                                    <td>${productQna.qnaContent}</td>
                                                    <td>${productQna.qnaDate}</td>
                                                    <td>
                                                        <c:if test="${productQna.productAnswer != null}">
                                                            <span class="badge bg-success">답변완료</span>
                                                            <button class="btn btn-sm btn-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#answerCollapse${productQna.qnaNo}" aria-expanded="false" aria-controls="answerCollapse${productQna.qnaNo}">
                                                                답변 보기
                                                            </button>
                                                        </c:if>
                                                        <c:if test="${productQna.productAnswer == null}">
                                                            <button class="btn btn-success" onclick="location.href='productAnswerInsert?qnaNo=${productQna.qnaNo}'">답변하기</button>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="5">
                                                        <div class="collapse" id="answerCollapse${productQna.qnaNo}">
                                                            <div class="card card-body bg-light">
                                                                <div class="row">
                                                                    <div class="col-md-3">
                                                                        <h5>${productQna.productAnswer.answerTitle}</h5>
                                                                    </div>
                                                                    <div class="col-md-4">
                                                                        <p>${productQna.productAnswer.answerContent}</p>
                                                                        <p class="text-muted">답변 작성자: ${productQna.productAnswer.memId}</p>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <c:if test="${productQna.productAnswer.answerFilePath != null}">
                                                                            <img src="${path2 }/${productQna.productAnswer.answerFilePath}" class="thumbnail" alt="첨부 이미지" data-bs-toggle="modal" data-bs-target="#imageModal${productQna.qnaNo}AnswerReceived">
                                                                        </c:if>
                                                                    </div>
                                                                    <div class="col-md-2">
                                                                        <p class="text-muted">${productQna.productAnswer.answerDate}</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>

                                                <!-- 답변 이미지 모달 -->
                                                <div class="modal fade" id="imageModal${productQna.qnaNo}AnswerReceived" tabindex="-1" aria-labelledby="imageModalLabel${productQna.qnaNo}AnswerReceived" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="imageModalLabel${productQna.qnaNo}AnswerReceived">첨부 이미지</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <img src="${path2 }/${productQna.productAnswer.answerFilePath}" class="modal-img" alt="첨부 이미지">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div> 
            </div>
        </div>
    </div> 
    
    <jsp:include page="../common/footer.jsp"/>

</body>
</html>
