<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Q&A 목록</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .container-main {
            max-width: 1920px;
            margin: 0 auto;
            padding: 15px;
        }
        .pagination-custom {
            justify-content: center;
        }
        .write-btn {
            float: right;
        }
        .table-wrapper {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            overflow-x: auto;
        }
        .search-form {
            display: flex;
            justify-content: flex-start;
            margin-bottom: 25px;
            margin-left : 335px;
        }
        #qnaList {text-align:center;}
        #qnaList>tbody>tr:hover {cursor:pointer;}
        #pagingArea {width:fit-content; margin:auto; margin-top:30px;}
        #searchForm {
            width:80%;
            margin:auto;
        }
        .select {width:20%;}
        .text {width:53%;}
        .searchBtn {width:20%;}
        @media (max-width: 768px) {
            .search-form {
                flex-direction: column;
                align-items: flex-start;
            }
            .search-form select, .search-form input, .search-form button {
                width: 100%;
                margin-bottom: 10px;
            }
        }
        .answer {
            background-color: #f9f9f9;
        }
        .private-icon::before {
            content: "\1F512";
            margin-right: 5px;
        }
    </style>
</head>
<body>

<jsp:include page="../common/header.jsp" />

<div class="container-main">
    <div class="search-form">
        <form class="form-inline" action="qnaSearchCount">
            <select class="custom-select mr-2" name="condition">
                <option selected value="title">제목</option>
                <option value="content">내용</option>
                <option value="writer">작성자</option>
            </select>
            <input class="form-control mr-2" type="text" placeholder="검색" name="keyword" value="${keyword}">
            <button class="btn btn-primary" type="submit">검색</button>
        </form>
    </div>
    
    <script>
    $(() => {
        $('#searchForm option[value="${condition}"]').attr('selected', true);
    });
    </script>
    
    <div class="table-wrapper">
        <table class="table table-hover" id="qnaList">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty qnaList}">
                        <tr>
                            <td colspan="4">조회된 결과가 존재하지 않습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="qna" items="${qnaList}" varStatus="status">
                            <tr class="qna-Detail ${qna.secret == 'Y' ? 'secret' : ''}">
                                <td>${qna.qnaNo}</td>
                                <td>
                                    <c:if test="${qna.secret == 'Y'}">
                                        <span class="private-icon"></span>
                                    </c:if>
                                    ${qna.qnaTitle}
                                </td>
                                <td>${qna.memId}</td>
                                <td>${qna.qnaDate}</td>
                            </tr>
                            <c:if test="${empty qna.answers}"/>	
                            </c:forEach>
                            <c:if test="${not empty qna.answers}">
                                <c:forEach var="answer" items="${qna.answers}">
                                    <tr class="answer">
                                        <td></td>
                                        <td colspan="3" style="text-indent: ${answer.answerIndent * 20}px;">
                                            <strong>답변: </strong> ${answer.answerTitle}
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
    
     <script>
           $(() => {
               $('.qna-Detail').click(e => {
                   const qnaNo = $(e.currentTarget).children().eq(0).text();
                   const secret = $(e.currentTarget).hasClass('secret'); 
                   const currentUserId = '${sessionScope.loginUser.memId}';
                   const isAdmin = currentUserId === 'admin';
                   const qnaMemId = $(e.currentTarget).children().eq(2).text();
                   
                   if (secret) {
                       if (isAdmin || qnaMemId === currentUserId) {
                           // 관리자 또는 작성자인 경우 접근 허용
                           location.href = 'qnaDetail?qnaNo=' + qnaNo;
                       } else {
                           // 그 외의 경우 접근 불가
                           alert('비밀글은 작성자와 관리자만 볼 수 있습니다.');
                       }
                   } else {
                       // 비밀글이 아닌 경우 접근 허용
                       location.href = 'qnaDetail?qnaNo=' + qnaNo;
                   }
               });
               $('.request-Detail').click(e => {
                   location.href = 'requestDetail?reqNo=' + $(e.currentTarget).children().eq(0).text();
               });
           });
    </script>
    
    <!-- 페이징 -->
    <div id="pagingArea">
        <ul class="pagination pagination-custom">
            <!-- 이전 -->
            <c:choose>
                <c:when test="${pageInfo.startPage eq pageInfo.currentPage || empty qnaList }">
                    <li class="page-item disabled">
                        <a class="page-link" href="#">이전</a>
                    </li>
                </c:when>
                <c:when test="${empty condition}">
                    <li>
                        <a class="page-link" href="qnalist?page=${pageInfo.currentPage - 1}">이전</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li>
                        <a class="page-link" href="qnaSearch?page=${pageInfo.currentPage - 1}&condition=${condition}&keyword=${keyword}">이전</a>
                    </li>
                </c:otherwise>
            </c:choose>
            
            <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="p">
                <c:choose>
                    <c:when test="${empty condition}">
                        <li class="page-item">
                            <a class="page-link" href="qnalist?page=${p}">${p}</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="qnaSearch?page=${p}&condition=${condition}&keyword=${keyword}">${p}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            
            <!-- 다음 -->
            <c:choose>
                <c:when test="${pageInfo.maxPage eq pageInfo.currentPage || empty qnaList }">
                    <li class="page-item disabled">
                        <a class="page-link" href="#">다음</a>
                    </li>
                </c:when>
                <c:when test="${empty condition}">
                    <li class="page-item">
                        <a class="page-link" href="qnalist?page=${pageInfo.currentPage + 1}">다음</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item">
                        <a class="page-link" href="qnaSearch?page=${pageInfo.currentPage + 1}&condition=${condition}&keyword=${keyword}">다음</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
    
    <c:if test="${not empty sessionScope.loginUser}">
        <a class="btn btn-secondary write-btn" href="qnaInsert">질문하기</a>
    </c:if>
</div>

<jsp:include page="../common/footer.jsp" />

</body>
</html>
