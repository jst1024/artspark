<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 문의</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
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
</body>
</html>
