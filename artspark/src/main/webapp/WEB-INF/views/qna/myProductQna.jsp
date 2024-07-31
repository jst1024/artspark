<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 문의</title>
</head>
<body>
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
                                    </c:if>
                                    <c:if test="${productQna.productAnswer == null}">
                                        <span class="badge bg-warning">답변미등록</span>
                                    </c:if>
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
</body>
</html>
