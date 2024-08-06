<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 확인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <!-- 모달 -->
    <div class="modal fade" id="idCheckModal" tabindex="-1" aria-labelledby="idCheckModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="idCheckModalLabel">아이디 확인</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h4 class="text-center mb-4">회원님의 아이디를 확인해 주세요</h4>
                    
                    <c:choose>
                        <c:when test="${not empty foundId}">
                            <div class="result-box border border-success text-success p-3 mb-4 text-center">
                                아이디: ${foundId}
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="result-box border border-danger text-danger p-3 mb-4 text-center">
                                조회결과가 없습니다.
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="btn-group w-100">
                        <a href="loginPage" class="btn btn-secondary">로그인하기</a>
                        <a href="lostPwd" class="btn btn-primary">비밀번호찾기</a>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var myModal = new bootstrap.Modal(document.getElementById('idCheckModal'));
            myModal.show();
        });
    </script>
</body>
</html>
