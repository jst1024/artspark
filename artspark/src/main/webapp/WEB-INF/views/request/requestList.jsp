<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>의뢰게시글 목록(Request)</title>
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
            justify-content: flex-end;
            margin-bottom: 15px;
            margin-right: 15px;
        }
        #requestList { text-align: center; }
        #requestList>tbody>tr:hover { cursor: pointer; }

        #pagingArea { width: fit-content; margin: auto; }

        #searchForm {
            width: 80%;
            margin: auto;
        }
        .select { width: 20%; }
        .text { width: 53%; }
        .searchBtn { width: 20%; }
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
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="container-main">
        <div class="table-wrapper">
            <form class="form-inline mb-3 search-form" action="requestSearchCount">
                <select class="form-control mr-2 select" name="condition">
                    <option selected value="title">제목</option>
                    <option value="writer">작성자</option>
                    <option value="content">내용</option>
                </select>
                <select class="form-control mr-2 select" name="category">
                    <option value="일러스트" selected>일러스트</option>
                    <option value="디자인">디자인</option>
                    <option value="영상">영상</option>
                    <option value="웹툰">웹툰</option>
                </select>
                <input class="form-control mr-2 text" type="text" placeholder="검색" name="keyword" value="${keyword}">
                <button class="btn btn-primary btn-sm searchBtn" style="width: 80px;" type="submit">검색</button>
            </form>
            
            <table class="table table-hover" id="requestList">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>용도</th>
                        <th>제목</th>
                        <th>카테고리</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty requestList}">
                            <tr>
                                <td colspan="7">조회된 결과가 존재하지 않습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="request" items="${requestList}" varStatus="status">
                                <tr class="request-Detail">
                                    <td>${request.reqNo}</td>
                                    <td>${request.reqPurpose}</td>
                                    <td>${request.reqTitle}</td>
                                    <td>${request.reqCategory}</td>
                                    <td>${request.memId}</td>
                                    <td>${request.reqDate}</td>
                                    <td>${request.reqCount}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            <script>
                $(() => {
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
                        <c:when test="${ pageInfo.startPage eq pageInfo.currentPage }">
                            <li class="page-item disabled">
                                <a class="page-link" href="#">이전</a>
                            </li>
                        </c:when>
                        <c:when test="${ empty condition }">
                            <li>
                                <a class="page-link" href="requestlist?page=${ pageInfo.currentPage - 1 }">이전</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a class="page-link" href="requestSearch?page=${ pageInfo.currentPage - 1 }&condition=${condition}&keyword=${keyword }">이전</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                    <!-- 번호 목록 -->
                    <c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" var="p" >
                        <c:choose>
                            <c:when test="${ empty condition }">
                                <li class="page-item">
                                    <a class="page-link" href="requestlist?page=${ p }">${ p }</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link" href="requestSearch?page=${ p }&condition=${condition}&keyword=${keyword }">${ p }</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <!-- 다음 -->
                    <c:choose>
                        <c:when test="${ pageInfo.maxPage eq pageInfo.currentPage }">
                            <li class="page-item disabled">
                                <a class="page-link" href="#">다음</a>
                            </li>
                        </c:when>
                        <c:when test="${ empty condition }">
                            <li class="page-item">
                                <a class="page-link" href="requestlist?page=${ pageInfo.currentPage + 1 }">다음</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a class="page-link" href="requestSearch?page=${ pageInfo.currentPage + 1 }&condition=${condition}&keyword=${keyword }">다음</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            <c:if test="${not empty sessionScope.loginUser}">
                <a class="btn btn-secondary btn-warning write-btn" href="requestInsert">글쓰기</a>
            </c:if>
        </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
    
</body>
</html>
