<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 상품에 대한 문의</title>
</head>
<body>
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
</body>
</html>
